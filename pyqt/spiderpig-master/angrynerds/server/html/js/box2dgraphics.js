// TODO background should be a level-defined object

var b2Body = Box2D.Dynamics.b2Body;

// Class / constructor
function Box2dGraphics(canvas, box2dWorld, worldToScreenFactor, offsetX, offsetY, bgColor) {

    this.canvas = canvas;
    this.world = box2dWorld;
    this.context = canvas.getContext("2d");
    this.drawScale = worldToScreenFactor;
    this.offsetX = offsetX;
    this.offsetY = offsetY;
    this.debug = false;

    var lingrad = this.context.createLinearGradient(0,0,0,canvas.height);
    lingrad.addColorStop(0, '#4ea9ef');
    lingrad.addColorStop(1, '#106bb1');
    this.background = lingrad;

    this.paint = function() {

        // redraw background
        //this.drawRect(rect(0, 0, canvas.width, canvas.height), "#CCC", "black", 1);
        this.drawRect(rect(0, 0, canvas.width, canvas.height), this.background, "black", 1);

        var body = this.world.GetBodyList();

        for (var i=0; i < this.world.GetBodyCount(); i++) {
            //if (body.GetType() == b2Body.b2_dynamicBody) {
            if (body.GetUserData()) {
                var shape = body.GetUserData().shape;
                //console.log(shape);
                this.drawObject(body);
            }
            body = body.GetNext();
        }
    }

    this.drawObject = function(body) {
        var pos = body.GetPosition();
        var x = (this.offsetX + pos.x) * this.drawScale ;
        var y = (this.offsetY + pos.y) * this.drawScale;
        var w = 20, h = 20;
        var data = body.GetUserData();
        if (data.shape == "rect") {
            w = data.width * this.drawScale;
            h = data.height * this.drawScale;
            //this.drawRect(rect(x-w/2, y-h/2, w, h));
            this.drawRectRotated(rect(x, y, w, h), body.GetAngle(), data.fill, data.stroke, data.strokeWidth);
        }
        else if (data.shape == "image") {
            w = data.width * this.drawScale;
            h = data.height * this.drawScale;
            this.drawImageRotated(data.imageObj, rect(x, y, w, h), body.GetAngle());
        }
        else if (data.shape == "circle") {
            w = data.radius * this.drawScale * 2;
            h = data.radius * this.drawScale * 2;
            r = data.radius * this.drawScale;
            this.drawCircle(x, y, r, data.fill, data.stroke, data.strokeWidth);
            if (data.imageObj) {
                this.drawImageRotated(data.imageObj, rect(x, y, r*2, r*2), body.GetAngle());
            }

        }

        if (this.debug)
            this.drawDebugInfo(body, x, y);
    }

    this.drawDebugInfo = function(body, x, y) {
        var ctx = this.context;
        ctx.fillStyle = "black";
        ctx.font = "italic bold 10px sans-serif";
        ctx.fillText(body.GetUserData().name, x, y);
        if (body.GetUserData().health)
            ctx.fillText("H:" + body.GetUserData().health + "%", x, y + 11);
    }

    this.drawRect = function(rect, fill, stroke, strokeWidth) {
        var ctx = this.context;
        ctx.beginPath();
        ctx.rect(rect.x, rect.y, rect.w, rect.h);
        ctx.fillStyle = fill;
        ctx.fill();
        ctx.lineWidth = strokeWidth;
        ctx.strokeStyle = stroke;
        ctx.stroke();
    }

    this.drawImageRotated = function(imageObj, rect, angle) {
        var context = this.context;
        context.save();
        context.translate(rect.x, rect.y);
        context.rotate(angle);

        context.beginPath();
        context.drawImage(imageObj, -rect.w/2, -rect.h/2, rect.w, rect.h);

        context.restore();
    }

    this.drawRectRotated = function(rect, angle, fill, stroke, strokeWidth) {
        var context = this.context;
        context.save();
        context.translate(rect.x, rect.y);
        context.rotate(angle);

        context.beginPath();
        context.rect(-rect.w/2, -rect.h/2, rect.w, rect.h);
        context.fillStyle = fill;
        context.fill();
        context.lineWidth = strokeWidth;
        context.strokeStyle = stroke;
        context.stroke();

        context.restore();
    }

    this.drawCircle = function(x, y, r, fill, stroke, strokeWidth) {
        var ctx = this.context;
        ctx.beginPath();
        ctx.arc(x, y, r, 0, 2*Math.PI, false);
        ctx.fillStyle = fill;
        ctx.fill();
        ctx.lineWidth = strokeWidth;
        ctx.strokeStyle = stroke;
        ctx.stroke();
    }

} // class Box2dGraphics


function rect(x, y, w, h) {
    var r = {};
    r.x = x;
    r.y = y;
    r.w = w;
    r.h = h;
    return r;
}

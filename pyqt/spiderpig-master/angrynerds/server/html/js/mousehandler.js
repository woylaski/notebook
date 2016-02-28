// NOTE!!! 
// The mouse handling stuff doesnt work if the page is scrolled.
// need better logic in getElementPosition() or handleMouseMove to fix this
// we are adding mouseup/down for document, but should be for canvas element instead

var b2Vec2 = Box2D.Common.Math.b2Vec2
, b2AABB = Box2D.Collision.b2AABB
, b2BodyDef = Box2D.Dynamics.b2BodyDef
, b2Body = Box2D.Dynamics.b2Body
, b2FixtureDef = Box2D.Dynamics.b2FixtureDef
, b2Fixture = Box2D.Dynamics.b2Fixture
, b2World = Box2D.Dynamics.b2World
, b2MassData = Box2D.Collision.Shapes.b2MassData
, b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape
, b2CircleShape = Box2D.Collision.Shapes.b2CircleShape
, b2DebugDraw = Box2D.Dynamics.b2DebugDraw
, b2MouseJointDef =  Box2D.Dynamics.Joints.b2MouseJointDef
;

var mouseX, mouseY, mousePVec, isMouseDown, selectedBody, mouseJoint;
var canvasPosition;
var itemThrownCallback;
var recentlySelectedBody;

function setupMouseHandler(canvas, world, worldToScreenFactor, offsetX, offsetY, callback) {
    canvasPosition = getElementPosition(canvas);
    itemThrownCallback = callback;

    document.addEventListener("mousedown", function(e) {
       isMouseDown = true;
       handleMouseMove(e);
       document.addEventListener("mousemove", handleMouseMove, true);
    }, true);

    document.addEventListener("mouseup", function() {
       document.removeEventListener("mousemove", handleMouseMove, true);
       isMouseDown = false;
       mouseX = undefined;
       mouseY = undefined;
    }, true);

    function handleMouseMove(e) {
       mouseX = (e.clientX - canvasPosition.x) / worldToScreenFactor - offsetX;
       mouseY = (e.clientY - canvasPosition.y) / worldToScreenFactor - offsetY;
    };

    // We do exactly the same for touches as for mouse
    if (! catapultCanvasId || ! document.getElementById(catapultCanvasId))
        return;

    var canvas = document.getElementById(catapultCanvasId);
    canvas.addEventListener("touchstart", function(e) {
       isMouseDown = true;
       handleTouchMove(e);
       canvas.addEventListener("touchmove", handleTouchMove, true);
    }, true);

    canvas.addEventListener("touchend", function() {
       canvas.removeEventListener("touchmove", handleTouchMove, true);
       isMouseDown = false;
       mouseX = undefined;
       mouseY = undefined;
    }, true);

    function handleTouchMove(e) {
        var touch = e.targetTouches[0];
        mouseX = (touch.clientX - canvasPosition.x) / worldToScreenFactor - offsetX;
        mouseY = (touch.clientY - canvasPosition.y) / worldToScreenFactor - offsetY;
        event.preventDefault();
    }

}

function getBodyAtMouse() {
   mousePVec = new b2Vec2(mouseX, mouseY);
   var aabb = new b2AABB();
   aabb.lowerBound.Set(mouseX - 0.001, mouseY - 0.001);
   aabb.upperBound.Set(mouseX + 0.001, mouseY + 0.001);

   // Query the world for overlapping shapes.

   selectedBody = null;
   world.QueryAABB(getBodyCB, aabb);
   return selectedBody;
}

function getBodyCB(fixture) {
   if(fixture.GetBody().GetType() != b2Body.b2_staticBody) {
      if(fixture.GetShape().TestPoint(fixture.GetBody().GetTransform(), mousePVec)) {
         selectedBody = fixture.GetBody();
         return false;
      }
   }
   return true;
}

function updateMouse() {

   if(isMouseDown && (!mouseJoint)) {
      var body = getBodyAtMouse();
      if(body) {
         var md = new b2MouseJointDef();
         md.bodyA = world.GetGroundBody();
         md.bodyB = body;
         md.target.Set(mouseX, mouseY);
         md.collideConnected = true;
         md.maxForce = 300.0 * body.GetMass();
         mouseJoint = world.CreateJoint(md);
         body.SetAwake(true);
         recentlySelectedBody = body;
      }
   }

   if(mouseJoint) {
      if(isMouseDown) {
         mouseJoint.SetTarget(new b2Vec2(mouseX, mouseY));
      } else {
         if (itemThrownCallback)
            itemThrownCallback(recentlySelectedBody);

         world.DestroyJoint(mouseJoint);
         mouseJoint = null;
      }
   }

};

//helpers

//http://js-tut.aardon.de/js-tut/tutorial/position.html
function getElementPosition(element) {
   var elem=element, tagname="", x=0, y=0;

   while((typeof(elem) == "object") && (typeof(elem.tagName) != "undefined")) {
      y += elem.offsetTop;
      x += elem.offsetLeft;
      tagname = elem.tagName.toUpperCase();

      if(tagname == "BODY")
         elem=0;

      if(typeof(elem) == "object") {
         if(typeof(elem.offsetParent) == "object")
            elem = elem.offsetParent;
      }
   }

   return {x: x, y: y};
}

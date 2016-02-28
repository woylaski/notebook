// todo imageloader stuff maybe doesn't belong here.

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

var objectCounter = 0;

function createWorld() {
    var world = new b2World(
        new b2Vec2(0, 10)    //gravity
        ,  true              //allow sleep
    );
    return world;
}

function createWorldAndGravity(gravity) {
    var world = new b2World(
        new b2Vec2(0, gravity)    //gravity
        ,  true              //allow sleep
    );
    return world;
}

function centerRectFromBounds(xLeft, yTop, w, h) {
    var p = {};
    p.x = xLeft + w/2.;
    p.y = yTop + h/2.;
    p.w = w/2.;
    p.h = h/2.;
    return p;
}

function createStaticBody(world, x, y, w, h) {

    var fixDef = new b2FixtureDef;
    fixDef.density = 1.0;
    fixDef.friction = 0.5;
    fixDef.restitution = 0.2;

    var bodyDef = new b2BodyDef;

    //create ground
    bodyDef.type = b2Body.b2_staticBody;
    fixDef.shape = new b2PolygonShape;
    fixDef.shape.SetAsBox(w, h);
    bodyDef.position.Set(x, y);
    var body = world.CreateBody(bodyDef);
    body.CreateFixture(fixDef);

    var data = createDefaultUserData();
    data.width = w * 2;
    data.height = h * 2;
    data.fill = "#333";
    
    objectCounter++;
    body.SetUserData(data);
    return body;
}

function createDefaultUserData() {
    var data = {};
    data.shape = "rect";
    data.type = ""; // can be player, catapult, robot, etc any type of classification your game needs
    data.image = 0;
    data.width = 1;
    data.height = 1;
    data.fill = "#AAA";
    data.stroke = "black";
    data.strokeWidth = 1;
    data.health = 100;
    objectCounter++;
    data.id = objectCounter;
    data.name = "object#" + objectCounter;
    return data;
}

function createDynamicCircle(world, x, y, r) {
    var bodyDef = new b2BodyDef;
    var fixDef = new b2FixtureDef;
    fixDef.density = 0.2;
    fixDef.friction = 0.5;
    fixDef.restitution = 0.2;
    fixDef.shape = new b2CircleShape(r);

    bodyDef.type = b2Body.b2_dynamicBody;
    bodyDef.position.x = x;
    bodyDef.position.y = y;

    var body = world.CreateBody(bodyDef);
    body.CreateFixture(fixDef);

    var data = createDefaultUserData();
    data.shape = "circle";
    data.radius = r;

    body.SetUserData(data);
    return body;	
}

function createDynamicRect(world, x, y, w, h) {
    var bodyDef = new b2BodyDef;
    var fixDef = new b2FixtureDef;
    fixDef.density = 1.0;
    fixDef.friction = 0.5;
    fixDef.restitution = 0.2;
    fixDef.shape = new b2PolygonShape;
    fixDef.shape.SetAsBox(w, h);

    bodyDef.type = b2Body.b2_dynamicBody;
    bodyDef.position.x = x;
    bodyDef.position.y = y;

    var body = world.CreateBody(bodyDef);
    body.CreateFixture(fixDef);

    var data = createDefaultUserData();
    data.shape = "rect";
    data.width = w * 2;
    data.height = h * 2;

    body.SetUserData(data);
    return body;
}

// callback(array(Image))
function loadCiscoTestImages(callback) {
    var names = ["nerds/daneriks2", "nerds/vhammer2", "abjornst", "abrenden", "acaignie", "adimchev", "aertsas", "afroyhau", "agraesli", "ahauge"];
    var url = [];
    for (var i in names) {
        url[i] = "images/" + names[i] + ".jpg";
    }
    loadImages(url, callback);
}

function loadBoss(callback) {
    var names = ["daneriks"];
    var url = [];
    for (var i in names) {
        url[i] = "images/nerds/" + names[i] + ".png";
    }
    loadImages(url, callback);
}

function loadBieber(callback) {
    var names = ["bieber"];
    var url = [];
    for (var i in names) {
        url[i] = "images/nerds/" + names[i] + ".jpg";
    }
    loadImages(url, callback);
}


function loadTeam1(callback) {
    var names = ["edorum", "emorchbr", "ivakrist", "jensand", "lasthore", "lbergers", "mbratset", "stistryn", "svhuseby", "tbjolset", "vhammer"];
    var url = [];
    for (var i in names) {
        url[i] = "images/nerds/" + names[i] + ".jpg";
    }
    loadImages(url, callback);
}

function loadTeam2(callback) {
    var names = ["einahage", "ikvaal", "itollefs", "jankrokn", "josorens", "kjrud", "ksolem", "ragnbart", "vnorheim"];
    var url = [];
    for (var i in names) {
        url[i] = "images/nerds/" + names[i] + ".jpg";
    }
    loadImages(url, callback);
}

function loadImages(sources, callback) {

    var images = [];
    var loadedImages = 0;
    var numImages = 0;

    // get num of sources
    for(var src in sources) {
        numImages++;
    }
    for(var src in sources) {
        images[src] = new Image();
        images[src].onload = function() {
            if(++loadedImages >= numImages) {
                callback(images);
            }
        };
        images[src].src = sources[src];
    }
}

$(document).ready(init);

var world;
var gameGraphics;
var simulator;
var gameGraphics;
var catapultGraphics;

var objectsToRemove = [];

var gameCanvasId = "gameCanvas";
var debugCanvasId = "debugCanvas";
var catapultCanvasId = "catapultCanvas";
var logId = "logLabel";

// screen size stuff:
// ex60:    1920 x 1080 = 1.78
// ex90:    1920 x 1200 = 1.6
// idefix:  1280 x 800  = 1.6
// ipad:    1024 x 768  = 1.33
// profile: 1920 x 1080 = 1.78



function init() {

    if (document.getElementById(debugCanvasId))
        config.debugEnabled = true;
    if (document.getElementById(catapultCanvasId))
        config.catapultEnabled = true;
    if (document.getElementById(gameCanvasId))
        config.mainScreenEnabled = true;
    if (document.getElementById(logId))
        config.loggingEnabled = true;
    initTheRest();
}

function htmlLog(str) {
    if (config.loggingEnabled)
        $("#" + logId).text(str);
}

function initTheRest() {

    world = createTestWorld();
    if (config.debugEnabled)
    	setupDebugDraw();
    if (config.mainScreenEnabled)
        setupGameWorld();
    if (config.catapultEnabled)
        setupCatapult(world);
    else
        setupMouseHandler(document.getElementById(gameCanvasId), world,
                                    config.worldToScreenFactor, config.offsetX, config.offsetY);
    setupDamageHandler(world);
    simulator = new Simulator(config.framesPerSecond, updateStep);

	
    updateStep(); // run one step to draw first frame
    $("#btnStartStop").click(toggleSim);
}

function setupCatapult(world) {
	console.log('setting up catapult');
    var canvas = document.getElementById(catapultCanvasId);
    catapultGraphics = new Box2dGraphics(canvas, world, config.worldToScreenFactor, config.offsetX, config.offsetY);
    setupMouseHandler(document.getElementById(catapultCanvasId), world, 
                                config.worldToScreenFactor, config.offsetX, config.offsetY, objectThrown);
}

function fitIntoAndMaintainAspect(containerWidth, containerHeight, myWidth, myHeight) {
	var aspectW = containerWidth / myWidth;
	var aspectH = containerHeight / myHeight;
	var factor = Math.min(aspectW, aspectH);
	return factor; // you multiply your rect with this to get a fitting rectangle
}

function objectThrown(body) {
    var angle = body.GetAngle();
    var angularVelocity = body.GetAngularVelocity();
    var velocity = body.GetLinearVelocity();
    var pos = body.GetPosition();
    var data = {
        "objectId": body.GetUserData().id,
        "x": pos.x,
        "y": pos.y,
        "xVelocity": velocity.x,
        "yVelocity": velocity.y,
        "angle": angle,
        "angularVelocity": angularVelocity
    };

    pushIncomingObject(data);
    //console.log("throw", pos.x,  pos.y, velocity.x, velocity.y, angle, angularVelocity);
}


function toggleSim() {
    if (simulator.isRunning())
        simulator.stopSimulation();
    else
        simulator.startSimulation();
}


function setupDebugDraw() {
    var b2DebugDraw = Box2D.Dynamics.b2DebugDraw;
    var debugDraw = new b2DebugDraw();
    debugDraw.SetSprite(document.getElementById(debugCanvasId).getContext("2d"));
    debugDraw.SetDrawScale(config.worldToScreenFactor/2);
    debugDraw.SetFillAlpha(0.5);
    debugDraw.SetLineThickness(1.0);
    debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
    world.SetDebugDraw(debugDraw);
}

// TODO make array with objectId indexes to avoid looping like this
function findWorldObject(objectId) {
    var body = world.GetBodyList();

    for (var i=0; i < world.GetBodyCount(); i++) {
        if (body.GetUserData() && body.GetUserData().id == objectId) {
            return body;
        }
        body = body.GetNext();
    }
    return 0;
}

function setupGameWorld() {
    var canvas = document.getElementById(gameCanvasId);
    gameGraphics = new Box2dGraphics(canvas, world, config.worldToScreenFactor, config.offsetX, config.offsetY);
}

function updateStep() {
    world.Step(1 / config.framesPerSecond, config.velocityIterations, config.positionIterations);
    if (config.debugEnabled)
    	world.DrawDebugData();
    updateMouse();
    if (config.mainScreenEnabled)
        gameGraphics.paint();
    if (config.catapultEnabled)
    	catapultGraphics.paint();
    world.ClearForces();

    if (simulator.getStep() % config.pollingEveryNFrame  == 0)
        updateTimeLabel();

    if (simulator.getStep() % config.pollingEveryNFrame  == 0 && ! config.catapultEnabled)
        pollIncomingObjects();

    removeDeadBodies();
}

function pollIncomingObjects() {
    popIncomingObject(pollRequestReceived);
}

function pollRequestReceived(answer) {
    if (!answer)
        return;
    console.log("object thrown: ", answer.objectId);

    var object = findWorldObject(answer.objectId);
    console.log("object to throw:", object);
    object.SetPositionAndAngle(new b2Vec2(answer.x, answer.y), answer.angle);
    object.SetLinearVelocity(new b2Vec2(answer.xVelocity, answer.yVelocity));
    object.SetAngularVelocity(answer.angularVelocity);
    object.SetAwake(true);
}

function updateTimeLabel() {
    var span = $("#timeLabel");
    if (span)
        span.html("time=" + simulator.getTime());
}

function setupDamageHandler(world) {
	var hardHitTreshold = 1.0;
	
	var listener = new Box2D.Dynamics.b2ContactListener;

    listener.BeginContact = function(contact) {};
    listener.EndContact = function(contact) {};
    listener.PreSolve = function(contact, oldManifold) {};
    
    listener.PostSolve = onCollisionDetected;
    world.SetContactListener(listener);
}

function onCollisionDetected(contact, impulse) {
    //console.log(contact.GetFixtureA().GetBody().GetUserData());
    //console.log(contact.GetFixtureA().GetBody().GetUserData());
    var impulse = Math.abs(impulse.normalImpulses[0]);

    if (isColliding("boss", "nerd", contact)) {
        console.log("Nerd hit boss");
        if (contact.GetFixtureA().GetBody().GetUserData().type == "nerd") {
            addBodyToRemove(contact.GetFixtureA().GetBody());
        }
        else if (contact.GetFixtureB().GetBody().GetUserData().type == "nerd") {
            addBodyToRemove(contact.GetFixtureB().GetBody());
        }
    }

    else if (isColliding("bieber", "obstacle", contact)) {
        if (contact.GetFixtureA().GetBody().GetUserData().type == "bieber") {
            addBodyToRemove(contact.GetFixtureA().GetBody());
        }
        else if (contact.GetFixtureB().GetBody().GetUserData().type == "bieber") {
            addBodyToRemove(contact.GetFixtureB().GetBody());
        }
    }

//    	if (impulse > hardHitTreshold)
//                console.log("impulse:" + impulse);
}

function addBodyToRemove(body) {
    for (var i=0; i<objectsToRemove.length; i++) {
        if (objectsToRemove[i].GetUserData().id == body.GetUserData().id) {
            console.log("Object already in list" + body.GetUserData().name);
            return; // already in list
        }
    }
    objectsToRemove.push(body);
}

function removeDeadBodies() {
    while(objectsToRemove.length > 0) {
        var obj = objectsToRemove.pop();
        console.log("Removing obj ", obj.GetUserData().name, obj.GetUserData().type);
        world.DestroyBody(obj);
    }
}


function isColliding(type1, type2, contact) {
    var t1 = contact.GetFixtureA().GetBody().GetUserData().type;
    var t2 = contact.GetFixtureB().GetBody().GetUserData().type;
    //console.log("collision ", t1, t2);
    return (t1 == type1 && t2 == type2) || (t1 == type2 && t2 == type1);
}

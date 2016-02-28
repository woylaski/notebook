function createTestWorld() {

    var platformY = 40;
    var catapultY = 57;

    var world = createWorldAndGravity(30);
    createGround();
    createPlatform();
    //createCatapultPlatform(2);
    //createBoxes();

    loadBoss(function(images) {
        createBoss(images[0]);
    });

    loadTeam1(function(images) {
        createNerds1(world, images);
    });

    loadTeam2(function(images) {
        createNerds2(world, images);
    });


    function createCatapultPlatform(x) {
        var y = catapultY;
        var w = 15;

        var leftLeg = centerRectFromBounds(x, y, 0.5, 4);
        createObstacle(world, leftLeg.x, leftLeg.y, leftLeg.w, leftLeg.h);

        var rightLeg = centerRectFromBounds(x + w - 1, y, 0.5, 4);
        createObstacle(world, rightLeg.x, rightLeg.y, rightLeg.w, rightLeg.h);

        var top = centerRectFromBounds(x-1, y-1, w+2, 0.5);
        createObstacle(world, top.x, top.y, top.w, top.h);
    }

    function createPlatform() {
        var h = 5.;
        var w = 5.;
        var platform = centerRectFromBounds(30, platformY, 40, 2);
        createWall(world, platform.x, platform.y, platform.w, platform.h);
    }

	function createBoss(photo) {
		var radius = 5;
		var circle = createDynamicCircle(world, 50, platformY - radius, radius);
		circle.GetUserData().imageObj = photo;
		circle.GetUserData().type = "boss";
	}

    function createWall(world, x, y, w, h) {
        var b = createStaticBody(world, x, y, w, h);
        b.GetUserData().type = "wall";
        b.GetUserData().fill = "#666";
        return b;
    }

    function createObstacle(world, x, y, w, h) {
        var b = createDynamicRect(world, x, y, w, h);
        b.GetUserData().fill = "#AAA";
        b.GetUserData().type = "obstacle";
    }

    function createGround() {
        var top = centerRectFromBounds(1, 1, 98, 1);
        var bottom = centerRectFromBounds(1, 62, 98, 1);
        createWall(world, top.x, top.y, top.w, top.h);
        createWall(world, bottom.x, bottom.y, bottom.w, bottom.h);
    }

    function createBoxes() {
        for (var x=31; x < 69; x += 3) {
            var y = 30;
            var box = centerRectFromBounds(x, y, 0.5, 9);
            createObstacle(world, box.x, box.y, box.w, box.h);
        }
    }

    function createNerds1(world, images) {

        var nerds = images.length;

        for (var i=0; i < nerds; i++) {
            var w = 2.0;
            var h = w * 4./3.;
            var x = (i + 1) * 2.1;
            var y = catapultY - 3;

            var pos = centerRectFromBounds(x, y, w, h);
            var body = createDynamicRect(world, pos.x, pos.y, pos.w, pos.h);
            body.GetUserData().imageObj = images[i];
            body.GetUserData().shape = "image";
            body.GetUserData().type = "nerd";
        }
    }

    function createNerds2(world, images) {

        var nerds = images.length;

        for (var i=0; i < nerds; i++) {
            var w = 2.0;
            var h = w * 4./3.;
            var x = (97 - i*2.1);
            var y = 60;

            var pos = centerRectFromBounds(x, y, w, h);
            var body = createDynamicRect(world, pos.x, pos.y, pos.w, pos.h);
            body.GetUserData().imageObj = images[i];
            body.GetUserData().shape = "image";
            body.GetUserData().type = "nerd";
        }
    }

    return world;
}



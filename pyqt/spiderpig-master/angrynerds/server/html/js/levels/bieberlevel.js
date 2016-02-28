function createTestWorld() {


    var world = createWorldAndGravity(20);
    createGround();
    createLogo();
    createBlocker();
    //createCatapultPlatform(2);
    //createBoxes();

    loadBieber(function(images) {
        createBieber(images[0]);
    });

    loadTeam1(function(images) {
        createNerds1(world, images);
    });

    createVerticals();


    function createVerticals() {
        var x = 75;
        var y = 28;
        var w = 1;
        var h = 25;

        var platform = centerRectFromBounds(x, y, w, h);
        createWall(world, platform.x, platform.y, platform.w, platform.h);
    }

    function createLogo() {
        var w = 17.;
        var x = 60;
        var y = 20;

        var platform = centerRectFromBounds(x, y, w, 1);
        createWall(world, platform.x, platform.y, platform.w, platform.h);

        var roof = centerRectFromBounds(x, y-9, w, 1);
        createWall(world, roof.x, roof.y, roof.w, roof.h);

        for (var i=0; i<9; i++) {
            var h = 2;
            if (i == 1 || i == 3 || i == 5 || i == 7) h = 4;
            else if (i == 2 || i == 6) h = 6;

            var e = centerRectFromBounds(x + i*2, y - h, 1, h);
            var body = createObstacle(world, e.x, e.y, e.w, e.h);
            body.GetUserData().fill = "#990000";
        }
    }

    function createBlocker() {
        var xStart = 40;
        var yBottom = 59;
        var w = 3;
        var h = 3;
        var space = 3;
        var maxX = 70;
        var minY = 20;

        for (var x = xStart; x < maxX; x += w + space) {
            for (var y = yBottom; y > minY; y -= h) {
                var e = centerRectFromBounds(x, y, w, h);
                createObstacle(world, e.x, e.y, e.w, e.h);
            }
        }
    }

    function createBieber(photo) {
        var pos = centerRectFromBounds(83, 55, 3, 4);
        var body = createDynamicRect(world, pos.x, pos.y, pos.w, pos.h);
        body.GetUserData().imageObj = photo;
        body.GetUserData().shape = "image";
        body.GetUserData().type = "bieber";
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
        return b;
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
            var y = 55;

            var pos = centerRectFromBounds(x, y, w, h);
            var body = createDynamicRect(world, pos.x, pos.y, pos.w, pos.h);
            body.GetUserData().imageObj = images[i];
            body.GetUserData().shape = "image";
            body.GetUserData().type = "nerd";
        }
    }

    return world;
}



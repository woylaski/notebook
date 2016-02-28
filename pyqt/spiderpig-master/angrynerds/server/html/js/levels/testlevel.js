function createTestWorld() {

    var world = createWorld();
    createGround();
    createObstacles();


    function createObstacles() {
        var groundY = 11;
        var h = 1;
        var w = 0.2;
        createObstacle(world, 14, groundY, w, h);
        createObstacle(world, 17, groundY, w, h);
        createObstacle(world, 14 + 1.5, groundY - h - 0.1, 1.5, w);
    }

    function createObstacle(world, x, y, w, h) {
        b.GetUserData().type = "obstacle";
        b.GetUserData().fill = "#"
        return obstacle;
    }

    function createWall(world, x, y, w, h) {
        var b = createStaticBody(world, x, y, w, h);
        b.GetUserData().type = "wall";
        return b;
    }

    function createObstacle(world, x, y, w, h) {
        var b = createDynamicRect(world, x, y, w, h);
        b.GetUserData().fill = "#900"; // obstacle
        b.GetUserData().type = "obstacle";
    }

    function createGround() {
        createWall(world, 10, 400 / 30 + 1.8, 20, 2);  // bottom bar
        createWall(world, 10, -1.8, 20, 2);            // top bar
        createWall(world, -1.8, 13, 2, 14);            // left bar
        createWall(world, 21.8, 13, 2, 14);            // right bar
    }

    loadCiscoTestImages(function(images) {
        createNerds(world, images);
    });

    return world;
}

function createNerds(world, images) {

    var nerds = images.length;

    for (var i=0; i < nerds; i++) {
        var w = 0.2;
        var h = w * 4./3.;
        //var x = Math.random() * 4;
        //var y = Math.random() * 10;
        var x = i / 2.5;
        var y = 12;

        var body = createDynamicRect(world, x, y, w, h);
        body.GetUserData().imageObj = images[i];
        body.GetUserData().shape = "image";
        body.GetUserData().type = "nerd";
    }

}


function createTestWorld() {

    var world = createWorld();

    var width = 10;
    var height = 5;
    var wallSize = 0.1;

    createWall(world, width/2, wallSize, width/2-wallSize*2, wallSize); // north
    createWall(world, width/2, height-wallSize, width/2-wallSize*2, wallSize); // south
    createWall(world, wallSize, height/2, wallSize, height/2); // west
    createWall(world, width-wallSize, height/2, wallSize, height/2); // east

    createDynamicRect(world, width/2, height/2, 0.1, 0.1);
//    createGround();
//    createObstacles();
//    createRandomObjects();


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


    function createRandomObjects() {
        for (var i=0; i<20; i++) {
            var w = Math.random() + 0.1; //half width
            var h = Math.random() + 0.1; //half height
            var x = Math.random() * 15;
            var y = Math.random() * 10;
            createDynamicRect(world, x, y, w, h);
        }
    }

    return world;
}




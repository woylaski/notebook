function createTestWorld() {

    var world = createWorld();
    createGround();
    createRandomObjects();

    function createGround() {
        createStaticBody(world, 10, 400 / 30 + 1.8, 20, 2);  // bottom bar
        createStaticBody(world, 10, -1.8, 20, 2);            // top bar
        createStaticBody(world, -1.8, 13, 2, 14);            // left bar
        createStaticBody(world, 21.8, 13, 2, 14);            // right bar

/*
        createStaticBody(world, 5, 9, 0.7, 0.7).GetUserData().fill = "#900"; // obstacle
        createStaticBody(world, 10, 11, 0.7, 0.7).GetUserData().fill = "#900"; // obstacle
*/
    }

    function createRandomObjects() {
        for (var i=0; i<1; i++) {
            var w = Math.random() + 0.1; //half width
            var h = Math.random() + 0.1; //half height
            var x = Math.random() * 15;
            var y = Math.random() * 10;
            createDynamicRect(world, x, y, w, h);
        }
    }

    return world;
}




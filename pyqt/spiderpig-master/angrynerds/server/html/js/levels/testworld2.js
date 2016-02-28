function createTestWorld() {

    var world = createWorld();
    var left=0, top = 0, bottom=800/30, right=1200/30, size=0.5;

    createGround();
    createRandomObjects();
    createObstacles();

    function createGround() {
        createStaticBody(world, left, bottom, right, size);     // bottom bar
        createStaticBody(world, left, top, right, size);        // top bar
        createStaticBody(world, left, top, size, bottom);       // left bar
        createStaticBody(world, right, top, size, bottom);      // right bar
    }

    function createObstacles() {
        for (var i=0; i<7; i++) {
            var w = Math.random() + 0.1; //half width
            var h = Math.random() + 0.1; //half height
            var x = Math.random() * right;
            var y = Math.random() * bottom / 2 + (bottom / 4);

            createStaticBody(world, x, y, w, h).GetUserData().fill = "#900"; // obstacle
        }
    }

    function createRandomObjects() {
        for (var i=0; i<50; i++) {
            var w = Math.random() + 0.1; //half width
            var h = Math.random() + 0.1; //half height
            var x = Math.random() * right;
            var y = Math.random() * bottom / 2;
            createDynamicRect(world, x, y, w, h);
        }
    }

    return world;
}




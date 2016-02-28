function createTestWorld() {

    var world = createWorld();
    createGround();

    function createGround() {
        createStaticBody(world, 10, 800 / 30 + 1.8, 40, 2);  // bottom bar
        createStaticBody(world, 10, -1.8, 20, 2);            // top bar
        createStaticBody(world, -1.8, 13, 2, 14);            // left bar
        createStaticBody(world, 43, 13, 2, 14);            // right bar

/*
        createStaticBody(world, 5, 9, 0.7, 0.7).GetUserData().fill = "#900"; // obstacle
        createStaticBody(world, 10, 11, 0.7, 0.7).GetUserData().fill = "#900"; // obstacle
*/
    }

    loadCiscoTestImages(function(images) {
        createRandomObjects(world, images);
    });

    return world;
}

function createRandomObjects(world, images) {

    for (var i=0; i<images.length; i++) {
        var w = Math.random() + 0.4; //half width
        var h = w * 4./3.;
        var x = Math.random() * 15;
        var y = Math.random() * 10;

        var body = createDynamicRect(world, x, y, w, h);
        body.GetUserData().imageObj = images[i];
        body.GetUserData().shape = "image";
    }

}


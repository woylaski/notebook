// Default config
function DefaultConfig() {
    this.framesPerSecond = 60;
    this.velocityIterations = 10;
    this.positionIterations = 10;

    this.worldToScreenFactor = 30.0;
    this.offsetX = 0;
    this.offsetY = 0;

    this.debugEnabled = false;
    this.catapultEnabled = false;
    this.mainScreenEnabled = false;
    this.loggingEnabled = false;
    this.pollingEveryNFrame = 6;
}

var config = new DefaultConfig();

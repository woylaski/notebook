// Seems we need to keep some global variables unfortunately,
// since window.interval timer accesses updateSimulation
// without the "this" context (?). need to understand better

var simulationStep = 0;
var FRAMES_PER_SECOND = 60;

// class ctor
function Simulator(fps, callback) {
    this.timer = 0;
    FRAMES_PER_SECOND = fps;

    this.startSimulation = function() {
        console.log("Starting sim");
        if (this.timer == 0)
            this.timer = window.setInterval(this.updateSimulation, 1000 / fps);
    }

    this.stopSimulation = function() {
        console.log("Stopping sim");
        window.clearInterval(this.timer);
        this.timer = 0;
    }

    this.updateSimulation = function() {
        simulationStep++;
        callback();
    }

    this.isRunning = function() {
        return this.timer != 0;
    }

    this.getTime = function() {
        return simulationStep / FRAMES_PER_SECOND;
    }

    this.getStep = function() {
        return simulationStep;
    }
}

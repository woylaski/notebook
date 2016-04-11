.pragma library

function subclass(constructor, superConstructor) {
    function surrogateConstructor() {}

    surrogateConstructor.prototype = superConstructor.prototype;

    var prototypeObject = new surrogateConstructor();
    prototypeObject.constructor = constructor;

    constructor.prototype = prototypeObject;
}


// Promise class

function Promise(delayed) {
    this.thenHandlers = [];
    this.onDone = [];
    this.onError = [];
    this.info = {};

    if (delayed !== undefined)
        this.code = delayed;
}

Promise.prototype.then = function (handler) {
    this.thenHandlers.push(handler);
    return this;
};

Promise.prototype.done = function (onResolved) {
    this.onDone.push(onResolved);
    return this;
};

Promise.prototype.error = function (onError) {
    this.onError.push(onError);
    return this;
};

Promise.prototype.resolve = function (value) {
    var handler, i;
    //print("Success")
    for (i = 0; i < this.thenHandlers.length; i++) {
        handler = this.thenHandlers[i];
        value = handler(value, this.info);
    }

    for (i = 0; i < this.onDone.length; i++) {
        handler = this.onDone[i];
        handler(value, this.info);
    }
};

Promise.prototype.reject = function (error) {
    //print("Failure", error)
    for (var i = 0; i < this.onError.length; i++) {
        var handler = this.onError[i];
        handler(error, this.info);
    }
};

Promise.prototype.start = function(args) {
    this.code(args);
};

// JoinedPromise class

subclass(JoinedPromise, Promise);

function JoinedPromise() {
    Promise.call(this);

    this.promiseCount = 0;
}

JoinedPromise.prototype.add = function(promise) {
    this.promiseCount++;

    var join = this;

    promise.done(function(data) {
        join.promiseCount--;

        if (join.promiseCount === 0) {
            print("All joined promises done!");
            join.resolve();
        }
    });

    promise.error(function (error) {
        join.promiseCount = -1;

        print("A joined promise failed, shortcutting to failure!");
        join.reject(error);
    });

    return this;
};

function testJoinedPromise(){
    print("-------test promise---------")
    var ajion_promise = new JoinedPromise()
    print(ajion_promise.constructor == JoinedPromise)
    print(ajion_promise.constructor.prototype == Promise)
    print(ajion_promise.constructor.prototype == Promise.prototype)
    print(ajion_promise.constructor.prototype.prototype == Promise.prototype)

    print(ajion_promise.__proto__== JoinedPromise.prototype)
    print(ajion_promise.__proto__.__proto__ == Promise.prototype)
}



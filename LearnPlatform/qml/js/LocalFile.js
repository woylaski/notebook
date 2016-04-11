.pragma library
.import "Promise.js" as Promises

function readFile(fname) {
    var promise = new Promises.Promise();
    var request = new XMLHttpRequest();

    request.onreadystatechange = function(event)
    {
        if (request.readyState == XMLHttpRequest.DONE)
        {
            print("read ok: ", request.responseText)
            promise.resolve(request.responseText);
        }
        else
        {
            //print("read state: ", request.readyState)
            //promise.reject(request.responseText);
        }
    }

    request.open('GET', fname)
    request.send()
    return promise
}

function writeFile(fname, content) {
    var promise = new Promises.Promise();
    var request = new XMLHttpRequest();

    print("write content:",content)
    request.onreadystatechange = function(event)
    {
        if (request.readyState == XMLHttpRequest.DONE)
        {
            print("write ok: ", request.responseText)
            promise.resolve(request.responseText);
        }
        else
        {
            //print("read state: ", request.readyState)
            //promise.reject(request.responseText);
        }
    }

    request.open('POST', fname, true)
    request.send(content)
    return promise
}

function readFileTest(fname){
    print("try to read file:"+fname)
    //var promise = HttpUtils.get(fname)
    var promise = readFile(fname)
    promise.then( function(data) {
        print("----ok----")
        filecontent.text = data;
    });

    promise.error( function(data) {
        print("----error----")
        filecontent.text = "read file error:" + data;
    });
}

function writeFileTest(fname, content){
    print("try to write file:"+fname)
    //var promise = HttpUtils.get(fname)
    var promise = writeFile(fname, content)
    promise.then( function(data) {
        print("----ok----")
        //filecontent.text = data;
    });

    promise.error( function(data) {
        print("----error----")
        //filecontent.text = "read file error:" + data;
    });
}


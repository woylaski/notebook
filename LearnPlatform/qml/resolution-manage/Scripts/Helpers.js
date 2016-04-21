.pragma library

function isObject(o) {
    return o !== null && typeof o === 'object';
}

function getResourceProperty( o, name ){
    var res;
    if(isObject(o)) return o;
    if(isObject(o["resource"])&&o["resource"].hasOwnProperty(name)) res = o["resource"];
    else res = o;
    return res[name];
}

function getValue( o, name ){
    name = name || "value";
    if (isObject(o)&&o[name]) return o[name];
        else if (isObject(o)) return null;
        else return o;
}

function clamp( value, min, max ) {
    min = min || value;
    max = max || value;
    return Math.max( Math.min( value, max ), min);
}

function ratio( a, b ) {
    return a / b;
}

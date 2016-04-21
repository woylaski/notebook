var cache = {}

function isEmpty() {
    return Object.keys(cache).length === 0;
}

function set(key, value) {
    cache[key] = value;
}

function get(key) {
    return cache[key];
}

function logCache() {
    console.log(JSON.stringify(cache));
}

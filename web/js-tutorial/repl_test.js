// repl_test.js
var repl = require("repl"),
    msg = "message";

repl.start("hello>").context.m = msg;
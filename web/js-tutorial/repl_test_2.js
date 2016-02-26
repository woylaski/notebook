// repl_test_2.js
const repl = require('repl');

var replServer = repl.start('hello>');
replServer.defineCommand('sayhello', {
  help: 'Say hello',
  action: function(name) {
    this.write(`Hello, ${name}!\n`);
    this.displayPrompt();
  }
});
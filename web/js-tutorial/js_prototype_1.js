function name(obj){
    console.log(obj)//"uw3c"
}
name("uw3c")

var test = new name("uw3c")
console.log(typeof(test))
console.log(JSON.stringify(test.prototype))


function uw3c(){
}
uw3c.prototype.name = "a";
var test = new uw3c();
console.log(test.name)//"a";


function uw3c(name){
    console.log("姓名:" + name + ",年龄:" + this.age + ",性别:" + this.sex);
}
uw3c.prototype.age = 15;
uw3c.prototype.sex = "man";
var test1 = new uw3c("css");//姓名:css,年龄:15,性别:man
var test2 = new uw3c("js");//姓名:js,年龄:15,性别:man
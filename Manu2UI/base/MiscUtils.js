.pragma library

//{ } 大括号，表示定义一个对象，大部分情况下要有成对的属性和值，或是函数
//var LangShen = {"Name":"Langshen","AGE":"28"};
//所以访问时，应该用.（点）来层层访问：
//LangShen.Name、LangShen.AGE
//当然我们也可以用数组的方式来访问，如：
//LangShen["Name"]、LangShen["AGE"]，结果是一样的。


//[ ]中括号，表示一个数组，也可以理解为一个数组对象
//var LangShen = [ "Name","LangShen","AGE","28" ];

//{ } 和[ ] 一起使用，我们前面说到，{ } 是一个对象，[ ] 是一个数组，我们可以组成一个对象数组，
//如：
//var LangShen = { "Name":"Langshen",
//"MyWife":[ "LuLu","26" ],
//"MySon":[{"Name":"Son1"},{"Name":"Son2"},{"Name":"Son3"}]
//}

//prototype,constructor

function afun(){
    print("afun ....")
}

function bfun(){
    var aa=new afun()
    var bb=new afun()

    print(typeof aa)
    print(typeof bb)
    print(typeof afun)

    print(aa.constructor==afun)
    print(bb.constructor==afun)
    print(afun.prototype==afun)

    print(aa.prototype==afun)
    print(bb.prototype==afun)
    print(afun.prototype==afun)
}

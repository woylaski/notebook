### js的数据类型
- undefined
- boolean
- number
- string
- object

除了以上5 中类型之外， 还有一种 “function”的类型

查看数据类型的方法
>typeof('aa')
typeof aa


### undefined 和 null, NaN 的区别
undefined判断的是变量的类型，而其他两个判断是变量的值

undefined可以用来表示以下的状况
1. 表示一个未声明的变量，
2. 已声明但没有赋值的变量，
3. 一个并不存在的对象属性

null 是一种特殊的object ,表示无值;
NaN是一种特殊的number ,表示无值;
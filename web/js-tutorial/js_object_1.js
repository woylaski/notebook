var day1={
	squirrel: false,
	events: ['worker', 'touched tree', 'pizza', 'running', 'television']	
}

console.log(day1.squirrel)
console.log(day1.events)

day1.squirrel = true
console.log(day1.squirrel)

var anObject={left:1, rigtht:2}
console.log(anObject.left)

delete anObject.left
console.log(anObject.left)
console.log("left" in anObject)
console.log("rigtht" in anObject)


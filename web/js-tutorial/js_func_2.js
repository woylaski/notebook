
function multiplier(factor){
	return function(number){
		return factor*number
	}
}

var twice = multiplier(2)
console.log(twice(5))

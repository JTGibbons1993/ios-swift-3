//: [Previous](@previous)

//: ### Array operations: append, insert, remove, count, retrieve
var musicians = ["Neil Young","Kendrick Lamar","Flo Rida", "Fetty Wap"]
musicians.append("Rae Sremmurd")
musicians.insert("Dej Loaf", at: 2)
musicians.remove(at: 3)

musicians
musicians.count

var numArray = [1,2,3,4,5,6]

numArray.append(8000)
numArray.insert(555, at:0)
numArray.remove(at:0)
print(numArray)

var crazyArray = numArray + musicians



let musician = musicians[2]

//: [Next](@next)

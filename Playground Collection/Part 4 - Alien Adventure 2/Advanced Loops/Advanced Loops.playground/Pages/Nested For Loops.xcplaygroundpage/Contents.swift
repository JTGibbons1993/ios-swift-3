//: [Previous](@previous)
/*:
## Nested For Loops
For loops can contain other for loops, and this is known as nesting. It's a pattern that's common to many applications, especially for processing data that's two-dimensional (has rows and columns).
*/
print("A new approach using nested for loops...")
for i in 1...8 {
    for j in 1...8 {
        if j % 2 == 0 {
            print("⬛")
        } else {
            print("◻️")
        }
    }
}

print("Trying using the terminator parameter...")
for i in 1...8 {
    for j in 1...8 {
        if j % 4 == 0 && i % 4 == 0{
            print("🆒", terminator: "")
        }
        if j % 2 == 0 {
            print("⬛", terminator: "")
        } else {
            print("◻️", terminator: "")
        }
    }
    print("")
}
//: [Next](@next)

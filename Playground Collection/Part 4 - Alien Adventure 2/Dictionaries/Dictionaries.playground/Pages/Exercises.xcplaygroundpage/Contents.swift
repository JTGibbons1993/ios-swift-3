//: [Previous](@previous)

//: ### Exercise 1
//: a) Initialize an empty dictionary which holds Strings as keys and Bools as values.
var emptyDick = [String:Bool]()
//: b) Initialize a dictionary using dictionary literal syntax. The keys should be the Strings: "Anchovies", "Coconut", "Cilantro", "Liver"  and each value should be a Bool representing whether you like the food or not.
var litDick = ["Anchovies":true, "Coconut":false, "Cilantro":true, "Liver":true]

//: ### Exercise 2
//: Insert an entry for George H.W. Bush into the dictionary below.

var presidentialPetsDict = ["Barack Obama":"Bo", "Bill Clinton": "Socks", "George Bush": "Miss Beazley", "Ronald Reagan": "Lucky"]

//desired output
// ["Barack Obama":"Bo", "George Bush": "Miss Beazley","Bill Clinton": "Socks", "George H. W. Bush": "Millie", "Ronald Reagan": "Lucky"]
presidentialPetsDict["George H. W. Bush"] = "Millie"
presidentialPetsDict["George Bush"] = nil
presidentialPetsDict["George W. Bush"] = "Miss Beazley"
//: ### Exercise 3
//: Remove the entry for "George Bush" and replace it with an entry for "George W. Bush".

//: ### Exercise 4
//: We've initialized a new dictionary of presidentialDogs with the entries from presidentialPets. Update the entry for Bill Clinton by replacing "Socks" the cat with "Buddy" the dog.
var presidentialDogs = presidentialPetsDict
presidentialDogs["Bill Clinton"] = "Buddy"

if let dog = presidentialDogs["Barack Obama"]{dog}

print("Michele Obama walks \() every morning.")
//: ### Exercise 6
// How many studio albums did Led Zeppelin release?
var studioAlbums = ["Led Zeppelin":1969, "Led Zeppelin II": 1969, "Led Zeppelin III": 1970, "Led Zeppelin IV": 1971, "Houses of the Holy":1973, "Physical Graffiti": 1975, "Presence":1976, "In Through the Out Door":1979, "Coda":1982]
//: [Next](@next)

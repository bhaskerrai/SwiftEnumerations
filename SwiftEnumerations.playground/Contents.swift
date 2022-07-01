import UIKit

//“An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.”

//Enumeration Syntax
//You introduce enumerations with the enum keyword and place their entire definition within a pair of braces:

enum SomeEnumeration {
    // enumeration definition goes here
}

enum CompassPoint {
    case north
    case south
    case east
    case west
}

//or
enum CompassPoint2 {
    case north, south, east, west //“Multiple cases can appear on a single line, separated by commas
}

var a = CompassPoint.east

//The type of directionToHead is inferred when it’s initialized with one of the possible values of CompassPoint. Once directionToHead is declared as a CompassPoint, you can set it to a different CompassPoint value using a shorter dot syntax:

a = .north

//Matching Enumeration Values with a Switch Statement
//You can match individual enumeration values with a switch statement:
enum DaysOfWeek{ case monday, tueday, wednesday, thrusday, friday, saturday, sunday}

var currentDay = DaysOfWeek.saturday

switch currentDay{
case .monday:
    print("Here it comes the start of yet another shitty week!")
case .saturday:
    print("At last some rest!")
case .sunday:
    print("Fucking last hours of freedom.")
default:
    print("Another shitty day of week!")
}


//As described in Control Flow, a switch statement must be exhaustive when considering an enumeration’s cases. If the case for .west is omitted, this code doesn’t compile, because it doesn’t consider the complete list of CompassPoint cases. Requiring exhaustiveness ensures that enumeration cases aren’t accidentally omitted.
//When it isn’t appropriate to provide a case for every enumeration case, you can provide a default case to cover any cases that aren’t addressed explicitly:



//Iterating over Enumeration Cases
//For some enumerations, it’s useful to have a collection of all of that enumeration’s cases. You enable this by writing : CaseIterable after the enumeration’s name. Swift exposes a collection of all the cases as an allCases property of the enumeration type. Here’s an example:

enum FoodItem: CaseIterable{
    case chicken_tikka , chicken_karahi, chicken_biryani
}

for _ in FoodItem.allCases{
//    print(i)
}

enum FoodItems: String, CaseIterable {
    case item1 = "Chicken Biryani"
    case item2 = "Chicken Karahi "
    case item3 = "Chicken Tikka"
    case item4 = "Chicken Handi"
}

for i in FoodItems.allCases {
    print(i.rawValue)
}


//Associated Values
//sometimes we may want to attach additional information to enum values. These additional information attached to enum values are called associated values.

enum Distance{
    case km(String)
    case mile(String)
}

//Here, (String) is additional information attached to the value km. It represents that the value of km can only be a String.

var n1 = Distance.km("Metric System")
//Here, "Metric System" is the value associated with the km value.
print(n1)

var n2 = Distance.mile("Imperial System")
 print(n2)

//cases of an enumeration can declare that they store associated values of different types. As an alternative to associated values, enumeration cases can come prepopulated with default values (called raw values), which are all of the same type.

enum RandomThings: Int {
    case car = 12
    case bike = 7
    case planes = 11 //Each raw value must be unique within its enumeration declaration.
}


print(RandomThings.bike.rawValue)

//Raw values are not the same as associated values. Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above. The raw value for a particular enumeration case is always the same. Associated values are set when you create a new constant or variable based on one of the enumeration’s cases, and can be different each time you do so.



//Implicitly Assigned Raw Values:
//When you’re working with enumerations that store integer or string raw values, you don’t have to explicitly assign a raw value for each case. When you don’t, Swift automatically assigns the values for you.
enum Queue: Int{
    case p1 = 1, p2, p3, p4
}

print(Queue.p3.rawValue)

//when integers are used for raw values, the implicit value for each case is one more than the previous case. If the first case doesn’t have a value set, its value is 0.

//When strings are used for raw values, the implicit value for each case is the text of that case’s name.

enum QueueP: String{
    case p1, p2, p3, p4
}

print(QueueP.p3.rawValue)


//“Initializing from a Raw Value
//If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called rawValue) and returns either an enumeration case or nil. You can use this initializer to try to create a new instance of the enumeration.

let possibleNum = Queue(rawValue: 4)
print(possibleNum!)

if let num = Queue(rawValue: 3){
    print(num)
}




//Recursive Enumerations
//A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases. You indicate that an enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection.

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// Define variables of type ArithmeticExpression enum
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let three = ArithmeticExpression.number(3)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, three)

// Evaluate the expression using recursive function
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))

//pitagor theorem for location
func distance(from source: (x: Int, y: Int) , to target: (x: Int, y: Int)) -> Double {
    let distanceX = Double(source.x - target.x)
    let distanceY = Double(source.y - target.y)
    
    return (distanceX * distanceX + distanceY * distanceY).squareRoot()
}

struct Location {
    let x: Int
    let y: Int
}

struct DeliveryArea: CustomStringConvertible {   //This protocol allows us to creato ToString method, we only need "description(String)" property
    let center: Location
    var radius: Double
    
    func Contains (_ location: Location) -> Bool {
        let distanceFromClient = distance(from: (location.x, location.y), to: (center.x, center.y))
        return distanceFromClient < radius
    }
    
    var description: String {
        """
        Area with center: (x: \(center.x), y: \(center.y)),
        radius: \(radius)
        """
    }
    
}

let storeLocation = Location(x: 2, y: 4) //initialize instantion of Location
var storeDeliveryArea = DeliveryArea(center: storeLocation, radius: 2.5)
storeDeliveryArea.radius = 2.1 // can change only if storeDeliveryArea is "var", if it is "let" you cannot change

let clientLocation = Location(x: 2, y: 3)
storeDeliveryArea.Contains(clientLocation)

var anotherStoreDeliveryArea = storeDeliveryArea
anotherStoreDeliveryArea.radius = 5
storeDeliveryArea.radius = 3
print("Area 1 radius = \(storeDeliveryArea.radius)")
print("Area 2 radius = \(anotherStoreDeliveryArea.radius)")

print(anotherStoreDeliveryArea)

// demo struct properties-get/set
struct TV {
    var height: Double
    var width: Double
    var diagonal: Int {    //"computed" property -> calculates its value, it is not stored
        get {
            let result = (height * height + width * width).squareRoot().rounded()
            return Int(result)
        } set {
            let ratioWidth = 16.0
            let ratioHeight = 9.0
            
            let ratioDiagonal = (ratioWidth * ratioWidth + ratioHeight * ratioHeight).squareRoot()
            height = Double(newValue) * ratioHeight / ratioDiagonal
            width = Double(newValue) * ratioWidth / ratioDiagonal
        }
    }
}

var tv = TV(height: 45, width: 100)
print(tv.diagonal)

tv.diagonal = 55
print(tv.height)
print(tv.width)

// property observers demo --- willSet (we call it before the setter)  didSet (we call it after the setter)
struct Level {
    static var highestLevel = 1
    var id: Int
    var boss: String
    var unlocked: Bool {
        didSet {
            if Self.highestLevel < id && unlocked {
                Self.highestLevel = id
            }
        }
    }
}

let highestLevel = Level.highestLevel
var newLevel = Level(id: 1, boss: "Chupacabra", unlocked: false)
print(Level.highestLevel)
newLevel.id = 2
newLevel.unlocked = true
print(Level.highestLevel)

// methods demo
let months = ["January","February","March","April","May","June",
              "July","August","September","October","November","December"]

struct SimpleDate {
    var month: String
    var day: Int
    
    init() {
        month = "January"
        day = 1
    }
    
    init(month: String, day: Int) {
        self.month = month
        self.day = day
    }
    
    func monthUntilWinterBreak() -> Int {
        months.firstIndex(of: "December")! - months.firstIndex(of: month)!
    }
    
    //mutating demo - if we change the value of a property we need to use "mutatuing"
    mutating func advance() {
        day += 1
    }
}

let date = SimpleDate(month: "March", day: 2)
print(date.monthUntilWinterBreak())

//using SimpleDate with empty initializer(constructor)
var newDate = SimpleDate()
newDate.advance()

//type methods demo
struct Math {
    static func factorial(of number: Int) -> Int {
        (1...number).reduce(1, *)
    }
}

//we can add functionality to existing struct/class/enumeration
extension Math {
    static func primeFactors(of value: Int) -> [Int] {
        var remainingValue = value
        var testFactor = 2
        var primes: [Int] = []
        
        while testFactor * testFactor <= remainingValue {
            if remainingValue % testFactor == 0 {
                primes.append(testFactor)
                remainingValue /= testFactor
            } else {
                testFactor += 1
            }
        }
        
        if remainingValue > 1 {
            primes.append(remainingValue)
        }
        
        return primes
    }
}

Math.factorial(of: 6)
Math.primeFactors(of: 81)

//classes demo -- class is reference type / struct is value type
class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

}

let person = Person(firstName: "Stoyko", lastName: "Kolev")

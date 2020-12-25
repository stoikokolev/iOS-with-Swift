//Generics demo
protocol Pet{
    var name: String { get }
}

protocol Meowable {
    func meow()
}

class Cat: Pet {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

extension Cat: Meowable {
    func meow() {
        print("\(self.name) says meow!")
    }
}

//extends when class Array is cats each elemet to meow
extension Array: Meowable where Element: Meowable {
    func meow() {
        forEach { $0.meow() }
    }
}

class Dog: Pet {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}

//Animal is just a name, we need to choice descripable name
//Pet is "type constraint"
class Keeper<Animal: Pet> {
    var name: String
    var morningCare: Animal
    var eveningCare: Animal
    
    init(_ name: String, morningCare: Animal, eveningCare: Animal) {
        self.name = name
        self.morningCare = morningCare
        self.eveningCare = eveningCare
    }
}

let keeper = Keeper("Jason", morningCare: Cat("Whiskers"), eveningCare: Cat("Sleepy"))
let keeperOfDogs = Keeper("Annie", morningCare: Dog("Sharo"), eveningCare: Dog("Bobby"))

//Array extension demo
let carArray = [Cat("Tommy"), Cat("Whiskers"), Cat("Sleepy")]
carArray.meow()

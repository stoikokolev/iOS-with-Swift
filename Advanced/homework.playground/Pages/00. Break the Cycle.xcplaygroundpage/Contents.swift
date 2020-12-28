//: A collegue of yours is working on this super important feature, he hasn't slept in days
//: Finally, he asks you to review his code for him in case he missed something
//: Find out what's wrong and fix it

class Person {
    let name: String
    let email: String
    var car: Car?
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    deinit {
        print("Goodbye \(name)!")
    }
}

class Car {
    let id: Int
    let type: String
    var owner: Person?
    
    init(id: Int, type: String) {
        self.id = id
        self.type = type
    }
    
    deinit {
        print("Goodbye \(type)!")
    }
}

var owner: Person? = Person(name: "Cosmin",
                            email: "cosmin@whatever.com")
var car: Car? = Car(id: 10, type: "BMW")

owner?.car = car
car?.owner = owner

owner = nil
car = nil

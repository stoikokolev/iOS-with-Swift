protocol Feedable {
    func Feed()
}

protocol Flyable {
    var isCaged: Bool {get}
    func Cage(cage: Cage)
}

protocol Swimable {
    var isTanked: Bool {get}
    func Tank(tank: Tank)
}

protocol Walkable {
    func Exercise()
}

protocol Cleanable {
    func Clean()
}

class Animal: Feedable {
    let Name: String
    
    init (name: String) {
        self.Name = name
    }
    
    func Feed() {
        print("Eating")
    }
}

class Fish: Animal, Swimable {
    var isTanked: Bool
    
    init (name: String, isTanked: Bool) {
        self.isTanked = isTanked
        super.init(name: name)
    }
    
    func Tank(tank: Tank) {
        if isTanked == false {
            tank.fishes.append(self)
            isTanked = true
            print("Tanked")
        } else {
            print("Already tanked")
        }
    }
}

class Tank: Cleanable {
    var fishes: [Fish]
    init () {
        fishes = []
    }
    
    func Clean() {
        print("Cleaned")
        
    }
}

class Cage: Cleanable {
    var birds: [Bird]
    init () {
        birds = []
    }
    
    func Clean() {
        print("Cleaned")
    }
}

class Bird: Animal, Flyable {
    var isCaged: Bool
    
    init (name: String, isCaged: Bool) {
        self.isCaged = isCaged
        super.init(name: name)
    }
    
    func Cage(cage: Cage) {
        if isCaged == false {
            cage.birds.append(self)
            isCaged = true
            print("Caged")
        } else {
            print("Already caged")
        }
    }
}

class Dog: Animal, Walkable {
    func Exercise() {
        print("Walking")
    }
}

class Cat: Animal, Walkable {
    func Exercise() {
        print("Walking")
    }
}

let tank1 = Tank()
let cage1 = Cage()
let dog1 = Dog(name: "Bob")
let dog2 = Dog(name: "Mike")
let cat1 = Dog(name: "Tom")
let cat2 = Dog(name: "Jon")
let fish1 = Fish(name: "Sharan", isTanked: false)
let fish2 = Fish(name: "Skumria", isTanked: true)
let bird1 = Bird(name: "Eagle", isCaged: true)
let bird2 = Bird(name: "Owl", isCaged: false)

tank1.fishes.append(fish2)
cage1.birds.append(bird1)

let cleanable: [Cleanable] = [tank1, cage1]
let walkable: [Walkable] = [dog1, dog1, cat1, cat2]
let flyable: [Flyable] = [bird1, bird2]
let swimable: [Swimable] = [fish2, fish1]
let feedable: [[Any]] = [walkable, flyable, swimable, cleanable]

for group in feedable {
    for animal in group {
        if let a = animal as? Animal {
            a.Feed()
        }
        if let w = animal as? Walkable {
            w.Exercise()
        } else if let f = animal as? Flyable {
            f.Cage(cage: cage1)
        }  else if let s = animal as? Swimable {
            s.Tank(tank: tank1)
        }  else if let c = animal as? Cleanable {
            c.Clean()
        }
    }
}

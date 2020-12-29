class Pet {
    var breed: String?
    
    init(_ breed: String? = nil) {
        self.breed = breed
    }
}

class Person {
    let pet: Pet?
    
    init(_ pet: Pet? = nil) {
        self.pet = pet
    }
}

let delia = Pet("pug")
let olive = Pet()

let annie = Person(olive)
let brandon = Person(delia)
let charlie = Person()

if let breed = charlie.pet?.breed {
    print(breed)
} else {
    print("No breed")
}

guard let breed = brandon.pet?.breed else {
    fatalError()
}

print(breed)

let userInput = ["2", "4", "haha", "3"]
let arrayOfInt = userInput.compactMap { Int($0) }
print(arrayOfInt)

//-----------------------------------------------

class Pastry {
    let flavour: String
    var numberOnHand: Int
    
    init(_ flavour: String, numberOfHand: Int) {
        self.flavour = flavour
        self.numberOnHand = numberOfHand
    }
}

enum BakeryError: Error {
    case tooFew(numberOfHand: Int)
    case doNotSell
    case wrongFlavor
}

class Bakery {
    var itemsForSale = [
        "Cookie": Pastry("ChocolateChip", numberOfHand: 20),
        "PopTart": Pastry("WildBerry", numberOfHand: 13),
        "Donut": Pastry("Sprinked", numberOfHand: 24),
        "HandPie": Pastry("Cherry", numberOfHand: 6)
    ]
    
    func orderPastry(_ item: String, amountRequested: Int, flavor: String) throws {
        guard let pastry = itemsForSale[item] else {
            throw BakeryError.doNotSell
        }
        
        guard flavor == pastry.flavour else {
            throw BakeryError.wrongFlavor
        }
        
        guard amountRequested <= pastry.numberOnHand else {
            throw BakeryError.tooFew(numberOfHand: pastry.numberOnHand)
        }
        
        pastry.numberOnHand -= amountRequested
    }
}

let bakery = Bakery()

do {
    try bakery.orderPastry("Cookie", amountRequested: 42, flavor: "ChocolateChip")
} catch BakeryError.doNotSell {
    print("Sorry, but we don't sell this item")
} catch BakeryError.tooFew {
    print("Sorry, we don't have enough items to fufll your order")
} catch BakeryError.wrongFlavor {
    print("Sorry, but we don't carry whis flavor")
}


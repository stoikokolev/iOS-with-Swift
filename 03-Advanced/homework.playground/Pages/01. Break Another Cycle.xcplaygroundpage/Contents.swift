//: Wow, you're getting really good, really fast so another of your colleagues asks you to review some code
//: Check if there's somethin to be concerned about and fix it

class Customer {
    let name: String
    let email: String
    var account: Account?
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    deinit {
        print("Goodbye \(name)!")
    }
}

class Account {
    let number: Int
    let type: String
    let customer: Customer
    
    init(number: Int, type: String, customer: Customer) {
        self.number = number
        self.type = type
        self.customer = customer
    }
    
    deinit {
        print("Goodbye \(type) account number \(number)!")
    }
}

var customer: Customer? = Customer(name: "George",
                                   email: "george@whatever.com")
var account: Account? = Account(number: 10, type: "PayPal",
                                customer: customer!)

customer?.account = account

account = nil
customer = nil

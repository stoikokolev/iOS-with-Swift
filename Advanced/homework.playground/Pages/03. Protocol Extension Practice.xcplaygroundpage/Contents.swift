//:  Suppose you own a retail store. You have food items, clothes and electronics. Begin with an Item protocol:

protocol Item {
  var name: String { get }
  var clearance: Bool { get }
  var msrp: Double { get } // Manufacturer’s Suggested Retail Price
  var totalPrice: Double { get }
}

/*:
 Fulfill the following requirements using primarily what you’ve learned about protocol-oriented programming. In other words, minimize the code in your classes, structs or enums.
 - Clothes do not have sales tax, but all other items have 7.5% sales tax.
 - When on clearance, food items are discounted 50%, clothes are discounted 25% and electronics are discounted 5%.
 - Items should implement CustomStringConvertible and return name. Food items should also print their expiration dates.
 */

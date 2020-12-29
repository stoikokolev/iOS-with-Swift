import UIKit

struct Employee : Codable {
    var name: String
    var id: Int
    var favoriteToy: Toy?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "employeeID"
        case name
        case favoriteToy
    }
}

//IMPORTANT
extension Employee {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(favoriteToy?.name, forKey: .favoriteToy)
        try container.encode(id, forKey: .id)
    }
}

extension Employee {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int.self, forKey: .id)
        if let gift = try values.decodeIfPresent(String?.self, forKey: .favoriteToy) {
            self.favoriteToy = Toy(name: gift!)
        }
    }
}

struct Toy: Codable {
    var name: String
}

let toy = Toy(name: "Teddy Bear")
let employee = Employee (name: "Annie Wilson", id: 1, favoriteToy: toy)

let jsonEncoder = JSONEncoder()
let jsonData = try jsonEncoder.encode(employee)
let jsonString = String(data: jsonData, encoding: .utf8)
print(jsonString!)

let jsonDecoder = JSONDecoder()
let employee1 = try jsonDecoder.decode(Employee.self, from: jsonData)
print(employee1.name)

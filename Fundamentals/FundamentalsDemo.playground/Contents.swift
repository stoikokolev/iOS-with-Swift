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




// Optional binding
var reading1: Float?
var reading2: Float?
var reading3: Float?

reading1 = 0; reading2 = 0; reading3 = 1.0
if let r1 = reading1,
   let r2 = reading2,
   let r3 = reading3 {
    let r = (r1 + r2 + r3) / 3
    print(r)
} else {
    print("some readingi is nil")
}

let nameByParkingSpace = [13: "Alice", 27: "Bob"]
// Check key exists
if let spaceXAssignee = nameByParkingSpace[13] {
    print(spaceXAssignee)
}

enum PieType: Int {
    case apple = 0
    case cherry
    case pecan
}

if let pieType = PieType(rawValue: 2) {
    print("got a valid PieType: \(pieType)")
}



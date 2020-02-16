import Foundation

class Card: NSObject {
    var color: Color
    var value: Value
    
    init(color: Color, value: Value) {
        self.color = color
        self.value = value
        super.init()
    }
    
    override var description: String {
        return "Value: \(self.value), Color: \(self.color)"
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Card {
            return (self.color == object.color && self.value == object.value)
        }
        return false
    }
}

func ==(card1: Card, card2: Card) -> Bool {
    return (card1.color == card2.color && card1.value == card2.value)
}

import Foundation

class Deck: NSObject {
    static let allSpades    :[Card] = Value.allValues.map({Card(color:Color.Spade, value:$0)})
    static let allDiamonds  :[Card] = Value.allValues.map({Card(color:Color.Diamond, value:$0)})
    static let allHearts    :[Card] = Value.allValues.map({Card(color:Color.Heart, value:$0)})
    static let allClubs     :[Card] = Value.allValues.map({Card(color:Color.Club, value:$0)})
    
    static let allCards     :[Card] = allSpades + allDiamonds + allHearts + allClubs
}

extension Array {
    mutating func riffle(){
        var index = 0
        for i in 0..<self.count{
            index = Int(arc4random_uniform(UInt32(self.count)))
            if i != index{
                self.swapAt(i, index)
            }
        }
    }
}

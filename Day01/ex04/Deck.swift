import Foundation

class Deck: NSObject {
    static let allSpades    :[Card] = Value.allValues.map({Card(color:Color.Spade, value:$0)})
    static let allDiamonds  :[Card] = Value.allValues.map({Card(color:Color.Diamond, value:$0)})
    static let allHearts    :[Card] = Value.allValues.map({Card(color:Color.Heart, value:$0)})
    static let allClubs     :[Card] = Value.allValues.map({Card(color:Color.Club, value:$0)})
    
    static let allCards     :[Card] = allSpades + allDiamonds + allHearts + allClubs

    var cards:      [Card] = allCards
    var discards:   [Card] = []
    var outs:       [Card] = []
    
    init(mixed: Bool) {
        self.cards = Deck.allCards
        if mixed == false {
            self.cards.riffle()
        }
    }
    
    override public var description: String {
        return(self.cards.description)
    }
    
    func draw() -> Card? {
        guard let card = self.cards.first else {
            return nil
        }
        self.outs.append(card)
        self.cards.remove(at:0)
        return card
    }
    
    func fold(c: Card) {
        var index = 0
        for OutCard in self.outs {
            if c == outCard{
                self.discards.append(outCard)
                self.outs.remove(at:index)
            }
            index += 1
        }
    }
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

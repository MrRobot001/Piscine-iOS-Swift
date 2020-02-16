var cards = Deck(mixed: false)
var card: Card?

print(cards)

card = cards.draw()
card = cards.draw()
card = cards.draw()
card = cards.draw()
card = cards.draw()
card = cards.draw()
card = cards.draw()
card = cards.draw()
card = cards.draw()
card = cards.draw()

card = nil

print("")
for i in cards.outs {
        print("outs[i] = \(i)")
}
print("")
cards.fold(c: cards.outs[0])
cards.fold(c: cards.outs[1])
cards.fold(c: cards.outs[2])
cards.fold(c: cards.outs[3])

for i in cards.discards {
        print("discards[i] = \(i)")
}
print("")
for i in cards.outs {
        print("outs[i] = \(i)")
}
print("")
for i in cards.cards {
      print(i)
}

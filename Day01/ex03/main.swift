var cards = Deck.allCards

print("Cards in Deck:")
print(cards)

cards.riffle()

print("Cards in Deck:\n")
for card in cards {
    print(card)
}

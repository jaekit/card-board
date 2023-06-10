class_name CardPile extends Node


var _cards: Array[Card] = []


# Add a card at the given index. If index == -1, add at the end.
func add(card: Card, index := -1) -> void:
	if index == -1:
		index = _cards.size()
	_cards.insert(index, card)


# Remove and return the Card at the given index.
func draw(index := 0) -> Card:
	var card := _cards[index]
	_cards.remove_at(index)
	return card


# Return the Card at the given index.
func peek(index := 0) -> Card:
	return _cards[index]


func shuffle() -> void:
	_cards.shuffle()


func size() -> int:
	return _cards.size()


func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		for card in _cards:
			card.free()

abstract class InventoryEvent {}

class LoadInventoryItems extends InventoryEvent {}

class AddInventoryItemEvent extends InventoryEvent {
  final Map<String, dynamic> itemData;
  AddInventoryItemEvent(this.itemData);
}

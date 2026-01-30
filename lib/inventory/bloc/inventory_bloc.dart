import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/inventory_repository.dart';
import 'inventory_event.dart';
import 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryRepository _inventoryRepository;

  InventoryBloc(this._inventoryRepository) : super(InventoryInitial()) {
    on<LoadInventoryItems>(_onLoadInventoryItems);
  }

  Future<void> _onLoadInventoryItems(
    LoadInventoryItems event,
    Emitter<InventoryState> emit,
  ) async {
    emit(InventoryLoading());
    try {
      final items = await _inventoryRepository.getInventoryItems();
      emit(InventoryLoaded(items));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }
}

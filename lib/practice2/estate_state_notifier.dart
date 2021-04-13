import 'package:axia_works_youtube/practice2/repository/estate_repository.dart';
import 'package:axia_works_youtube/practice2/state/estate_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EstateStateNotifier extends StateNotifier<EstateState> {
  EstateStateNotifier() : super(EstateState()) {
    fetchEstateItems();
  }

  EstateRepository _repository = EstateRepository();

  fetchEstateItems() async {
    state = state.copyWith(
      isLoading: true,
    );

    final estateItems = await _repository.fetchEstateItems();

    if (estateItems.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        isReadyData: true,
        estateItem: estateItems,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isReadyData: false,
        estateItem: estateItems,
      );
    }
  }
}

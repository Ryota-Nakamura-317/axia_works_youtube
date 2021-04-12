import 'package:axia_works_youtube/async/model/async_item.dart';
import 'package:axia_works_youtube/async/state/async_state.dart';
import 'package:axia_works_youtube/prefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncStateNotifier extends StateNotifier<AsyncState> {
  AsyncStateNotifier() : super(AsyncState()) {
    loadUserData();
  }

  writeUserData(String name, int age, String birthday) async {
    state = state.copyWith(
      isLoading: true,
    );
    await Prefs.setName(name);
    await Prefs.setAge(age);
    await Prefs.setBirthday(birthday);
    loadUserData();
  }

  loadUserData() async {
    state = state.copyWith(
      isLoading: true,
    );

    final asyncItems = AsyncItem(
      name: await Prefs.getName(),
      age: await Prefs.getAge(),
      birthday: await Prefs.getBirthday(),
    );

    state = state.copyWith(
      isLoading: false,
      isReadyData: asyncItems.name != null,
      asyncItem: asyncItems,
    );
  }
}

import 'package:axia_works_youtube/async/model/async_item.dart';
import 'package:axia_works_youtube/async/state/async_state.dart';
import 'package:axia_works_youtube/prefs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncStateNotifier extends StateNotifier<AsyncState> {
  AsyncStateNotifier() : super(AsyncState()) {
    readUserData();
  }

  writeUserData(String name, int age, String birthday) async {
    state = state.copyWith(
      isLoading: true,
    );
    await Prefs.setName(name);
    await Prefs.setAge(age);
    await Prefs.setBirthday(birthday);
    readUserData();
  }

  readUserData() async {
    state = state.copyWith(
      isLoading: true,
    );

    final name = await Prefs.getName();
    final age = await Prefs.getAge();
    final birthday = await Prefs.getBirthday();

    final asyncItems = AsyncItem(
      name: name ?? '',
      age: age ?? 0,
      birthday: birthday ?? '',
    );

    state = state.copyWith(
      isLoading: false,
      isReadyData: asyncItems.name.isNotEmpty,
      asyncItem: asyncItems,
    );
  }
}

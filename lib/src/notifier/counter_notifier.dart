import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/counter_model.dart';

class CounterNotifier extends StateNotifier<CounterModel> {
  CounterNotifier() : super(CounterModel());

  CounterModel getValue() => state;

  void add() {
    state.status = CounterEnum.addWait;
  }

  void reduce() {
    state.status = CounterEnum.reduceWait;
  }

  void equal() {
    switch (state.status) {
      case CounterEnum.add:
        state.number = (double.parse(state.number) + double.parse(state.temp)).toString();
        break;
      case CounterEnum.reduce:
        state.number = (double.parse(state.number) - double.parse(state.temp)).toString();
        break;
      case CounterEnum.none:
        break;
      default:
        break;
    }
    state.temp = "0";
    state.status = CounterEnum.none;
  }

  void inputNumber(String chat) {
    if (state.status != CounterEnum.none) {
      checkStatus();
      state.temp = addString(state.temp, chat);
    } else {
      state.number = addString(state.number, chat);
    }
  }

  void clear() {
    if (state.status == CounterEnum.add || state.status == CounterEnum.reduce && state.temp != "0") {
      state.temp = "0";
    } else {
      state.status = CounterEnum.none;
      state.temp = "0";
      state.number = "0";
    }
  }

  String addString(String origin, String chat) {
    if ((origin == "0" && chat == "0") || (origin.indexOf(".") == origin.length - 1 && chat == ".") || origin.contains(".")) {
      return origin;
    } else {
      return origin == "0" ? origin = chat : origin += chat;
    }
  }

  void checkStatus() {
    if (state.status == CounterEnum.addWait) {
      state.status = CounterEnum.add;
    } else if (state.status == CounterEnum.reduceWait) {
      state.status = CounterEnum.reduce;
    }
  }
}

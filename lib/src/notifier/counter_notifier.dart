import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/counter_model.dart';

class CounterNotifier extends StateNotifier<CounterModel> {
  CounterNotifier() : super(CounterModel());

  CounterModel getValue() => state;

  void add() {
    state.temp = "0";
    state.status = CounterEnum.addWait; //當輸入加減數時才會將狀態改為
  }

  void reduce() {
    state.temp = "0";
    state.status = CounterEnum.reduceWait;
  }

  void equal() {
    switch (state.status) {
      case CounterEnum.add:
        state.number = (Decimal.parse(state.number) + Decimal.parse(state.temp)).toString();
        break;
      case CounterEnum.reduce:
        state.number = (Decimal.parse(state.number) - Decimal.parse(state.temp)).toString();
        break;
      default:
        break;
    }
    state.temp = "0";
    state.status = CounterEnum.none;
  }

  void inputNumber(String chat) {
    if (state.status != CounterEnum.none) {
      changeStatus();
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
    ///阻擋一直輸入0及小數點
    if ((origin == "0" && chat == "0") || (origin.contains(".") && chat == ".")) {
      return origin;
    } else {
      return origin == "0" && chat != "." ? origin = chat : origin += chat;
    }
  }

  void changeStatus() {
    if (state.status == CounterEnum.addWait) {
      state.status = CounterEnum.add;
    } else if (state.status == CounterEnum.reduceWait) {
      state.status = CounterEnum.reduce;
    }
  }
}

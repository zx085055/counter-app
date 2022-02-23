class CounterModel {
  CounterEnum status;
  String number; ///被加減數
  String temp; ///加減數

  CounterModel({
    this.status = CounterEnum.none,
    this.number = "0",
    this.temp = "0",
  });
}


enum CounterEnum {
  none,
  add,
  addWait,
  reduce,
  reduceWait,
}
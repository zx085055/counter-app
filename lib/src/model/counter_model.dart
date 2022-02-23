class CounterModel {
  CounterEnum? status;
  String number;
  String temp;

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
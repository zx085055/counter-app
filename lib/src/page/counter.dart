import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_counter/src/notifier/counter_notifier.dart';
import '../model/counter_model.dart';

/// * 操作流程
/// 加減號亮時會顯示被加減數，需輸入加減數符號才會暗下來
/// 輸入完加減數後必須點等於運算才會顯示加減後結果並清除加減數
/// 加減數清除後可再次輸入，再次清除時會把被加減數清除
/// *

final counterProvider = StateProvider((ref) {
  return CounterNotifier();
});

class Counter extends ConsumerWidget {
  const Counter({Key? key}) : super(key: key);

  final double horizontalSpacing = 10.0; //水平間距
  final double verticalSpacing = 10.0; //垂直間距

  Widget _numCircleButton({required WidgetRef ref, required String num, Color buttonBg = Colors.amber, OutlinedBorder? shape}) {
    return SizedBox(
      width: shape != null ? 138 : 64,
      height: 64,
      child: ElevatedButton(
        onPressed: () {
          ref.read(counterProvider.state).state.inputNumber(num);
          ref.refresh(counterProvider.state);
        },
        child: Text(
          num,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: shape ?? const CircleBorder(),
          primary: buttonBg,
          onPrimary: Colors.white30,
        ),
      ),
    );
  }

  Widget _functionCircleButton({required Widget child}) {
    return SizedBox(
      width: 64,
      height: 64,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.only(right: 16),
                child: Consumer(
                  builder: (context, textRef, _) {
                    final CounterModel model = textRef.watch(counterProvider.state).state.getValue();
                    return Text(
                      model.status == CounterEnum.add || model.status == CounterEnum.reduce ? model.temp : model.number,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 90,
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                ///數字列
                Expanded(
                  child: Container(
                    height: 400,
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _numCircleButton(
                              ref: ref,
                              num: "7",
                            ),
                            SizedBox(
                              width: horizontalSpacing,
                            ),
                            _numCircleButton(
                              ref: ref,
                              num: "8",
                            ),
                            SizedBox(
                              width: horizontalSpacing,
                            ),
                            _numCircleButton(
                              ref: ref,
                              num: "9",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: verticalSpacing,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _numCircleButton(
                              ref: ref,
                              num: "4",
                            ),
                            SizedBox(
                              width: horizontalSpacing,
                            ),
                            _numCircleButton(
                              ref: ref,
                              num: "5",
                            ),
                            SizedBox(
                              width: horizontalSpacing,
                            ),
                            _numCircleButton(
                              ref: ref,
                              num: "6",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: verticalSpacing,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _numCircleButton(
                              ref: ref,
                              num: "1",
                            ),
                            SizedBox(
                              width: horizontalSpacing,
                            ),
                            _numCircleButton(
                              ref: ref,
                              num: "2",
                            ),
                            SizedBox(
                              width: horizontalSpacing,
                            ),
                            _numCircleButton(
                              ref: ref,
                              num: "3",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: verticalSpacing,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _numCircleButton(
                              ref: ref,
                              num: "0",
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            SizedBox(
                              width: horizontalSpacing,
                            ),
                            _numCircleButton(
                              ref: ref,
                              num: ".",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ///符號列
                Container(
                  height: 400,
                  width: 90,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Consumer(
                        builder: (context, addRef, _) {
                          final CounterEnum watchStatus = addRef.watch(counterProvider.state).state.getValue().status;
                          return _functionCircleButton(
                            child: ElevatedButton(
                              onPressed: () {
                                ref.read(counterProvider.state).state.add();
                                ref.refresh(counterProvider.state);
                              },
                              child: Icon(Icons.add, color: watchStatus == CounterEnum.addWait ? Colors.amber : Colors.white),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                primary: watchStatus == CounterEnum.addWait ? Colors.white : Colors.amber,
                                onPrimary: Colors.white30,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: verticalSpacing,
                      ),
                      Consumer(
                        builder: (context, reduceRef, _) {
                          final CounterEnum watchStatus = reduceRef.watch(counterProvider.state).state.getValue().status;
                          return _functionCircleButton(
                            child: ElevatedButton(
                              onPressed: () {
                                ref.read(counterProvider.state).state.reduce();
                                ref.refresh(counterProvider.state);
                              },
                              child: Icon(Icons.remove, color: watchStatus == CounterEnum.reduceWait ? Colors.amber : Colors.white),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                primary: watchStatus == CounterEnum.reduceWait ? Colors.white : Colors.amber,
                                onPrimary: Colors.white30,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: verticalSpacing,
                      ),
                      _functionCircleButton(
                        child: ElevatedButton(
                          onPressed: () {
                            ref.read(counterProvider.state).state.clear();
                            ref.refresh(counterProvider.state);
                          },
                          child: const Text(
                            "C",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            primary: Colors.amber,
                            onPrimary: Colors.white30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: verticalSpacing,
                      ),
                      _functionCircleButton(
                        child: ElevatedButton(
                          onPressed: () {
                            ref.read(counterProvider.state).state.equal();
                            ref.refresh(counterProvider.state);
                          },
                          child: const Text(
                            "=",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            primary: Colors.amber,
                            onPrimary: Colors.white30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

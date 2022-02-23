import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_counter/src/notifier/counter_notifier.dart';

import '../model/counter_model.dart';

final counterProvider = StateProvider((ref) {
  return CounterNotifier();
});

Widget circleButton({required Function onPressed, required Widget child, Color buttonBg = Colors.amber}) {
  return SizedBox(
    width: 64,
    height: 64,
    child: ElevatedButton(
      onPressed: onPressed(),
      child: child,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        primary: buttonBg,
        onPrimary: Colors.white30,
      ),
    ),
  );
}

class Counter extends ConsumerWidget {
  const Counter({Key? key}) : super(key: key);

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
                Expanded(
                  child: Container(
                    height: 400,
                    padding: const EdgeInsets.only(top: 10),
                    child: Wrap(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: ElevatedButton(
                                onPressed: () {
                                  ref.read(counterProvider.state).state.inputNumber("7");
                                  ref.refresh(counterProvider.state);
                                },
                                child: const Text(
                                  "7",
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
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: ElevatedButton(
                                onPressed: () {
                                  ref.read(counterProvider.state).state.inputNumber("8");
                                  ref.refresh(counterProvider.state);
                                },
                                child: const Text(
                                  "8",
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
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: ElevatedButton(
                                onPressed: () {
                                  ref.read(counterProvider.state).state.inputNumber("9");
                                  ref.refresh(counterProvider.state);
                                },
                                child: const Text(
                                  "9",
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
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  width: 90,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Consumer(
                        builder: (context, addRef, _) {
                          return SizedBox(
                            width: 64,
                            height: 64,
                            child: ElevatedButton(
                              onPressed: () {
                                ref.read(counterProvider.state).state.add();
                                ref.refresh(counterProvider.state);
                              },
                              child: Icon(Icons.add,
                                  color: addRef.watch(counterProvider.state).state.getValue().status == CounterEnum.addWait ? Colors.amber : Colors.white),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                primary: addRef.watch(counterProvider.state).state.getValue().status == CounterEnum.addWait ? Colors.white : Colors.amber,
                                onPrimary: Colors.white30,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer(
                        builder: (context, reduceRef, _) {
                          return SizedBox(
                            width: 64,
                            height: 64,
                            child: ElevatedButton(
                              onPressed: () {
                                ref.read(counterProvider.state).state.reduce();
                                ref.refresh(counterProvider.state);
                              },
                              child: Icon(Icons.remove,
                                  color:
                                      reduceRef.watch(counterProvider.state).state.getValue().status == CounterEnum.reduceWait ? Colors.amber : Colors.white),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                primary: reduceRef.watch(counterProvider.state).state.getValue().status == CounterEnum.reduceWait ? Colors.white : Colors.amber,
                                onPrimary: Colors.white30,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 64,
                        height: 64,
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
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 64,
                        height: 64,
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

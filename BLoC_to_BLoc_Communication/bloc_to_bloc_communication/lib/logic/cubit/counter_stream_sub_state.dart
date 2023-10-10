part of 'counter_stream_sub_cubit.dart';

class CounterState {
  int counterValue;
  bool wasIncremented;

  CounterState({
    required this.counterValue,
    this.wasIncremented = false,
  });
}

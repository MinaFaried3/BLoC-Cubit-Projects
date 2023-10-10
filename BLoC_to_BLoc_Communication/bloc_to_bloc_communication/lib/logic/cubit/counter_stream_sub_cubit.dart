import 'dart:async';

import 'package:bloc/bloc.dart';

import 'internet_cubit.dart';

part 'counter_stream_sub_state.dart';

class CounterStreamSubCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  late StreamSubscription internetCubitStreamSubscription;
  CounterStreamSubCubit({required this.internetCubit})
      : super(CounterState(counterValue: 0)) {
    monitorInternetCubit();
  }

  void monitorInternetCubit() {
    internetCubitStreamSubscription =
        internetCubit.stream.listen((internetState) {
      if (internetState is InternetConnected) {
        increment();
      } else if (internetState is InternetDisconnected) {
        decrement();
      }
    });
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));

  @override
  Future<void> close() async {
    await internetCubitStreamSubscription.cancel();
    super.close();
  }
}

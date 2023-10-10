import 'package:bloc_to_bloc_communication/constants/enums.dart';
import 'package:bloc_to_bloc_communication/logic/cubit/counter_stream_sub_cubit.dart';
import 'package:bloc_to_bloc_communication/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StreamSubScreen extends StatefulWidget {
  const StreamSubScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  StreamSubScreenState createState() => StreamSubScreenState();
}

class StreamSubScreenState extends State<StreamSubScreen> {
  GlobalKey<ScaffoldState> homeScreenKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScreenKey,
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.wifi) {
                return const Text(
                  "WIFI",
                  style: TextStyle(fontSize: 30, color: Colors.green),
                );
              } else if (state is InternetConnected &&
                  state.connectionType == ConnectionType.mobileData) {
                return const Text(
                  "MOBILE",
                  style: TextStyle(fontSize: 30, color: Colors.orangeAccent),
                );
              } else if (state is InternetDisconnected) {
                return const Text(
                  "Disconnected",
                  style: TextStyle(fontSize: 30, color: Colors.redAccent),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
            BlocConsumer<CounterStreamSubCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'BRR, NEGATIVE ${state.counterValue}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state.counterValue % 2 == 0) {
                  return Text(
                    'YAAAY ${state.counterValue}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state.counterValue == 5) {
                  return Text(
                    'HMM, NUMBER 5',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text(widget.title),
                  onPressed: () {
                    BlocProvider.of<CounterStreamSubCubit>(context).decrement();
                    // context.bloc<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: Text('${widget.title} 2nd'),
                  onPressed: () {
                    BlocProvider.of<CounterStreamSubCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: Colors.redAccent,
              child: const Text(
                'Go to Bloc Listener Screen',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/second',
                  arguments: homeScreenKey,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

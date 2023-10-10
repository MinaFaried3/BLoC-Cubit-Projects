import 'package:bloc_to_bloc_communication/presentation/screens/bloc_listener_screen.dart';
import 'package:bloc_to_bloc_communication/presentation/screens/stream_sub_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const StreamSubScreen(
            title: "Stream Sub Screen",
            color: Colors.blueAccent,
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => const BlocListenerScreen(
            title: "Bloc Listener Screen",
            color: Colors.redAccent,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const StreamSubScreen(
            title: "Home Screen",
            color: Colors.blueAccent,
          ),
        );
    }
  }
}

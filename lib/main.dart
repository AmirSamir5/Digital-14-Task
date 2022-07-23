import 'package:digital_14_task/screens/events/bloc/events_bloc.dart';
import 'package:digital_14_task/screens/events/model/event_repo.dart';
import 'package:digital_14_task/screens/events/view/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: Eventsbloc(EventRepository())),
      ],
      child: MaterialApp(
        title: 'Digital 14',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'HelveticaNeue',
                  color: Colors.white,
                ),
                headline1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Avenir',
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 8.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  ],
                ))),
        home: const EventsScreen(),
      ),
    );
  }
}

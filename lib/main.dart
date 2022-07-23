import 'package:digital_14_task/screens/home/bloc/events_bloc.dart';
import 'package:digital_14_task/screens/home/model/event_repo.dart';
import 'package:digital_14_task/screens/home/view/events_screen.dart';
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
        ),
        home: const EventsScreen(),
      ),
    );
  }
}

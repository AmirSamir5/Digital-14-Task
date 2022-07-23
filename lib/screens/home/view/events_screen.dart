import 'package:digital_14_task/screens/home/bloc/events_bloc.dart';
import 'package:digital_14_task/screens/home/bloc/events_event.dart';
import 'package:digital_14_task/screens/home/bloc/events_state.dart';
import 'package:digital_14_task/screens/home/view/widgets/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  bool _isInit = true;
  bool _displayLoadingIndicator = false;
  Eventsbloc? eventsbloc;

  @override
  void initState() {
    if (_isInit) {
      eventsbloc = BlocProvider.of<Eventsbloc>(context);
      eventsbloc!.add(GetEventsEvent());
      _isInit = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: BlocConsumer<Eventsbloc, EventsState>(
            listener: (context, state) {
              if (state is EventsIsLoading) {
                _displayLoadingIndicator = true;
              } else {
                _displayLoadingIndicator = false;
              }
            },
            builder: (context, state) {
              if (state is EventsLoadedSuccessfully) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.events.length,
                  itemBuilder: ((context, index) {
                    return EventWidget(event: state.events[index]);
                  }),
                );
              } else if (state is EventsLoadedFailed) {
                return Center(
                  child: InkWell(
                    onTap: () => eventsbloc!.add(GetEventsEvent()),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(state.errorMessage),
                        const SizedBox(height: 8),
                        const Text(
                          'Retry',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
              ;
            },
          ),
        ),
      ),
    );
  }
}

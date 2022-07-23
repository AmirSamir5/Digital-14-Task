import 'package:digital_14_task/core/helpers/app_colors.dart';
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
  bool _displayLoadingIndicator = false;
  TextEditingController? _searchTextEditingController;
  Eventsbloc? eventsbloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: AppColors.primaryColor,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.white.withOpacity(0.1)),
                        child: ListTile(
                          leading: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 28,
                          ),
                          title: TextField(
                            controller: _searchTextEditingController,
                            onChanged: (value) {
                              eventsbloc = BlocProvider.of<Eventsbloc>(context);
                              eventsbloc!.add(GetEventsByQuery(value));
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search Events...',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: MaterialButton(
                      onPressed: () {
                        _searchTextEditingController?.clear();
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<Eventsbloc, EventsState>(
                builder: (context, state) {
                  if (state is EventsLoadedSuccessfully) {
                    return state.events.isEmpty
                        ? const Center(child: Text('No Result Found'))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.events.length,
                            itemBuilder: ((context, index) {
                              return EventWidget(event: state.events[index]);
                            }),
                          );
                  } else if (state is EventsLoadedFailed) {
                    return Center(
                      child: InkWell(
                        onTap: () => eventsbloc!.add(GetEventsByQuery(
                            _searchTextEditingController!.text)),
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
                  } else if (state is EventsIsLoading) {
                    return const Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 80.0),
                            child: const Text(
                              'Seat Geek',
                              style: TextStyle(
                                  fontSize: 26.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15.0),
                            child: const Text(
                              'Find and Discover events',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

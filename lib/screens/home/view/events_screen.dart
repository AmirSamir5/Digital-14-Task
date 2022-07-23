import 'package:digital_14_task/core/helpers/app_colors.dart';
import 'package:digital_14_task/screens/home/bloc/events_bloc.dart';
import 'package:digital_14_task/screens/home/bloc/events_event.dart';
import 'package:digital_14_task/screens/home/bloc/events_state.dart';
import 'package:digital_14_task/screens/home/view/event_details_screen.dart';
import 'package:digital_14_task/screens/home/view/widgets/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final TextEditingController _searchTextEditingController =
      TextEditingController();
  Eventsbloc? eventsbloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Top Events'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _searchTextEditingController.clear();
                    },
                  ),
                  title: TextField(
                    controller: _searchTextEditingController,
                    onChanged: (value) {
                      eventsbloc = BlocProvider.of<Eventsbloc>(context);
                      eventsbloc!.add(GetEventsByQuery(value));
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Events...',
                      hintStyle: Theme.of(context).textTheme.bodyText1!,
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
          Expanded(
            child: BlocBuilder<Eventsbloc, EventsState>(
              builder: (context, state) {
                if (state is EventsLoadedSuccessfully) {
                  return state.events.isEmpty
                      ? const Center(child: Text('No Result Found'))
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.events.length,
                          itemBuilder: ((context, index) {
                            return EventWidget(event: state.events[index]);
                          }),
                        );
                } else if (state is EventsLoadedFailed) {
                  return Center(
                    child: GestureDetector(
                      onTap: () => eventsbloc!.add(
                          GetEventsByQuery(_searchTextEditingController.text)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state.errorMessage,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Retry',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
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
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'Search now for your favorite events',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

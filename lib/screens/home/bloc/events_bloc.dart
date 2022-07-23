import 'package:bloc/bloc.dart';
import 'package:digital_14_task/screens/home/bloc/events_event.dart';
import 'package:digital_14_task/screens/home/bloc/events_state.dart';
import 'package:digital_14_task/screens/home/model/event_repo.dart';
import 'package:flutter/services.dart';

import '../model/event_model.dart';

class Eventsbloc extends Bloc<EventsEvent, EventsState> {
  EventRepository eventRepository = EventRepository();

  Eventsbloc(this.eventRepository) : super(EventsIsNotLoaded()) {
    on<GetEventsEvent>(_getEvents);
  }

  void _getEvents(EventsEvent event, Emitter<EventsState> emit) async {
    emit(EventsIsLoading());

    try {
      List<Event> _events = await (eventRepository.getEvents());
      emit(EventsLoadedSuccessfully(_events));
    } catch (e) {
      if (e is PlatformException) {
        if (e.message != null) {
          emit(EventsLoadedFailed(errorCode: e.code, errorMessage: e.message!));
        }
      }
    }
  }
}

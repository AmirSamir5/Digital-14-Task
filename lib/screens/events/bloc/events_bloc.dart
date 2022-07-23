import 'package:bloc/bloc.dart';
import 'package:digital_14_task/screens/events/bloc/events_event.dart';
import 'package:digital_14_task/screens/events/bloc/events_state.dart';
import 'package:digital_14_task/screens/events/model/event_repo.dart';
import 'package:flutter/services.dart';

import '../model/event_model.dart';

class Eventsbloc extends Bloc<EventsEvent, EventsState> {
  EventRepository eventRepository = EventRepository();

  Eventsbloc(this.eventRepository) : super(EventsIsNotLoaded()) {
    on<GetEventsByQuery>(_getEvents);
  }

  void _getEvents(GetEventsByQuery event, Emitter<EventsState> emit) async {
    emit(EventsIsLoading());

    try {
      List<Event> _events = await (eventRepository.getEvents(event.query));
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

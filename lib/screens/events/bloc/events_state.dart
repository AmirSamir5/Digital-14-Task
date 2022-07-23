import 'package:digital_14_task/screens/events/model/event_model.dart';
import 'package:equatable/equatable.dart';

class EventsState extends Equatable {
  @override
  List<Object> get props => [];
}

class EventsIsNotLoaded extends EventsState {}

class EventsIsLoading extends EventsState {}

class EventsLoadedSuccessfully extends EventsState {
  final List<Event> _events;

  List<Event> get events => _events;

  EventsLoadedSuccessfully(this._events);
  @override
  List<Object> get props => [_events];
}

class EventsLoadedFailed extends EventsState {
  final String errorCode;
  final String errorMessage;

  EventsLoadedFailed({
    required this.errorCode,
    required this.errorMessage,
  });
  @override
  List<Object> get props => [];
}

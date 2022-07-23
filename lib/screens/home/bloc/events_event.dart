import 'package:digital_14_task/screens/home/model/event_model.dart';
import 'package:equatable/equatable.dart';

class EventsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetEventsByQuery extends EventsEvent {
  final String query;

  GetEventsByQuery(this.query);

  @override
  List<Object?> get props => [query];
}

class GetEventsByIdEvent extends EventsEvent {
  final String eventId;

  GetEventsByIdEvent({required this.eventId});
  @override
  List<Object> get props => [Event];
}

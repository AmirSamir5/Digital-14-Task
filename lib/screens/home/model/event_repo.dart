import 'package:digital_14_task/core/helpers/constants.dart';
import 'package:digital_14_task/core/network/base_request.dart';
import 'package:digital_14_task/screens/home/model/event_model.dart';

class EventRepository {
  Event? event;

  Future<dynamic> getEvents(String query) async {
    try {
      BaseRequest baseRequest = BaseRequest(
        url: EndPointsURLs.getEventsByQuery(query),
        requestType: NETWORK_REQUEST_TYPE.GET,
      );

      var response = await baseRequest.sendRequest({});
      final events = response['events'] as List;

      return events.map((event) => Event.fromJson(event)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

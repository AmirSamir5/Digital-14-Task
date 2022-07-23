abstract class ApiBaseUrl {
  static const String BASE_URL = 'https://api.seatgeek.com/2/';
  static const String CLIENT_ID = 'Mjc5ODY4NTN8MTY1ODQ5MDI4MS44MzMxNTky';
  static const String CLIENT_SECRET =
      '6a60c7258fe2657a33e2402eb08f422c533e328014fbfb59c93cea776a43d82d';
  static const String CLIENT_HASH =
      '?client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET';
  static const int appTimeOut = 60;
}

abstract class EndPointsURLs {
  static const GET_EVENTS =
      ApiBaseUrl.BASE_URL + "events" + ApiBaseUrl.CLIENT_HASH;

  static String getEventById(String eventId) {
    return ApiBaseUrl.BASE_URL + "events/$eventId" + ApiBaseUrl.CLIENT_HASH;
  }

  static String getEventsByQuery(String query) {
    return ApiBaseUrl.BASE_URL +
        "events/" +
        ApiBaseUrl.CLIENT_HASH +
        "&q=$query";
  }
}

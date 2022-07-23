import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final int id;
  final String type;
  final String datetimeLocal;
  final String shortTitle;
  final String url;
  final String title;
  final String announceDate;
  final String description;
  final List<Performer> performers;
  final Venue venue;

  Event({
    required this.id,
    required this.type,
    required this.datetimeLocal,
    required this.shortTitle,
    required this.url,
    required this.title,
    required this.announceDate,
    required this.description,
    required this.performers,
    required this.venue,
  });

  @override
  List<Object?> get props => [
        id,
        shortTitle,
        url,
        title,
      ];

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        type: json["type"],
        announceDate: json["announce_date"],
        datetimeLocal: json["datetime_local"],
        shortTitle: json["short_title"],
        url: json["url"],
        title: json["title"],
        description: json["description"],
        performers: List<Performer>.from(
            json["performers"].map((x) => Performer.fromJson(x))),
        venue: Venue.fromJson(json["venue"]),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['datetime_utc'] = datetimeLocal;
    data['short_title'] = shortTitle;
    data['url'] = url;
    data['title'] = title;
    data['announce_date'] = announceDate;
    return data;
  }
}

class Performer {
  Performer({
    required this.image,
  });
  String? image;

  factory Performer.fromJson(Map<String, dynamic> json) => Performer(
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
      };
}

class Venue {
  Venue({
    required this.address,
  });
  String address;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
      };
}

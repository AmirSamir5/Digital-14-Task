import 'package:equatable/equatable.dart';

class Event extends Equatable {
  int? id;
  String? type;
  String? datetimeUtc;
  String? shortTitle;
  String? url;
  String? title;
  String? announceDate;
  String? createdAt;

  Event(
      {this.type,
      this.id,
      this.datetimeUtc,
      this.shortTitle,
      this.url,
      this.title,
      this.announceDate,
      this.createdAt});

  @override
  List<Object?> get props => [
        id,
        shortTitle,
        url,
        title,
      ];

  Event.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    datetimeUtc = json['datetime_utc'];
    shortTitle = json['short_title'];
    url = json['url'];
    title = json['title'];
    announceDate = json['announce_date'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['datetime_utc'] = datetimeUtc;
    data['short_title'] = shortTitle;
    data['url'] = url;
    data['title'] = title;
    data['announce_date'] = announceDate;
    data['created_at'] = createdAt;
    return data;
  }
}

import 'dart:convert';
import 'package:digital_14_task/core/helpers/date_parser.dart';
import 'package:digital_14_task/core/ui/custom_image.dart';
import 'package:digital_14_task/screens/home/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digital_14_task/core/helpers/constants.dart';

import '../event_details_screen.dart';

class EventWidget extends StatefulWidget {
  final Event event;
  EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  List<int>? favoritesList;

  @override
  void didChangeDependencies() {
    getFavoriteItems();
    super.didChangeDependencies();
  }

  getFavoriteItems() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(SharedPreferencesKeys.FAVORITES_LIST_KEY)) {
      String? favoritesResult =
          prefs.getString(SharedPreferencesKeys.FAVORITES_LIST_KEY);
      if (favoritesResult != null) {
        favoritesList = List<int>.from(json.decode(favoritesResult));
      }
    }
  }

  bool itemIsFavorite() {
    var indexExists = favoritesList!.contains(widget.event.id);
    if (indexExists) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = (MediaQuery.of(context).size.width);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(
              event: widget.event,
              favoriteChanged: () {
                setState(() {
                  getFavoriteItems();
                });
              },
            ),
          ),
        );
      },
      child: Center(
        child: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: SizedBox(
            height: 180,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 2 * (MediaQuery.of(context).size.width) / 3 + 30,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.only(top: 16, right: 16),
                            child: Text(
                              CustomDateParser.convertDateFormat(
                                  widget.event.datetimeLocal),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 12),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: (2 * totalWidth) / 7,
                              right: 8,
                            ),
                            child: Text(
                              widget.event.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'HelveticaNeue',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: (MediaQuery.of(context).size.width) / 3,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: SizedBox(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CustomImageNetwork(
                              imageURL: widget.event.performers[0].image,
                            ),
                            favoritesList != null
                                ? Positioned(
                                    top: 8,
                                    left: 8,
                                    child: Icon(
                                      itemIsFavorite() ? Icons.favorite : null,
                                      color: Colors.red,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Text(
                    widget.event.venue.address,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'HelveticaNeue',
                      color: Colors.blueGrey,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

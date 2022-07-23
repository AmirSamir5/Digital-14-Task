import 'dart:ffi';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:digital_14_task/core/helpers/app_colors.dart';
import 'package:digital_14_task/core/ui/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:digital_14_task/core/helpers/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/helpers/date_parser.dart';
import '../model/event_model.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;
  final VoidCallback favoriteChanged;
  const EventDetailsScreen(
      {Key? key, required this.event, required this.favoriteChanged})
      : super(key: key);

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool isFavorite = false;
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
        itemIsFavorite();
      }
    }
  }

  itemIsFavorite() {
    var indexExists = favoritesList!.contains(widget.event.id);
    if (indexExists) {
      setState(() {
        isFavorite = true;
      });
      return;
    }
    setState(() {
      isFavorite = false;
    });
  }

  setOrRemoveFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    if (!isFavorite) {
      if (favoritesList != null) {
        favoritesList!.add(widget.event.id);
        String encodedFavorites = json.encode(favoritesList);
        prefs.setString(
            SharedPreferencesKeys.FAVORITES_LIST_KEY, encodedFavorites);
      } else {
        favoritesList = [];
        favoritesList!.add(widget.event.id);
        String encodedFavorites = json.encode(favoritesList);
        prefs.setString(
            SharedPreferencesKeys.FAVORITES_LIST_KEY, encodedFavorites);
      }
    } else {
      favoritesList!.removeWhere((element) => element == widget.event.id);
      String encodedFavorites = json.encode(favoritesList);
      prefs.setString(
          SharedPreferencesKeys.FAVORITES_LIST_KEY, encodedFavorites);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Event Details'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        height: 360,
        margin: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: ClipRRect(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: 0.0,
                right: 0.0,
                left: 0.0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  child: SizedBox(
                    height: 300,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomImageNetwork(
                          imageURL: widget.event.performers[0].image,
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: GestureDetector(
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: Colors.red,
                            ),
                            onTap: () async {
                              await setOrRemoveFavorite();
                              widget.favoriteChanged();
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16.0,
                left: 0.0,
                right: 0.0,
                child: SizedBox(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                      child: Container(
                        color: Colors.black54,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.event.title,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'HelveticaNeue',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            CustomDateParser.convertDateFormat(
                                                widget.event.datetimeLocal),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Address : ' + widget.event.venue.address,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

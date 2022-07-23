import 'package:digital_14_task/screens/home/model/event_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatefulWidget {
  Event event;
  EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    double totalWidth = (MediaQuery.of(context).size.width);
    double height = 180;
    return Center(
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Container(
          height: height,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 2 * (MediaQuery.of(context).size.width) / 3 + 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: Colors.white,
                  ),
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: EdgeInsets.only(top: 16, right: 16),
                            child: (widget.event.datetimeUtc != null)
                                ? Text(
                                    widget.event.datetimeUtc ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  )
                                : SizedBox.shrink(),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                              left: (2 * totalWidth) / 7,
                              right: 8,
                            ),
                            child: widget.event.title != null
                                ? Text(
                                    widget.event.title ?? "",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'HelveticaNeue',
                                      color: Color(0xff78849E),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: (MediaQuery.of(context).size.width) / 3,
                  height: (2 * height) / 3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    child: SizedBox(
                      height: (2 * height) / 3,
                      child: (widget.event.url == null)
                          ? Container(
                              color: Colors.black,
                              padding: const EdgeInsets.all(32),
                              child: Image.asset(
                                'assets/images/seat-geek.png',
                                fit: BoxFit.contain,
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.event.url!,
                              placeholder: (context, url) => const Center(
                                child: SizedBox(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/seat-geek.png',
                                fit: BoxFit.fill,
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

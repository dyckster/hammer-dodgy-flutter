import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hammer_dodgy/models/ui/restricted_content_ui_model.dart';

class RestrictedContentWidget extends StatelessWidget {
  const RestrictedContentWidget({Key? key, required this.restrictedContent})
      : super(key: key);

  final RestrictedContentUiModel restrictedContent;

  @override
  Widget build(BuildContext context) {
    Widget content = getRectContainer(
        restrictedContent.isBlurred,
        Container(
          height: 124,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white24, width: 4),
                borderRadius: const BorderRadius.all(Radius.circular(16))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16),
                  child: Image.asset(restrictedContent.icon,
                      height: 32, width: 32),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 20, left: 16, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(restrictedContent.title,
                                style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 18))),
                          ]),
                      Container(height: 4),
                      Text(restrictedContent.description,
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  color: Color(0xD9FFFFFF), fontSize: 14))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));

    return Stack(
      children: [content],
    );
  }

  Widget getRectContainer(bool isBlurred, Widget child) {
    if (isBlurred) {
      return ClipRRect(
          child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: child,
      ));
    } else {
      return ClipRRect(
        child: child,
      );
    }
  }
}

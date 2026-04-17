import 'package:flutter/material.dart';

Widget buildCorner({required bool top, required bool left}) {
  return Positioned(
    top: top ? 0 : null,
    bottom: top ? null : 0,
    left: left ? 0 : null,
    right: left ? null : 0,
    child: Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.tealAccent, width: 3),
          left: BorderSide(color: Colors.tealAccent, width: 3),
        ),
      ),
    ),
  );
}
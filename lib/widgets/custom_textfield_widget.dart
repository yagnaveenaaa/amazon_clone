import 'dart:ui';

import 'package:amazon_clone/utils/color_themes.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidet extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool obsecure;
  TextInputType type;
  final String hintText;

  CustomTextFieldWidet(
      {Key? key,
      required this.title,
      required this.controller,
      required this.obsecure,
      required this.type,
      required this.hintText})
      : super(key: key);

  @override
  State<CustomTextFieldWidet> createState() => _CustomTextFieldWidetState();
}

class _CustomTextFieldWidetState extends State<CustomTextFieldWidet> {
  late FocusNode focusNode;
  bool isInFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isInFocus = true;
        });
      } else {
        setState(() {
          isInFocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            isInFocus
                ? BoxShadow(
                    //offset: Offset(dx, dy),
                    color: orangeColor.withOpacity(0.4),
                    blurRadius: 8,
                    spreadRadius: 2)
                : BoxShadow(
                    //offset: Offset(dx, dy),
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2),
          ]),
          child: TextField(
            focusNode: focusNode,
            controller: widget.controller,
            obscureText: widget.obsecure,
            keyboardType: widget.type,
            maxLines: 1,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
                borderSide:
                    BorderSide(color: orangeColor.withOpacity(.1), width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

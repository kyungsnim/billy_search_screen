import 'package:flutter/material.dart';
import 'utils.dart';

searchBar(FocusNode focusNode, TextEditingController searchTextController) {
  return Row(
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      Expanded(
          child: TextField(
        focusNode: focusNode,
        style: TextStyle(
          fontSize: mediumFontSize,
        ),
        autofocus: true,
        cursorHeight: largeFontSize,
        controller: searchTextController,
        cursorColor: baseColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          fillColor: Colors.transparent,
          filled: true,
          hintText: '궁금한 증상이나 주제를 입력하세요',
          hintStyle: hintTextStyle,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: baseColor, width: 1.5)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: baseColor, width: 1.5)),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: baseColor, width: 1.5),
          ),
        ),
      ))
    ],
  );
}

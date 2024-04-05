import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  AppTextStyle._();
// drawer
  static TextStyle draweTitle = GoogleFonts.vazirmatn(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);
  //
  static TextStyle singlePodcastLable = GoogleFonts.vazirmatn(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
  //
  static TextStyle singlePodcastUserName = GoogleFonts.vazirmatn(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
  //
  //
  static TextStyle singlePodcastTitle = GoogleFonts.vazirmatn(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);
  //
  static TextStyle singlePodcastTime = GoogleFonts.vazirmatn(
      color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold);

  //user screen
  static TextStyle userScreenLabaleText = GoogleFonts.vazirmatn(
    color: Colors.black,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  );
}

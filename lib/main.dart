import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tecblog/bloc/articleInfo/article_info_bloc.dart';
import 'package:tecblog/bloc/athentication/ath_email_bloc.dart';
import 'package:tecblog/bloc/home/home_bloc.dart';
import 'package:tecblog/data/datasource/register/athenticatio_datasource.dart';
import 'package:tecblog/data/repository/article_info_repository.dart';
import 'package:tecblog/data/repository/new_article_repository.dart';
import 'package:tecblog/data/repository/podcast/new_podcast_repository.dart';
import 'package:tecblog/data/repository/podcast/single_podcast_file_repository.dart';
import 'package:tecblog/data/repository/poster_repository.dart';
import 'package:tecblog/data/repository/register/auth_repository.dart';
import 'package:tecblog/data/repository/tags_repository.dart';
import 'package:tecblog/data/repository/user/user_repository.dart';
import 'package:tecblog/di/di.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/screen/main_screen/main_screen.dart';
import 'package:tecblog/screen/article/single_article_screen.dart';
import 'package:tecblog/screen/podcast/single_podcast_screen.dart';
import 'package:tecblog/test.dart';
import 'package:tecblog/utils/auth_manager.dart';
import 'package:tecblog/utils/file_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            textStyle: GoogleFonts.vazirmatn(color: Colors.white, fontSize: 16),
            backgroundColor: const Color(0xff420457),
            minimumSize: const Size(250.0, 50.0),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen()
      // home: const A(),
    );
  }
}

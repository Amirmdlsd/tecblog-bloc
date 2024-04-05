import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/bloc/newArticle/new_article_bloc.dart';
import 'package:tecblog/bloc/newArticle/new_article_event.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/screen/article/article_list_screen.dart';

class HomeCategoryItem extends StatelessWidget {
  HomeCategoryItem({super.key, required this.tags});
  TagsModel tags;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) {
                debugPrint(tags.id.toString());
                var bloc = NeweArticleBloc();
                bloc.add(
                    NewArticleSendRequestForCatIdEvent(tags.id.toString()));
                return bloc;
              },
              child: ArticleListScreen(),
            );
          },
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 40,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff3F3F3F),
              Color(0xff060606),
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Center(
          child: Text(
            tags.title!,
            style: GoogleFonts.vazirmatn(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

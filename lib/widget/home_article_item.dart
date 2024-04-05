import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/widget/cached_image.dart';

class ArticleItemList extends StatelessWidget {
  ArticleItemList({super.key, required this.article});
  ArticleModel article;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedImage(imageUrl: article.image ?? ""),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            article.title ?? "خطا",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.vazirmatn(
                fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }
}

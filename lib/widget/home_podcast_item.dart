import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/screen/podcast/single_podcast_screen.dart';
import 'package:tecblog/widget/cached_image.dart';

class HomeTopPodcastItem extends StatelessWidget {
  HomeTopPodcastItem({
    super.key,
    required this.topPodcastList,
  });

  TopPodcastModel topPodcastList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          settings: RouteSettings(arguments: topPodcastList.id),
          builder: (context) =>  SinglePodcstScreen(
            podcast: topPodcastList,
          ),
        ));
      },
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 130,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedImage(imageUrl: topPodcastList.poster!),
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              topPodcastList.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.vazirmatn(
                  fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

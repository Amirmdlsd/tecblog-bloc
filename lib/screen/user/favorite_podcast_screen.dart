import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/gen/assets.gen.dart';

class FavoritePodcastScreen extends StatelessWidget {
  const FavoritePodcastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              shadowColor: Colors.black,
              floating: true,
              pinned: true,
              title: Text(
                "پادکست های مورد علاقه",
                style: GoogleFonts.vazirmatn(fontSize: 17),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back,
                      size: 32, color: Colors.black)),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 200),
              sliver: SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.images.emptyState.path,
                        width: 150,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "هنوز پادکست مورد علاقه ای نداری",
                        style: GoogleFonts.vazirmatn(
                            color: Colors.black, fontSize: 17),
                      )
                    ],
                  )),
            )
          ],
        )),
      ),
    );
  }
}

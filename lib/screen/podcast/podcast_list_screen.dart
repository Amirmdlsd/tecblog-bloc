import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/bloc/home/home_state.dart';
import 'package:tecblog/bloc/podcast/new_podcast_bloc.dart';
import 'package:tecblog/bloc/podcast/new_podcast_event.dart';
import 'package:tecblog/bloc/podcast/new_podcast_state.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/screen/podcast/single_podcast_screen.dart';
import 'package:tecblog/widget/cached_image.dart';

class NewPodcastListScreen extends StatefulWidget {
  const NewPodcastListScreen({super.key});

  @override
  State<NewPodcastListScreen> createState() => _NewPodcastListScreenState();
}

class _NewPodcastListScreenState extends State<NewPodcastListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewPodcastBloc>().add(NewPodcastSendRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(child: BlocBuilder<NewPodcastBloc, NewPodcastState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state is NewPodcastLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: SpinKitWave(
                      color: Colors.purple,
                      size: 32,
                    ),
                  )
                } else ...{
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverAppBar(
                      elevation: 0,
                      floating: true,
                      pinned: true,
                      backgroundColor: Colors.white,
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Colors.purple.shade700.withAlpha(100),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 32,
                              color: Colors.white,
                            )),
                      ),
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "لیست مقالات",
                          style: GoogleFonts.vazirmatn(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  if (state is NewPodcastRequestSuccessState) ...{
                    state.newPodcastList.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (newPodcastList) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return NewPodcastItem(
                            podcast: newPodcastList[index],
                          );
                        }, childCount: newPodcastList.length),
                      );
                    })
                  }
                }
              ],
            );
          },
        )),
      ),
    );
  }
}

class NewPodcastItem extends StatelessWidget {
  NewPodcastItem({super.key, required this.podcast});
  TopPodcastModel podcast;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SinglePodcstScreen(
              podcast: podcast,
            )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .35,
                height: MediaQuery.of(context).size.height,
                child: CachedImage(imageUrl: podcast.poster!),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Text(
                      podcast.title!,
                      style: GoogleFonts.vazirmatn(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        podcast.author ?? "",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "${podcast.view} بازدید",
                        style: GoogleFonts.vazirmatn(
                            fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

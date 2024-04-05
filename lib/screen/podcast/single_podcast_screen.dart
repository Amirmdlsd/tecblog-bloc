import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tecblog/bloc/podcast%20file/podast_file_bloc.dart';
import 'package:tecblog/bloc/podcast%20file/podcast_file_event.dart';
import 'package:tecblog/bloc/podcast%20file/podcast_file_state.dart';
import 'package:tecblog/data/model/podcast_file.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/resource/app_text_style.dart';
import 'package:tecblog/screen/article/manage_article_screen.dart';
import 'package:tecblog/widget/cached_image.dart';
import 'package:tecblog/widget/podcast_file_item.dart';

class SinglePodcstScreen extends StatefulWidget {
  late TopPodcastModel topPodcastModel;
  SinglePodcstScreen({super.key, this.podcast}) {
    topPodcastModel = podcast!;
  }
  final TopPodcastModel? podcast;

  @override
  State<SinglePodcstScreen> createState() => _SinglePodcstScreenState();
}

class _SinglePodcstScreenState extends State<SinglePodcstScreen> {
  late ConcatenatingAudioSource playList;
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  int currentIndex = 0;
  @override
  void initState() {
    playList = ConcatenatingAudioSource(children: [], useLazyPreparation: true);
    // TODO: implement initState
    super.initState();
    player.setAudioSource(playList,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.topPodcastModel.title);
    return BlocProvider(
      create: (context) {
        var bloc = PodcastFileBloc();
        bloc.add(
            PodcastFileFetchDataEvent(widget.topPodcastModel.id!, playList));
        return bloc;
      },
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: SafeArea(
                child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: CachedImage(
                              imageUrl: widget.topPodcastModel.poster!,
                              errorWidget: Image.asset(
                                Assets.images.singlePlaceHolder.path,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 60,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        end: Alignment.bottomCenter,
                                        begin: Alignment.topCenter,
                                        colors: [
                                      Color.fromARGB(255, 46, 3, 71),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ])),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: (() => Navigator.pop(context)),
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Icon(
                                      Icons.bookmark_outline,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        widget.topPodcastModel.title!,
                        style: AppTextStyle.singlePodcastLable,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.images.profileAvatar.path,
                            height: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            widget.topPodcastModel.author ?? "",
                            style: AppTextStyle.singlePodcastUserName,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<PodcastFileBloc, PodcastFileState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is PodcastFileLoadingState) {
                          return const Center(
                            child: Loading(),
                          );
                        }
                        if (state is PodcastFileResponseState) {
                          return state.podcastFile.fold(
                              (l) => TryAgainButtonWidget(
                                    onTap: () {},
                                  ), (r) {
                            if (r.isNotEmpty) {
                              return SizedBox(
                                height: 300,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ListView.builder(
                                    itemCount: r.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          player.seek(Duration.zero,
                                              index: index);
                                          player.play();

                                          setState(() {
                                            isPlaying = player.playing;
                                          });
                                          startProgress();
                                        },
                                        child: PodcastFIleItems(
                                          color: player.currentIndex == index
                                              ? AppTextStyle.singlePodcastTime
                                                  .copyWith(
                                                      color: Colors
                                                          .lightBlueAccent)
                                              : AppTextStyle.singlePodcastTime,
                                          file: r[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text(
                                "هیچ پادکستی وجود ندارد",
                                style: AppTextStyle.singlePodcastLable,
                              ));
                            }
                          });
                        }
                        return TryAgainButtonWidget(
                          onTap: () {},
                        );
                      },
                    )
                  ],
                ),

                ///-----------------------------
                ///audio player
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff19005E),
                          Color(0xff440457),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10, bottom: 15),
                          child: SizedBox(
                            height: 20,
                            width: double.infinity,
                            child: ProgressBar(
                              progress: progressValue,
                              total:
                                  player.duration ?? const Duration(seconds: 0),
                              baseBarColor: Colors.white,
                              progressBarColor: Colors.orange,
                              thumbColor: Colors.yellow,
                              bufferedBarColor: Colors.grey,
                              buffered: bufredValue,
                              timeLabelTextStyle: GoogleFonts.vazirmatn(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              onSeek: (value) {
                                setState(() {
                                  player.seek(value);
                                });
                              },
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                player.seekToNext();
                                setState(() {
                                  currentIndex = player.currentIndex!;
                                });

                                startProgress();
                              },
                              icon: const Icon(
                                Icons.skip_next_sharp,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                player.playing ? player.pause() : player.play();
                                setState(() {
                                  isPlaying = player.playing;
                                  currentIndex = player.currentIndex!;
                                });
                                startProgress();
                              },
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                player.seekToPrevious();
                                setState(() {
                                  currentIndex = player.currentIndex!;
                                });

                                startProgress();
                              },
                              icon: const Icon(
                                Icons.skip_previous,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.loop,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
    timer?.cancel();
  }

  Duration progressValue = const Duration(seconds: 0);
  Duration bufredValue = const Duration(seconds: 0);
  Timer? timer;

  void startProgress() {
    int duration = player.position.inSeconds;

    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
      }
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        duration--;
        progressValue = player.position;
        bufredValue = player.bufferedPosition;
      });

      if (duration == 0) {
        setState(() {
          timer.cancel();
          progressValue = Duration.zero;
          bufredValue = Duration.zero;
        });
      }
    });
  }
}

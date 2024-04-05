import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/bloc/articleInfo/article_info_bloc.dart';
import 'package:tecblog/bloc/home/home_bloc.dart';
import 'package:tecblog/bloc/home/home_event.dart';
import 'package:tecblog/bloc/home/home_state.dart';
import 'package:tecblog/bloc/newArticle/new_article_bloc.dart';
import 'package:tecblog/bloc/newArticle/new_article_event.dart';
import 'package:tecblog/bloc/podcast/new_podcast_bloc.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/screen/article/article_list_screen.dart';
import 'package:tecblog/screen/podcast/podcast_list_screen.dart';
import 'package:tecblog/screen/article/single_article_screen.dart';
import 'package:tecblog/widget/cached_image.dart';
import 'package:tecblog/widget/home_article_item.dart';
import 'package:tecblog/widget/home_podcast_item.dart';

import '../../widget/home_categroy_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeBloc>().add(HomeSendRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomScrollView(
              slivers: [
                if (state is HomeLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      child: SpinKitWave(
                        size: 40,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                } else ...{
                  // SliverPadding(
                  //   padding: const EdgeInsets.only(
                  //     left: 20,
                  //   ),
                  //   sliver: SliverAppBar(
                  //     pinned: true,
                  //     elevation: 0,
                  //     floating: true,
                  //     actions: [
                  //       IconButton(
                  //           onPressed: () {},
                  //           icon: const Icon(
                  //             Icons.menu,
                  //             size: 32,
                  //             color: Colors.black,
                  //           )),
                  //       const Spacer(),
                  //       Image.asset(Assets.images.logo.path),
                  //       const Spacer(),
                  //       IconButton(
                  //           onPressed: () {},
                  //           icon: const Icon(
                  //             Icons.search,
                  //             size: 32,
                  //             color: Colors.black,
                  //           )),
                  //     ],
                  //     backgroundColor: Colors.white,
                  //   ),
                  // ),

                  if (state is HomeRequestSuccessState) ...{
                    state.poster.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (poster) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 20, top: 5),
                          child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child:
                                      CachedImage(imageUrl: poster.image ?? ""),
                                ),
                                Text(
                                  poster.title ?? "",
                                  style: GoogleFonts.vazirmatn(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                  },

                  if (state is HomeRequestSuccessState) ...{
                    state.tagsList.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (tagsList) {
                      return SliverToBoxAdapter(
                          child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: HomeTagsListView(
                          tagsList: tagsList,
                        ),
                      ));
                    })
                  },
                  //article list
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return BlocProvider(
                              create: (context) => NeweArticleBloc(),
                              child: ArticleListScreen(),
                            );
                          },
                        ));
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return BlocProvider(
                                create: (context) {
                                  var bloc = NeweArticleBloc();
                                  bloc.add(NewArticleSendRequestEvent());
                                  return bloc;
                                },
                                child: ArticleListScreen(),
                              );
                            },
                          ));
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.icons.bluePen.path,
                              scale: 8,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "مشاهده داغ ترین مقاله ها",
                              style: GoogleFonts.vazirmatn(
                                  color: Colors.lightBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                  if (state is HomeRequestSuccessState) ...{
                    state.articleList.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (topVisitedList) {
                      return SliverToBoxAdapter(
                        child: HomeArticleList(
                          articleList: topVisitedList,
                        ),
                      );
                    })
                  },
                  //----------------------
                  //================podcast list
                  SliverToBoxAdapter(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return BlocProvider(
                              create: (context) => NewPodcastBloc(),
                              child: const NewPodcastListScreen(),
                            );
                          },
                        ));
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.icons.bluePen.path,
                            scale: 8,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "مشاهده تمام پادکست ها ها",
                            style: GoogleFonts.vazirmatn(
                                color: Colors.lightBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )),

                  if (state is HomeRequestSuccessState) ...{
                    state.podcastList.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (topPodcastList) {
                      return SliverToBoxAdapter(
                          child: HomePodcastList(
                        topPodcastList: topPodcastList,
                      ));
                    })
                  }
                },
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                  ),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}

class HomeTagsListView extends StatelessWidget {
  HomeTagsListView({super.key, required this.tagsList});
  List<TagsModel> tagsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: tagsList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: HomeCategoryItem(
            tags: tagsList[index],
          ),
        );
      },
    );
  }
}

class HomePodcastList extends StatelessWidget {
  HomePodcastList({super.key, required this.topPodcastList});
  List<TopPodcastModel> topPodcastList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ListView.builder(
        itemCount: topPodcastList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.all(10),
              width: 170,
              height: 210,
              child: HomeTopPodcastItem(topPodcastList: topPodcastList[index]));
        },
      ),
    );
  }
}

class HomeArticleList extends StatelessWidget {
  HomeArticleList({super.key, required this.articleList});
  List<ArticleModel> articleList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 210,
      child: ListView.builder(
        itemCount: articleList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => ArticleInfoBloc(),
                  child: SingleArticleScreen(
                    id: articleList[index].id,
                  ),
                ),
              ));
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              width: 170,
              child: ArticleItemList(
                article: articleList[index],
              ),
            ),
          );
        },
      ),
    );
  }
}

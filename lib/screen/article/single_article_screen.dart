import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/bloc/articleInfo/article_info_bloc.dart';
import 'package:tecblog/bloc/articleInfo/article_info_event.dart';
import 'package:tecblog/bloc/articleInfo/article_info_state.dart';
import 'package:tecblog/bloc/newArticle/new_article_bloc.dart';
import 'package:tecblog/bloc/newArticle/new_article_event.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/screen/article/article_list_screen.dart';
import 'package:tecblog/widget/cached_image.dart';
import 'package:tecblog/widget/home_article_item.dart';

class SingleArticleScreen extends StatefulWidget {
  SingleArticleScreen({super.key, this.id});
  String? id;
  @override
  State<SingleArticleScreen> createState() => _SingleArticleScreenState();
}

class _SingleArticleScreenState extends State<SingleArticleScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<ArticleInfoBloc>()
        .add(ArticleInfoSendRequestEvent(widget.id!));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(child: BlocBuilder<ArticleInfoBloc, ArticleINfoState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  if (state is ArticleInfoLoadingState) ...{
                    const Loading()
                  } else ...{
                    if (state is ArticleInfoRequestSuccess) ...{
                      state.articleInfo.fold((l) {
                        return Text(l);
                      }, (r) {
                        return Stack(
                          children: [
                            // ---------------
                            // image
                            SizedBox(
                              width: double.infinity,
                              height: size * .3,
                              child: CachedImage(
                                imageUrl: r.image ?? "",
                                widget: Image.asset(
                                  Assets.images.singlePlaceHolder.path,
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: Image.asset(
                                  Assets.images.singlePlaceHolder.path,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // end of image
                            // ---------------------
                            // ---------------------
                            // app bar
                            Positioned(
                              top: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                height: 70,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        end: Alignment.bottomCenter,
                                        begin: Alignment.topCenter,
                                        colors: [
                                      Color.fromARGB(255, 46, 3, 71),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ])),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 32,
                                        )),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.bookmark_outline,
                                          color: Colors.white,
                                          size: 32,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.share_outlined,
                                          color: Colors.white,
                                          size: 32,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            // end of appbar
                            // ---------------------
                          ],
                        );
                      })
                    },
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is ArticleInfoRequestSuccess) ...{
                      state.articleInfo.fold((l) {
                        return Text(l);
                      }, (r) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                r.title ?? 'خطا',
                                style: GoogleFonts.vazirmatn(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    Assets.images.profileAvatar.path,
                                    scale: 15,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    r.author ?? "خطا",
                                    style: GoogleFonts.vazirmatn(
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    r.createdAt ?? "نامشخص",
                                    style: GoogleFonts.vazirmatn(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                child: Text(
                                  r.content ?? "خطا",
                                  style: GoogleFonts.vazirmatn(
                                      fontSize: 15, color: Colors.black),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                    },
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is ArticleInfoRequestSuccess) ...{
                      state.tags.fold((l) {
                        return Text(l);
                      }, (tagList) {
                        return SizedBox(
                          width: double.infinity,
                          height: size * 0.07,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: tagList.length,
                              itemBuilder: (contex, index) {
                                return sigleArticleTag(tag: tagList[index]);
                              }),
                        );
                      })
                    },
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is ArticleInfoRequestSuccess) ...{
                      state.related.fold((l) {
                        return Text(l);
                      }, (related) {
                        return SizedBox(
                          height: size * .28,
                          child: ListView.builder(
                            itemCount: related.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return BlocProvider(
                                          create: (context) =>
                                              ArticleInfoBloc(),
                                          child: SingleArticleScreen(
                                            id: related[index].id,
                                          ),
                                        );
                                      },
                                    ));
                                  },
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: SizedBox(
                                            height: 130,
                                            width: double.infinity,
                                            child: CachedImage(
                                                imageUrl:
                                                    related[index].image!),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          related[index].title!,
                                          style: GoogleFonts.vazirmatn(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      })
                    }
                  },
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}

class sigleArticleTag extends StatelessWidget {
  sigleArticleTag({super.key, required this.tag});
  TagsModel tag;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              var bloc = NeweArticleBloc();
              bloc.add(NewArticleSendRequestForCatIdEvent(tag.id!));
              return bloc;
            },
            child: ArticleListScreen(),
          ),
        ));
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 40,
        decoration: const BoxDecoration(
            color: Color(0xffF2F2F2),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Center(
          child: Text(
            tag.title ?? "خطا",
            style: GoogleFonts.vazirmatn(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

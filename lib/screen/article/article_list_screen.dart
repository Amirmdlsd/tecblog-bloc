import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/bloc/articleInfo/article_info_bloc.dart';
import 'package:tecblog/bloc/newArticle/new_article_bloc.dart';
import 'package:tecblog/bloc/newArticle/new_article_event.dart';
import 'package:tecblog/bloc/newArticle/new_article_state.dart';
import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/screen/article/single_article_screen.dart';
import 'package:tecblog/widget/cached_image.dart';

class ArticleListScreen extends StatefulWidget {
  ArticleListScreen({
    super.key,this.article
  });
  ArticleModel? article;
  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  @override
  void initState() {
    super.initState();
    //   context
    //       .read<NeweArticleBloc>()
    //       .add(NewArticleSendRequestForCatIdEvent(widget.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(child: BlocBuilder<NeweArticleBloc, NewArticleState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state is NewArticleLoadingState) ...{
                  const SliverToBoxAdapter(
                    child: SpinKitWave(
                      size: 30,
                      color: Colors.purple,
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

                  ///
                  ///-----article list
                  if (state is NewArticleRequestSuccessState) ...{
                    state.newArticle.fold((l) {
                      return SliverToBoxAdapter(
                        child: Text(l),
                      );
                    }, (articleList) {
                      return NewArticleList(
                        articleList: articleList,
                      );
                    })
                  },
                  if (state is NewArticleRequestSuccessForCatidState) ...{
                    state.newArticleWithCatId.fold((l) {
                      return const SliverToBoxAdapter(child: Text('error'));
                    }, (r) {
                      return NewArticleList(articleList: r);
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

class NewArticleList extends StatelessWidget {
  const NewArticleList({super.key, required this.articleList});
  final List<ArticleModel> articleList;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
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
          child: NewArticleItem(articleList: articleList[index]),
        );
      }, childCount: articleList.length),
    );
  }
}

class NewArticleItem extends StatelessWidget {
  const NewArticleItem({
    super.key,
    required this.articleList,
  });

  final ArticleModel articleList;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: CachedImage(imageUrl: articleList.image??""),
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
                    articleList.title!,
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
                      articleList.author??"نویسنده",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 14, color: Colors.grey),
                    ),
                    Text(
                      "${articleList.view} بازدید",
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
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tecblog/bloc/articleInfo/user%20article/article_bloc.dart';
import 'package:tecblog/bloc/articleInfo/user%20article/article_event.dart';
import 'package:tecblog/bloc/articleInfo/user%20article/article_state.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/screen/article/write_article_screen.dart';
import 'package:tecblog/screen/main_screen/home_screen.dart';
import 'package:tecblog/widget/cached_image.dart';
import 'package:tecblog/widget/home_article_item.dart';

class ManageArticleScreen extends StatelessWidget {
  const ManageArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = UserArticleBloc();
        bloc.add(GetMyArticleEvent());
        return bloc;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: const Align(
                alignment: Alignment.bottomLeft,
                child: Text("مدیریت مقاله ها")),
            leading: Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.withAlpha(5000)
              ),
              child: IconButton(
                
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
          body: SafeArea(child: BlocBuilder<UserArticleBloc, UserArticleState>(
            builder: (context, state) {
              if (state is UserArticleLoadingState) {
                return const Center(
                  child: Loading(),
                );
              }
              if (state is GetMyAricleResponseState) {
                return state.getMyArticle.fold(
                  (l) => TryAgainButtonWidget(
                    onTap: () {
                      context.read<UserArticleBloc>().add(GetMyArticleEvent());
                    },
                  ),
                  (r) => ListView.builder(
                    itemCount: r.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedImage(imageUrl: r[index].image!),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r[index].title!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      r[index].createdAt!,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text("بازدید ${r[index].view!}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ],
                            ))
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

              return TryAgainButtonWidget(
                onTap: () {
                  context.read<UserArticleBloc>().add(GetMyArticleEvent());
                },
              );
            },
          )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WriteArticleScreen(),
                      ));
                },
                child: const Text(
                  "بریم برای نوشتن یه مقاله باحال",
                  style: TextStyle(color: Colors.white, fontFamily: 'dana'),
                )),
          ),
        ),
      ),
    );
  }
}

class TryAgainButtonWidget extends StatelessWidget {
  const TryAgainButtonWidget({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'خطایی رخ داده است',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                onTap();
              },
              child: const Text(
                "تلاش مجدد",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}

class EmptyArticle extends StatelessWidget {
  const EmptyArticle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.images.emptyState.path,
          width: 150,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          """
              هنوز هیچ مقاله ای به جامعه گیک های فارسی 
              اضافه نکردی !!!
              """,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'dana', fontSize: 16),
        )
      ],
    );
  }
}

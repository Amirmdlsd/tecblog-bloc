import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/bloc/articleInfo/user%20article/article_bloc.dart';
import 'package:tecblog/bloc/articleInfo/user%20article/article_event.dart';
import 'package:tecblog/bloc/articleInfo/user%20article/article_state.dart';
import 'package:tecblog/bloc/home/home_bloc.dart';
import 'package:tecblog/bloc/home/home_event.dart';
import 'package:tecblog/bloc/home/home_state.dart';
import 'package:tecblog/bloc/tag/tag_state.dart';
import 'package:tecblog/bloc/tag/tags_bloc.dart';
import 'package:tecblog/bloc/tag/tags_event.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/screen/article/article_html_screen.dart';
import 'package:tecblog/screen/article/single_article_screen.dart';
import 'package:tecblog/utils/file_picker.dart';
import 'package:tecblog/widget/cached_image.dart';

class WriteArticleScreen extends StatefulWidget {
  const WriteArticleScreen({super.key});

  @override
  State<WriteArticleScreen> createState() => _WriteArticleScreenState();
}

class _WriteArticleScreenState extends State<WriteArticleScreen> {
  final articleTitleController = TextEditingController(
      text: "اینجا عنوان مقاله قرار میگیره ، یه عنوان جذاب انتخاب کنّ");
  final content = TextEditingController(
      text:
          """من متن و بدنه اصلی مقاله هستم ، اگه میخوای من رو ویرایش کنی و یه مقاله جذاب بنویسی ، نوشته آبی رنگ بالا که نوشته "ویرایش متن اصلی مقاله" رو با انگشتت لمس کن تا وارد ویرایشگر بشی""");

  String imagePath = "";
  String selectedTag = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => UserArticleBloc(),
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  Stack(
                    children: [
                      SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: imagePath.isNotEmpty
                            ? Image.file(
                                File(imagePath),
                                fit: BoxFit.cover,
                              )
                            : CachedImage(
                                imageUrl: "",
                                errorWidget: Image.asset(
                                  Assets.images.singlePlaceHolder.path,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      AddImageButtonWidget(
                        addButton: () async {
                          String image = await pickImage();
                          if (image.isNotEmpty) {
                            setState(() {
                              imagePath = image;
                            });
                          }
                        },
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  end: Alignment.bottomCenter,
                                  begin: Alignment.topCenter,
                                  colors: [
                                Color.fromARGB(255, 46, 3, 71),
                                Color.fromARGB(0, 0, 0, 0)
                              ])),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Row(
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //article title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        BluePenWidget(
                          title: "ویرایش عنوان مقاله",
                          onTap: () {
                            appDialouge(context);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          articleTitleController.text,
                          style: const TextStyle(fontSize: 18),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BluePenWidget(
                          title: "ویرایش متن اصلی مقاله",
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          content.text,
                          style: const TextStyle(fontSize: 18),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BluePenWidget(
                          title: "انتخاب دسته بندی",
                          onTap: () {
                            chooseCategoryModalBottomSheet(context);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(selectedTag.isNotEmpty
                            ? selectedTag
                            : "تگی انتخاب نکردید!")
                      ],
                    ),
                  ),
                  const Spacer(),
                  BlocConsumer<UserArticleBloc, UserArticleState>(
                    builder: (context, state) {
                      if (state is ArticleInitState) {
                        return Center(
                          child: ElevatedButton(
                            onPressed: () {
                              debugPrint(
                                  articleTitleController.text.toString());
                              debugPrint(content.text.toString());
                              debugPrint(imagePath.toString());

                              context.read<UserArticleBloc>().add(
                                    StoreArticleEvent(
                                      articleTitleController.text,
                                      content.text,
                                      "2",
                                      imagePath ??
                                          Assets.images.singlePlaceHolder.path,
                                    ),
                                  );
                            },
                            child: const Text(
                              "تایید",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                      if (state is UserArticleLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is ArticleResponseState) {
                        state.response.fold((l) {
                          return Center(
                            child: ElevatedButton(
                              onPressed: () {
                                debugPrint(
                                    articleTitleController.text.toString());
                                debugPrint(content.text.toString());

                                //
                                context.read<UserArticleBloc>().add(
                                    StoreArticleEvent(
                                        articleTitleController.text,
                                        content.text,
                                        "2",
                                        imagePath));
                              },
                              child: const Text(
                                "تایید",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }, (r) {
                          return Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "تایید",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        });
                      }
                      return Center(
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint(articleTitleController.text.toString());
                            debugPrint(content.text.toString());

                            context.read<UserArticleBloc>().add(
                                StoreArticleEvent(articleTitleController.text,
                                    content.text, "2", imagePath));
                          },
                          child: const Text(
                            "تایید",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                      // return Text("error");
                    },
                    listener: (context, state) {
                      if (state is ArticleResponseState) {
                        state.response.fold((l) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(l)));
                        }, (r) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(r)));
                          Navigator.pop(context);
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )),
    );
  }

  Future<dynamic> chooseCategoryModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (c) {
            var bloc = TagsBloc();
            bloc.add(TagsFetchListEvent());
            return bloc;
          },
          child: BlocBuilder<TagsBloc, TagsState>(
            builder: (context, state) {
              if (state is TagsLoadingState) {
                return const Center(
                  child: Loading(),
                );
              }
              if (state is TagsResponseState) {
                return state.tagsList.fold(
                  (l) {
                    return SizedBox(
                      height: 350,
                      width: double.infinity,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<TagsBloc>().add(TagsFetchListEvent());
                          },
                          child: const Text("خطایی رخ داد است"),
                        ),
                      ),
                    );
                  },
                  (tagList) {
                    return SizedBox(
                        height: 350,
                        child: GridView.builder(
                          itemCount: tagList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 4),
                          itemBuilder: (context, index) => Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop;
                                setState(() {
                                  selectedTag = tagList[index].title!;
                                });
                              },
                              child: Center(
                                  child: Text(
                                tagList[index].title!,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                            ),
                          ),
                        ));
                  },
                );
              }
              return SizedBox(
                height: 350,
                width: double.infinity,
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<TagsBloc>().add(TagsFetchListEvent());
                    },
                    child: const Text("خطایی رخ داد است"),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<dynamic> appDialouge(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            content: SizedBox(
              width: 320,
              height: 150,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Center(
                        child: Text("لطفا یه عنوان پر معنا و کوتاه انتخاب کن"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SvgPicture.asset(
                        Assets.images.tcbot,
                        width: 50,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AppInput(articleTitleController: articleTitleController),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("بعدا")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text("تایید"))
            ],
          ),
        );
      },
    );
  }
}

class AppInput extends StatelessWidget {
  const AppInput({
    super.key,
    required this.articleTitleController,
  });

  final TextEditingController articleTitleController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: articleTitleController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: "******",
            hintStyle: GoogleFonts.vazirmatn(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 1, color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(width: 1, color: Colors.lightBlue))),
      ),
    );
  }
}

class BluePenWidget extends StatelessWidget {
  const BluePenWidget({super.key, required this.title, required this.onTap});
  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            Assets.icons.bluePen.path,
            width: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                color: Color(0xff286BB8),
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class AddImageButtonWidget extends StatelessWidget {
  const AddImageButtonWidget({super.key, required this.addButton});
  final Function() addButton;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 00,
      right: 0,
      left: 0,
      child: Center(
        child: GestureDetector(
          onTap: addButton,
          child: Container(
            width: 120,
            height: 30,
            decoration: const BoxDecoration(
                color: Color(0xff420457),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "انتخاب تصویر",
                  style: TextStyle(color: Colors.white),
                ),
                // SizedBox(width: 10,),
                Icon(
                  Icons.add,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

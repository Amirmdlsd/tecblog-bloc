import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/bloc/articleInfo/user%20article/article_bloc.dart';
import 'package:tecblog/bloc/articleInfo/user%20article/article_event.dart';
import 'package:tecblog/bloc/athentication/ath_email_bloc.dart';
import 'package:tecblog/bloc/home/home_bloc.dart';
import 'package:tecblog/bloc/home/home_event.dart';
import 'package:tecblog/bloc/home/home_state.dart';
import 'package:tecblog/bloc/newArticle/new_article_bloc.dart';
import 'package:tecblog/bloc/newArticle/new_article_event.dart';
import 'package:tecblog/bloc/user%20bloc/user_bloc.dart';
import 'package:tecblog/bloc/user%20bloc/user_event.dart';
import 'package:tecblog/constant.dart';

import 'package:tecblog/data/model/article_model.dart';
import 'package:tecblog/data/model/tags_model.dart';
import 'package:tecblog/data/model/top_podcast_model.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/resource/app_text_style.dart';
import 'package:tecblog/screen/article/manage_article_screen.dart';
import 'package:tecblog/screen/article/article_list_screen.dart';
import 'package:tecblog/screen/main_screen/home_screen.dart';
import 'package:tecblog/screen/register_screen.dart';
import 'package:tecblog/screen/user/user_screen.dart';
import 'package:tecblog/screen/article/write_screen.dart';
import 'package:tecblog/utils/auth_manager.dart';
import 'package:tecblog/widget/cached_image.dart';
import 'package:tecblog/widget/home_article_item.dart';
import 'package:tecblog/widget/home_podcast_item.dart';

import '../../widget/home_categroy_item.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
  int selectedIndex = 0;
}

class _MainScreenState extends State<MainScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    debugPrint(AuthManager.readToken());
    return BlocProvider(
      create: (context) {
        var homeBloc = HomeBloc();
        homeBloc.add(HomeSendRequestEvent());
        return homeBloc;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: _key,
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(Assets.images.logo.path),
                  ),
                ),
                ListTile(
                  onTap: () {
                    _key.currentState!.closeDrawer();
                    setState(() {
                      widget.selectedIndex = 1;
                    });
                  },
                  title: Text(
                    'پروفایل کاربری',
                    style: AppTextStyle.draweTitle,
                  ),
                ),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    'درباره تک‌بلاگ',
                    style: AppTextStyle.draweTitle,
                  ),
                ),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    'اشتراک گذاری تک بلاگ',
                    style: AppTextStyle.draweTitle,
                  ),
                ),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                ),
                ListTile(
                  onTap: () {},
                  title: Text(
                    'تک‌بلاگ در گیت هاب',
                    style: AppTextStyle.draweTitle,
                  ),
                ),
                const Divider(
                  indent: 30,
                  endIndent: 30,
                ),
              ],
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    _key.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 32,
                    color: Colors.black,
                  )),
              const Spacer(),
              Image.asset(Assets.images.logo.path),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 32,
                    color: Colors.black,
                  )),
            ],
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const Loading();
                } else {
                  return Directionality(
                      textDirection: TextDirection.rtl,
                      child: Stack(
                        children: [
                          IndexedStack(
                            index: widget.selectedIndex,
                            children: [
                              BlocProvider(
                                create: (context) => HomeBloc(),
                                child: const HomeScreen(),
                              ),
                              BlocProvider(
                                create: (context) {
                                  var userBloc = UserBloc();

                                  userBloc.add(UserGetInfoEvent());

                                  return userBloc;
                                },
                                child: const UserScreen(),
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: AppBottomNavigationBar(
                              onTap: (value) {
                                setState(() {
                                  widget.selectedIndex = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AppBottomNavigationBar extends StatelessWidget {
  AppBottomNavigationBar({super.key, required this.onTap});
  Function(int) onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [
          Color(0xff19005E),
          Color(0xff440457),
        ], begin: Alignment.centerLeft, end: Alignment.centerRight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => onTap(0),
            child: Image.asset(
              Assets.icons.home.path,
              scale: 5,
            ),
          ),
          GestureDetector(
            onTap: () {
              // onTap(1);
              (AuthManager.readToken()).isNotEmpty
                  ? showManagerBottomSheet(context)
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => AuthenticatioBloc(),
                        child: const RegisterScreen(),
                      ),
                    ));
            },
            child: Image.asset(
              Assets.icons.write.path,
              scale: 5,
            ),
          ),
          GestureDetector(
            onTap: () => onTap(1),
            child: Image.asset(
              Assets.icons.user.path,
              scale: 5,
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showManagerBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "دونسته هات رو با بقیه به اشتراک بذار ...",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
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
                  height: 15,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(AppString.articleTitle,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        const Text("مدیریت پادکست ها"),
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          Assets.icons.writeMicrophone.path,
                          width: 40,
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) {
                              var bloc = UserArticleBloc();
                              bloc.add(GetMyArticleEvent());
                              return bloc;
                            },
                            child: const ManageArticleScreen(),
                          ),
                        ));
                      },
                      child: Row(
                        children: [
                          const Text("مدیریت مقاله ها"),
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            Assets.icons.writeArticle.path,
                            width: 40,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

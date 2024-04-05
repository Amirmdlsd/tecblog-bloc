import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tecblog/bloc/user%20bloc/user_bloc.dart';
import 'package:tecblog/bloc/user%20bloc/user_state.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/resource/app_text_style.dart';
import 'package:tecblog/screen/article/manage_article_screen.dart';
import 'package:tecblog/screen/main_screen/main_screen.dart';
import 'package:tecblog/screen/user/favorite_podcast_screen.dart';
import 'package:tecblog/screen/user/uodate_user_info_screen.dart';
import 'package:tecblog/utils/auth_manager.dart';
import 'package:tecblog/widget/cached_image.dart';
import 'package:tecblog/widget/route_to_login.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: (AuthManager.readToken()).isEmpty
            ? RouteToLoinScreen()
            : BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return const Center(
                      child: Loading(),
                    );
                  }
                  if (state is UserResponseState) {
                    return state.userInfo.fold(
                        (l) => TryAgainButtonWidget(
                              onTap: () {},
                            ),
                        (r) => Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: CircleAvatar(
                                      child: Image.asset(
                                          Assets.images.profileAvatar.path),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.icons.bluePen.path,
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateUserInfoScreen(
                                                    name: r.name,
                                                    email: r.email,
                                                    image: r.image),
                                          ));
                                        },
                                        child: const Text(
                                          "ویرایش عکس پروفایل",
                                          style: TextStyle(
                                              color: Color(
                                                0xff286BB8,
                                              ),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    r.name ?? "نامی وجود ندارد",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(r.email,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const AppDivider(),
                                  UserLableText(
                                    lable: 'مقالات مورد علاقه من',
                                    onTap: () {},
                                  ),
                                  const AppDivider(),
                                  UserLableText(
                                    lable: 'پادکست های مورد علاقه من',
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return FavoritePodcastScreen();
                                        },
                                      ));
                                    },
                                  ),
                                  const AppDivider(),
                                  UserLableText(
                                    lable: 'خروج از حساب کاربری',
                                    onTap: () {
                                      AuthManager.deleteToken();
                                      AuthManager.deleteUserId();
                                      MainScreen();
                                    },
                                  )
                                ],
                              ),
                            ));
                  }
                  return TryAgainButtonWidget(
                    onTap: () {},
                  );
                },
              ),
      ),
    );
  }
}

class UserLableText extends StatelessWidget {
  const UserLableText({required this.lable, super.key, required this.onTap});
  final String lable;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
          height: 50,
          child: Center(
              child: Text(lable, style: AppTextStyle.userScreenLabaleText))),
    );
  }
}

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      indent: 30,
      endIndent: 30,
      color: Color(0xff707070),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/bloc/user%20bloc/user_bloc.dart';
import 'package:tecblog/bloc/user%20bloc/user_event.dart';
import 'package:tecblog/bloc/user%20bloc/user_state.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/screen/article/manage_article_screen.dart';
import 'package:tecblog/utils/file_picker.dart';
import 'package:tecblog/widget/cached_image.dart';

class UpdateUserInfoScreen extends StatefulWidget {
  UpdateUserInfoScreen({
    super.key,
    required this.name,
    required this.email,
    required this.image,
  });
  final String name;
  final String email;
  String image;

  @override
  State<UpdateUserInfoScreen> createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends State<UpdateUserInfoScreen> {
  TextEditingController? nameController;
  TextEditingController? emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = UserBloc();

        return UserBloc();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.image.isNotEmpty
                  ? SizedBox(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadiusDirectional.circular(12),
                        child: Image.file(
                          File(
                            widget.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ))
                  : Image.asset(
                      Assets.images.profileAvatar.path,
                      width: 100,
                      height: 100,
                    ),
              ElevatedButton(
                onPressed: () async {
                  var image = await pickImage();
                  widget.image = image;

                  setState(() {});
                },
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(120, 30)),
                child: Text(
                  'انتخاب عکس',
                  style:
                      GoogleFonts.vazirmatn(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                controller: nameController!,
                lable: "نام کاربری",
              ),
              const SizedBox(
                height: 15,
              ),
              AppTextField(
                controller: emailController!,
                lable: "ایمیل کاربری",
              ),
              const Spacer(),
              BlocConsumer<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserInitState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<UserBloc>().add(UserUpdateInfoEvent(
                              nameController!.text, widget.image));
                        },
                        child: Text(
                          "تایید",
                          style: GoogleFonts.vazirmatn(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    );
                  }

                  if (state is UserLoadingState) {
                    return const Loading();
                  }

                  if (state is UserUpdateState) {
                    return state.updateUser.fold(
                        (l) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<UserBloc>().add(
                                      UserUpdateInfoEvent(nameController!.text,
                                          widget.image ));
                                },
                                child: Text(
                                  "تایید",
                                  style: GoogleFonts.vazirmatn(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                        (r) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "تایید",
                                  style: GoogleFonts.vazirmatn(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(UserUpdateInfoEvent(
                            nameController!.text, widget.image));
                      },
                      child: Text(
                        "تایید",
                        style: GoogleFonts.vazirmatn(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                  );
                },
                listener: (context, state) {
                  if (state is UserUpdateState) {
                    state.updateUser.fold(
                      (l) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(l))),
                      (r) {
                        context.read<UserBloc>().add(UserGetInfoEvent());
                        Navigator.pop(context);

                        debugPrint('result is======' + r.toString());
                        return ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(r)));
                      },
                    );
                  }
                },
              )
            ],
          )),
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  AppTextField({super.key, required this.lable, required this.controller});
  String lable;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: GoogleFonts.vazirmatn(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: controller,
            style: GoogleFonts.vazirmatn(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 2, color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 1, color: Colors.lightBlue),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tecblog/bloc/athentication/ath_email.event.dart';
import 'package:tecblog/bloc/athentication/ath_email_bloc.dart';
import 'package:tecblog/bloc/athentication/ath_email_state.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/screen/main_screen/main_screen.dart';
import 'package:tecblog/widget/cached_image.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController code = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  Assets.images.tcbot,
                  width: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    """
                          به تک‌بلاگ خوش اومدی
                          
                          برای ارسال مطلب و پادکست باید حتما 
                          ثبت نام کنی 
                          """,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.vazirmatn(
                        fontSize: 14, color: const Color(0xff6B6B6B)),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      emailBottomSheet(context);
                    },
                    child: Text(
                      "بزن بریم ",
                      style: GoogleFonts.vazirmatn(
                          fontSize: 18, color: Colors.white),
                    )),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> emailBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      )),
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => AuthenticatioBloc(),
          child: BlocConsumer<AuthenticatioBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthRequestSuccessState) {
                state.emailSuccess.fold((l) {
                  debugPrint(l.toString());

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l),
                      behavior: SnackBarBehavior.floating,
                      // Consider additional customization options:
                    ),
                  );
                }, (r) {
                  debugPrint(r.toString());
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(r),
                      behavior: SnackBarBehavior.floating,
                      // Consider additional customization options:
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );

                  activeCode(context);
                });
              }
            },
            builder: (context, state) {
              if (state is AuthInitState) {
                return BottomSheet(email: email);
              }
              if (state is AuthLoadingState) {
                return const Loading();
              }
              if (state is AuthRequestSuccessState) {
                state.emailSuccess.fold((l) {
                  return BottomSheet(email: email);
                }, (r) {
                  print(r);
                });
              }
              return BottomSheet(email: email);
            },
          ),
        );
      },
    );
  }

  Future<dynamic> activeCode(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      )),
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => AuthenticatioBloc(),
          child: BlocConsumer<AuthenticatioBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthInitState) {
                return ActivationCodeBTS(
                  code: code,
                  email: email,
                  onTap: () {
                    debugPrint(code.text.toString());
                    debugPrint(email.text.toString());
                    context.read<AuthenticatioBloc>().add(
                          AuthVerificationCodeEvent(email.text, code.text),
                        );
                  },
                );
              }
              if (state is AuthLoadingState) {
                return const Loading();
              }
              if (state is AuthVerifyState) {
                state.result.fold(
                  (l) {
                    ActivationCodeBTS(
                      code: code,
                      email: email,
                      onTap: () {
                        debugPrint(code.text.toString());
                        debugPrint(email.text.toString());
                        context.read<AuthenticatioBloc>().add(
                              AuthVerificationCodeEvent(email.text, code.text),
                            );
                      },
                    );
                    debugPrint(l.toString());
                  },
                  (r) => debugPrint(r.toString()),
                );
              }

              return ActivationCodeBTS(
                code: code,
                email: email,
                onTap: () {
                  debugPrint(code.text.toString());
                  debugPrint(email.text.toString());
                  context.read<AuthenticatioBloc>().add(
                        AuthVerificationCodeEvent(email.text, code.text),
                      );
                },
              );
            },
            listener: (BuildContext context, AuthenticationState state) {
              if (state is AuthVerifyState) {
                state.result.fold((l) {
                  debugPrint(l.toString());

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l),
                      margin: const EdgeInsets.only(top: 20.0),
                      behavior: SnackBarBehavior.floating,
                      // Consider additional customization options:
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                }, (r) {
                  debugPrint(r.toString());

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(r),
                      margin: const EdgeInsets.only(top: 20.0),
                      behavior: SnackBarBehavior.floating,
                      // Consider additional customization options:
                      backgroundColor: Colors.green, // Adjust as desired
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  );
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) {
                      return MainScreen();
                    },
                  ));
                });
              }
            },
          ),
        );
      },
    );
  }
}

class ActivationCodeBTS extends StatelessWidget {
  const ActivationCodeBTS(
      {super.key,
      required this.code,
      required this.email,
      required this.onTap});

  final TextEditingController code;
  final TextEditingController email;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "کد فعال سازی رو وارد کن ",
            style: GoogleFonts.vazirmatn(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: code,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: "******",
                  hintStyle: GoogleFonts.vazirmatn(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.lightBlue))),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(onPressed: onTap, child: const Text("ادامه"))
        ],
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    super.key,
    required this.email,
  });

  final TextEditingController email;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "لطفا ایمیلت رو وارد کن",
            style: GoogleFonts.vazirmatn(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: email,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: "techblog@gmail.com",
                  hintStyle: GoogleFonts.vazirmatn(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.lightBlue))),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                context.read<AuthenticatioBloc>().add(
                      AthenticatioSendEmailRequest(email.text),
                    );
              },
              child: const Text("ادامه"))
        ],
      ),
    );
  }
}

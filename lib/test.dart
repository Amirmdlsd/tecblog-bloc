import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tecblog/data/repository/article_info_repository.dart';
import 'package:tecblog/data/repository/podcast/single_podcast_file_repository.dart';
import 'package:tecblog/data/repository/user/user_repository.dart';

class A extends StatefulWidget {
  const A({super.key});

  @override
  State<A> createState() => _AState();
}

class _AState extends State<A> {
  late ConcatenatingAudioSource playList;
  final AudioPlayer player = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    playList = ConcatenatingAudioSource(children: [], useLazyPreparation: true);
    super.initState();
    player.setAudioSource(playList,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('btn'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  var a = await UserRepository().getFavoritePodcast();
                  a.fold((l) => debugPrint(l.toString()), (r) {
                    debugPrint(r.length.toString());
                    r.forEach((e) {
                      debugPrint(e.title.toString());
                    });
                  });
                },
                child: const Text("click")),
          ],
        ),
      ),
    );
  }
}

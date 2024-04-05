import 'package:flutter/material.dart';
import 'package:tecblog/data/model/podcast_file.dart';
import 'package:tecblog/gen/assets.gen.dart';
import 'package:tecblog/resource/app_text_style.dart';

class PodcastFIleItems extends StatelessWidget {
  const PodcastFIleItems({super.key, required this.file,required this.color});
  final PodcastFileModel file;
  final TextStyle color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(
            Assets.icons.microphon.path,
            color: Colors.lightBlue,
            height: 30,
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: Text(
              file.title,
              style:color,
            ),
          ),
          const Spacer(),
          Text(
            '${file.length}:00',
            style: color,
          ),
        ],
      ),
    );
  }
}

// import 'dart:developer';

// import 'package:flutter/material.dart';

// import 'package:html_editor_enhanced/html_editor.dart';

// // ignore: must_be_immutable
// class ArticleContentEditor extends StatefulWidget {
//   ArticleContentEditor({super.key, required this.initText});

//   final TextEditingController initText;

//   @override
//   State<ArticleContentEditor> createState() => _ArticleContentEditorState();
// }

// class _ArticleContentEditorState extends State<ArticleContentEditor> {
//   final HtmlEditorController controller = HtmlEditorController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             HtmlEditor(
//               controller: controller,
//               htmlEditorOptions: HtmlEditorOptions(
//                   hint: "میتونی مقاله‌تو اینجا بنویسی...",
//                   shouldEnsureVisible: true,
//                   initialText: widget.initText.text),
//               callbacks: Callbacks(
//                 onChangeContent: (p0) {
//                   setState(() {
//                     widget.initText.text = p0!;
//                   });
//                 },
//               ),
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }

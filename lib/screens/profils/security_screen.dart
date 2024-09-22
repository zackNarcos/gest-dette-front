import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class SecurityScreen extends StatelessWidget {
  final StoryController controller = StoryController();

  SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: StoryView(
        controller: controller,
        storyItems: [
          StoryItem.text(
            title:
            "Hello world!\nHave a look at some great Ghanaian delicacies. I'm sorry if your mouth waters. \n\nTap!",
            backgroundColor: Colors.orange,
            roundedTop: true,
          ),
          // StoryItem.inlineImage(
          //   NetworkImage(
          //       "https://image.ibb.co/gCZFbx/Banku-and-tilapia.jpg"),
          //   caption: Text(
          //     "Banku & Tilapia. The food to keep you charged whole day.\n#1 Local food.",
          //     style: TextStyle(
          //       color: Colors.white,
          //       backgroundColor: Colors.black54,
          //       fontSize: 17,
          //     ),
          //   ),
          // ),
          StoryItem.inlineImage(
            url:
            "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
            controller: controller,
            caption: const Text(
              "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black54,
                fontSize: 17,
              ),
            ),
          ),
          StoryItem.inlineImage(
            url:
            "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
            controller: controller,
            caption: const Text(
              "Hektas, sektas and skatad",
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black54,
                fontSize: 17,
              ),
            ),
          )
        ],
        onStoryShow: (storyItem, index) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
        },
        progressPosition: ProgressPosition.bottom,
        repeat: false,
        inline: true,
      ),
    );
  }
}
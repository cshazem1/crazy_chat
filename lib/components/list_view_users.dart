import 'package:crazy_chat/components/user_card.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';

// ignore: must_be_immutable
class UsersListView extends StatelessWidget {
  ScrollController controller = ScrollController();

  UsersListView({
    super.key,
    required this.messageList,
    required this.email,
  });

  final List<Message> messageList;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                reverse: true,
                controller: controller,
                padding: const EdgeInsets.only(top: 10),
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  if (messageList[index].id == email) {
                    return const SizedBox();
                  } else {
                    return UserCardFromFriend(message: messageList[index]);
                  }
                }),
          ),
        ),
        (messageList.length) > 6
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton.small(
                    heroTag: "btn1",
                    elevation: 10,
                    onPressed: scrollUp,
                    child: const Icon(Icons.arrow_upward),
                  ),
                  FloatingActionButton.small(
                    heroTag: "btn2",
                    elevation: 10,
                    onPressed: scrollDown,
                    child: const Icon(Icons.arrow_downward_sharp),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }

  void scrollUp() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(seconds: 3),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  void scrollDown() {
    controller.animateTo(
      controller.position.minScrollExtent,
      duration: const Duration(seconds: 3),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }
}

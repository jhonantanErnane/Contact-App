import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'contact_list_controller.g.dart';

class ContactListController = _ContactListControllerBase
    with _$ContactListController;

abstract class _ContactListControllerBase with Store {
  Offset tapPosition;

  void onTapDown(TapDownDetails details) {
    tapPosition = details.globalPosition;
  }

  RelativeRect getRelativeRect(RenderBox overlay) => RelativeRect.fromRect(
        tapPosition & Size(40, 40), // smaller rect, the touch area
        Offset.zero & overlay.size, // Bigger rect, the entire screen
      );
}

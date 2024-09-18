import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genieclass_streaming_mobile/core/data_store/stream/dto/chat_dto.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/constants/image_paths.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

enum ChatTheme {
  light,
  dark,
}

enum ChatWidthType {
  percentage,
  fullScreen,
}

enum ChatItemType {
  text,
  sticker,
}

class LiveClassChatWidget extends StatefulWidget {
  const LiveClassChatWidget({
    super.key,
    required this.theme,
    required this.chats,
    required this.widthType,
    required this.connected,
    required this.isRestricted,
    required this.inputController,
    required this.onSendChat,
    required this.onClose,
  });

  final ChatTheme theme;
  final List<HistoryChat> chats;
  final ChatWidthType widthType;
  final bool connected;
  final bool isRestricted;
  final TextEditingController inputController;
  final void Function(String) onSendChat;
  final VoidCallback onClose;

  @override
  State<LiveClassChatWidget> createState() => _LiveClassChatWidgetState();
}

class _LiveClassChatWidgetState extends State<LiveClassChatWidget> {
  bool _showHint = true;

  final double maxWidthPercentage = 0.35;
  final double minWidthPercentage = 0.30; //was 0.25

  final bool _isLoading = false;

  double get chatWidth {
    double width = MediaQuery.of(context).size.width;
    return widget.widthType == ChatWidthType.percentage
        ? width * minWidthPercentage
        : width;
  }

  String get info {
    return widget.connected
        ? "Your messages can only be read by the teacher and moderator."
        : "Thank you for being early.\nYou may start typing when a teacher or moderator enters the chat.";
  }

  Color get bgColor {
    return widget.theme == ChatTheme.dark
        ? GCColors.navyBlue
        : GCColors.neutralChalk;
  }

  Color get bgInfoColor {
    return widget.theme == ChatTheme.dark
        ? GCColors.navyBright
        : GCColors.neutralEraser;
  }

  Color get bgInputColor {
    return widget.theme == ChatTheme.dark
        ? GCColors.neutralChalk
        : GCColors.neutralEraser;
  }

  Color get textInfoColor {
    return GCColors.neutralChalk;
  }

  Color get textColor {
    return widget.theme == ChatTheme.dark
        ? GCColors.neutralChalk
        : GCColors.navyDark;
  }

  Color get hintInputColor {
    return widget.theme == ChatTheme.dark
        ? GCColors.neutralEraser
        : GCColors.neutralChalk;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      color: bgColor,
      width: chatWidth,
      child: Column(
        children: [
          _buildHeader(),
          Spacings.verSpace(8),
          _buildChatInfoView(),
          Spacings.verSpace(16),
          _buildChatListView(),
          Spacings.verSpace(8),
          _buildChatInputWidget(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            "Chat",
            style: GCTextStyle.body(
              boldness: GCFontBoldness.bold,
              color: textColor,
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onClose,
          child: SvgPicture.asset(
            Images.icClose,
            height: 12,
            width: 12,
            colorFilter: const ColorFilter.mode(
              GCColors.apricotOrange,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChatInfoView() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: bgInfoColor,
      ),
      child: Text(
        info,
        style: GCTextStyle.callout(
          color: textInfoColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildChatListView() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.chats.length,
        itemBuilder: (context, index) {
          final chatContent = jsonDecode(widget.chats[index].content);
          return _buildChatItemView(
            sender: widget.chats[index].senderId,
            timeMarker: widget.chats[index].createdAt,
            content: chatContent['content'],
            type: chatContent['content_type'],
          );
        },
      ),
    );
  }

  Widget _buildChatItemView({
    required String sender,
    required String timeMarker,
    required String content,
    required String type,
  }) {
    ChatItemType chatType =
        type == 'text' ? ChatItemType.text : ChatItemType.sticker;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                sender,
                style: GCTextStyle.callout(
                  color: textColor,
                ),
              ),
            ),
            Spacings.horSpace(4),
            Text(
              timeMarker,
              style: GCTextStyle.callout(
                boldness: GCFontBoldness.regular,
                color: textColor,
              ),
            ),
          ],
        ),
        chatType == ChatItemType.text
            ? Text(
                content,
                style: GCTextStyle.callout(
                  boldness: GCFontBoldness.regular,
                  color: textColor,
                ),
              )
            : Lottie.network(
                content,
                animate: true,
                repeat: true,
                height: 18,
              ),
        Spacings.verSpace(8),
      ],
    );
  }

  Widget _buildChatInputWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: bgInputColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                if (_showHint)
                  Text(
                    "Type your message here",
                    style: GCTextStyle.callout(
                      color: hintInputColor,
                      style: FontStyle.italic,
                    ),
                  ),
                EditableText(
                  readOnly: widget.isRestricted,
                  controller: widget.inputController,
                  onChanged: _toggleHintView,
                  focusNode: FocusNode(),
                  keyboardType: TextInputType.text,
                  style: GCTextStyle.callout(
                    color: GCColors.navyDark,
                  ),
                  cursorColor: GCColors.apricotOrange,
                  backgroundCursorColor: GCColors.neutralChalk,
                ),
                // TextFormField(
                //   readOnly: widget.isRestricted,
                //   controller: widget.inputController,
                //   focusNode: FocusNode(),
                //   keyboardType: TextInputType.text,
                //   maxLines: 1,
                //   style: GCTextStyle.callout(
                //     boldness: GBPFontBoldness.regular,
                //     color: GCColors.navyDark,
                //   ),
                //   decoration: InputDecoration(
                //     border: InputBorder.none,
                //     hintText: "Type your message here",
                //     hintStyle: GCTextStyle.callout(
                //       boldness: GBPFontBoldness.regular,
                //       color: GCColors.neutralEraser,
                //       style: FontStyle.italic,
                //     ),
                //   ),
                //   maxLength: 225,
                //   cursorColor: GCColors.apricotorange,
                // ),
                if (widget.isRestricted)
                  Text(
                    "   ⃠ Chat is temporarily disabled",
                    style: GCTextStyle.callout(
                      color: GCColors.neutralChalk,
                    ),
                  ),
              ],
            ),
          ),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      GCColors.apricotOrange,
                    ),
                  ),
                )
              : _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.onSendChat(widget.inputController.text);
      },
      child: SvgPicture.asset(
        Images.icPlay,
        width: 14,
        colorFilter: const ColorFilter.mode(
          GCColors.apricotOrange,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  void _toggleHintView(String value) {
    if (_showHint == value.isEmpty) return;
    _showHint = value.isEmpty;
    setState(() {});
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:genieclass_streaming_mobile/core/tokens/colors.dart';
import 'package:genieclass_streaming_mobile/core/tokens/text_styles.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/button/default_button.dart';
import 'package:genieclass_streaming_mobile/ui/widgets/spacings.dart';

class CustomDialog extends ConsumerStatefulWidget {
  const CustomDialog({
    required this.child,
    super.key,
  });
  final Widget child;

  factory CustomDialog.confirmation(
    BuildContext context, {
    required String label,
    String? description,
    String? positiveLabel,
    String? negativeLabel,
    VoidCallback? positiveCallback,
    VoidCallback? negativeCallback,
  }) {
    return CustomDialog(
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: GCColors.neutralChalk,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacings.verSpace(16),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: GCTextStyle.title1(
                    color: GCColors.textPrimary,
                  ),
                ),
                if (description != null && description.isNotEmpty) ...[
                  Spacings.verSpace(16),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: GCTextStyle.body(
                      color: GCColors.textPositive,
                    ),
                  ),
                ],
                if (negativeLabel != null) ...[
                  Spacings.verSpace(24),
                  DefaultButton(
                    text: positiveLabel ?? '',
                    onPressed: positiveCallback,
                  ),
                ],
                if (positiveLabel != null) ...[
                  Spacings.verSpace(12),
                  DefaultButton(
                    text: negativeLabel ?? '',
                    onPressed: negativeCallback,
                  ),
                ],
                Spacings.verSpace(16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  factory CustomDialog.customDialog(
    BuildContext context, {
    required Widget child,
    bool showCloseButton = true,
  }) {
    return CustomDialog(
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: child,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  factory CustomDialog.bottomSheet(
    BuildContext context, {
    required Widget child,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 16),
  }) {
    return CustomDialog(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: padding,
          decoration: const BoxDecoration(
            color: GCColors.neutralChalk,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 24,
            ),
            child: Material(
              elevation: 0,
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          100,
                        ),
                        color: GCColors.neutralEraser35,
                      ),
                      width: 38,
                      height: 4,
                    ),
                  ),
                  Flexible(
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomDialogState();
}

class _CustomDialogState extends ConsumerState<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

Future<void> showCustomDialog({
  required BuildContext context,
  bool barrierDismissible = false,
  required Widget child,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (_, __, ___) {
      return SafeArea(
        bottom: false,
        child: child,
      );
    },
    barrierColor: GCColors.navyDark.withOpacity(0.56),
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
    useRootNavigator: true,
  );
}

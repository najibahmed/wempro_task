import 'dart:async';
import 'package:flutter/material.dart';

import '../Widgets/CustomDialog.dart';
import '../main.dart';
import 'app_image_utils.dart';


class UIUtil {
  static UIUtil instance = UIUtil();

  /// Show Toast
  showToast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 3),
    ));
  }

  dismissToast(BuildContext context) {
    try {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void errorToast(BuildContext context, String msg, String buttonText,
      Function()? call) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: buttonText,
          textColor: Colors.white,
          onPressed: () => (call == null) ? dismissToast(context) : call,
        ),
      ),
    );
  }

  /// Loader Behavior
  Future<void> showLoading(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child:
              CircularProgressIndicator()); //Image.asset(AppImages.instance.splashAnim, height: 100, width: 100));
        },
        barrierLabel: '');
  }

  void stopLoading(BuildContext context) {
    Navigator.pop(context);
  }

  void onNoInternet(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          CustomDialog(
              title: "No Internet!",
              message: "Please Check Your Connectivity!",
              image: AppImages.instance.noInternetAnim),
    );
  }

void onFailed(String failedMsg) {
  final context = navigatorKey.currentContext;
  if(context != null){
    showDialog(
      context: context,
      builder: (context) => Builder(builder: (context) {
        return CustomDialog(
            title: "Failed!",
            message: failedMsg,
            image: AppImages.instance.errorAnim);
      }),
    );
  }
}
}


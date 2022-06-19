import 'package:flutter/cupertino.dart';
import '../../data/exeptions/auth_exceptions.dart';
import 'generic_dialog.dart';

// auth error  dialog
Future<void> showAuthErrorDailog({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionBuilder: () => {
      'OK': true,
    },
  );
}

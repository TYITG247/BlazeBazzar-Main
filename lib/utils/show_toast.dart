import 'package:fluttertoast/fluttertoast.dart';

showMessage(context, String title) {
  Fluttertoast.showToast(
    msg: title,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1
  );
}

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_gemini_sample/presentation/utills/toast/toast.dart';

Future<void> copyTextToClipboard(String text) async {
  if (kIsWeb) {
    await Clipboard.setData(ClipboardData(text: text));
  } else {
    showToast('Feature not available for this plateform');
  }
}

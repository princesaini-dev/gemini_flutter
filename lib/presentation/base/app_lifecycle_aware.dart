import 'package:flutter/material.dart';

mixin AppLifecycleAware<T extends StatefulWidget> on State<T> {
  late final AppLifecycleListener _appLifecycleListener;

  @override
  void initState() {
    super.initState();
    _appLifecycleListener = AppLifecycleListener(
      onShow: onShow,
      onResume: onResume,
      onPause: onPause,
      onRestart: onRestart,
      onInactive: onInactive,
      onDetach: onDetach,
      onStateChange: onStateChange,
    );
  }

  @override
  void dispose() {
    _appLifecycleListener.dispose();
    super.dispose();
  }

  void onShow() {}

  void onResume() {}

  void onPause() {}

  void onRestart() {}

  void onInactive() {}

  void onhide() {}

  void onDetach() {}

  void onStateChange(AppLifecycleState appLifecycleState) {}
}

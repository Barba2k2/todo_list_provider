import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import '../ui/messages.dart';
import 'default_change_notifier.dart';

class DefaultListenerNotifier {
  final DefaultChangeNotifier changeNotifier;

  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SuccessVoidCallBack successCallback,
    EverVoidCallBack? everCallback,
    ErrorVoidCallBack? errorCallback,
  }) {
    changeNotifier.addListener(
      () {
        if (everCallback != null) {
          everCallback(changeNotifier, this);
        }
        
        if (changeNotifier.loading) {
          Loader.show(context);
        } else {
          Loader.hide();
        }

        if (changeNotifier.hasError) {
          if (errorCallback != null) {
            errorCallback(changeNotifier, this);
          }

          Messages.of(context).showError(
            changeNotifier.error ?? 'Erro interno',
          );
        } else if (changeNotifier.isSuccess) {
          successCallback(changeNotifier, this);
        }
      },
    );
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallBack = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listenerInstance,
);

typedef ErrorVoidCallBack = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listenerInstance,
);

typedef EverVoidCallBack = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listenerInstance,
);

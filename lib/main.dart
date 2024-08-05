import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:l/l.dart';
import 'package:restaurant_app/src/common/util/error_util.dart';
import 'package:restaurant_app/src/common/util/logger_util.dart';
import 'package:restaurant_app/src/common/widget/app.dart';
import 'package:restaurant_app/src/common/widget/app_error.dart';
import 'package:restaurant_app/src/dependencies/initialization/initialization.dart';
import 'package:restaurant_app/src/dependencies/widget/dependencies_scope.dart';

void main() => l.capture<void>(
      () => runZonedGuarded<void>(
        () {
          // Splash screen
          final initializationProgress = ValueNotifier<({int progress, String message})>((progress: 0, message: ''));
          $initializeApp(
            onProgress: (progress, message) => initializationProgress.value = (progress: progress, message: message),
            onSuccess: (dependencies) => runApp(
              DependenciesScope(
                dependencies: dependencies,
                child: const App(),
              ),
            ),
            onError: (error, stackTrace) {
              runApp(AppError(error: error));
              ErrorUtil.logError(error, stackTrace).ignore();
            },
          ).ignore();
        },
        l.e,
      ),
      const LogOptions(
        handlePrint: true,
        messageFormatting: LoggerUtil.messageFormatting,
        outputInRelease: false,
        printColors: true,
      ),
    );

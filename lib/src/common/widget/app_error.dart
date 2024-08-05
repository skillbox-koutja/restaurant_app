import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  const AppError({
    super.key,
    this.error,
  });

  /// Error
  final Object? error;

  @override
  Widget build(BuildContext context) {
    final platformDispatcher = View.of(context).platformDispatcher;
    final theme = platformDispatcher.platformBrightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);

    return MaterialApp(
      title: 'App Error',
      theme: theme,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                // ErrorUtil.formatMessage(error)
                error?.toString() ?? 'Something went wrong',
                textScaler: TextScaler.noScaling,
              ),
            ),
          ),
        ),
      ),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.noScaling,
        ),
        child: child!,
      ),
    );
  }
}

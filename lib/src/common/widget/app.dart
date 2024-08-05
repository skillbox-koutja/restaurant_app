import 'package:flutter/material.dart';
import 'package:restaurant_app/src/common/localization/localization.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final platformDispatcher = View.of(context).platformDispatcher;
    final theme = platformDispatcher.platformBrightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);

    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: Localization.localizationsDelegates,
      supportedLocales: Localization.supportedLocales,
      theme: theme,
      home: const Placeholder(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1),
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}

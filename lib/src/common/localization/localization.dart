import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:restaurant_app/src/l10n/app_localizations.dart';

/// Localization.
final class Localization {
  /// Localization delegate.
  static const delegate = _Delegate(
    AppLocalizations.delegate,
  );

  /// Current localization instance.
  static AppLocalizations get current => _current;
  static late AppLocalizations _current;

  static const localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    delegate,
  ];

  static const supportedLocales = AppLocalizations.supportedLocales;

  /// Get localization instance for the widget structure.
  static AppLocalizations of(BuildContext context) =>
      switch (Localizations.of<AppLocalizations>(context, Localization)) {
        AppLocalizations localization => localization,
        _ => throw ArgumentError(
            'Out of scope, not found inherited widget '
                'a AppLocalizations of the exact type',
            'out_of_scope',
          ),
      };
}

final class _Delegate extends LocalizationsDelegate<AppLocalizations> {
  const _Delegate(
    LocalizationsDelegate<AppLocalizations> delegate,
  ) : _delegate = delegate;

  final LocalizationsDelegate<AppLocalizations> _delegate;

  @override
  bool isSupported(Locale locale) => _delegate.isSupported(locale);

  @override
  Future<AppLocalizations> load(Locale locale) {
    final future = AppLocalizations.delegate.load(locale);

    return future.then<AppLocalizations>(
      (localization) => Localization._current = localization,
    );
  }

  @override
  bool shouldReload(covariant _Delegate old) => _delegate.shouldReload(old._delegate);
}

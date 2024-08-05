import 'package:flutter/material.dart';
import 'package:restaurant_app/src/dependencies/model/dependencies.dart';

/// {@template inherited_dependencies}
/// InheritedDependencies widget.
/// {@endtemplate}
class DependenciesScope extends InheritedWidget {
  /// {@macro inherited_dependencies}
  const DependenciesScope({
    required this.dependencies,
    required super.child,
    super.key,
  });

  final Dependencies dependencies;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `InheritedDependencies.maybeOf(context)`.
  static Dependencies? maybeOf(BuildContext context) {
    final el = _findElement(context);

    return (el?.widget as DependenciesScope?)?.dependencies;
  }

  static InheritedElement? _findElement(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<DependenciesScope>();
  }

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a InheritedDependencies of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// e.g. `InheritedDependencies.of(context)`
  static Dependencies of(BuildContext context) => maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant DependenciesScope oldWidget) => false;
}

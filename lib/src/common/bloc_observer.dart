import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    l.d('[${bloc.runtimeType}.onChange] ${change.currentState} to ${change.nextState}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    l.e('[${bloc.runtimeType}.onError] $error $stackTrace');
  }
}

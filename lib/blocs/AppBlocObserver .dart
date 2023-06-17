import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    bloc.close();
  }
}

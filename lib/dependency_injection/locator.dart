import 'package:ease_tube/bloc/login_bloc/login_bloc.dart';

import 'dependency_injection.dart';

GetIt getIt = GetIt.instance;

class ServiceLocator {
  void servicesLocator() {
    getIt.registerFactory(() => LoginBloc());
  }
}

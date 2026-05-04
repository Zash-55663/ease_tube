import 'package:ease_tube/bloc/login_bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

// The global instance of the Service Locator
GetIt getIt = GetIt.instance;

class ServiceLocator {
  // Configures the registry for all application dependencies
  void servicesLocator() {
    // Registers LoginBloc as a factory
    // A 'factory' creates a new instance every time getIt<LoginBloc>() is called
    // This is ideal for UI logic like the LoginScreen to ensure a fresh state
    getIt.registerFactory(() => LoginBloc());
  }
}

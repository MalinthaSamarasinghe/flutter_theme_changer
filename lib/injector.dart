import 'package:get_it/get_it.dart';
import 'core/blocs/theme/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> setupLocators() async {
  sl.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
}

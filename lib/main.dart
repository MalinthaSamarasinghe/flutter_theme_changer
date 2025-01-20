import 'dart:async';
import 'injector.dart';
import 'package:flutter/material.dart';
import 'core/blocs/bloc_observer.dart';
import 'core/enums/app_theme_mode.dart';
import 'features/home/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'core/blocs/theme/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      /// Initialize service locator
      await setupLocators();

      /// Setup global observer to monitor all blocs
      Bloc.observer = ThemeBlocObserver();

      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorage.webStorageDirectory
            : await getApplicationDocumentsDirectory(),
      );

      runApp(MyApp());
    },
    (error, stack) {
      debugPrint("runZonedGuarded: Caught error in my root zone. $error | stack $stack");
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Material App',
            theme: state.appThemeMode == AppThemeMode.system
                ? View.of(context).platformDispatcher.platformBrightness == Brightness.dark ? ThemeData.dark() : ThemeData.light()
                : state.appThemeMode == AppThemeMode.dark ? ThemeData.dark() : ThemeData.light(),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}

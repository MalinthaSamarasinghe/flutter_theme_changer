import 'dart:ui';
import '../event_transformer.dart';
import 'package:flutter/material.dart';
import '../../enums/app_theme_mode.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> with WidgetsBindingObserver {

  @override
  void didChangePlatformBrightness() {
    if (state.appThemeMode == AppThemeMode.system) {
      add(ThemeChanged(appThemeMode: AppThemeMode.system));
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  ThemeBloc() : super(ThemeState(themeData: ThemeData.light(), appThemeMode: AppThemeMode.light)){
    on<ThemeChanged>(_onThemeChanged, transformer: Transformer.throttleRestartable());
    WidgetsBinding.instance.addObserver(this);
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    if(event.appThemeMode == AppThemeMode.system) {
      emit(ThemeState(
        themeData: PlatformDispatcher.instance.platformBrightness == Brightness.dark ? ThemeData.dark() : ThemeData.light(),
        appThemeMode: AppThemeMode.system,
      ));
      return;
    }
    emit(ThemeState(
      themeData: event.appThemeMode == AppThemeMode.dark ? ThemeData.dark() : ThemeData.light(),
      appThemeMode: event.appThemeMode,
    ));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    try {
      return ThemeState(
        appThemeMode: appThemeModeValues.map[json['appThemeMode']] ?? AppThemeMode.light,
      );
    } catch (_) {}
    return null;
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    try {
      return {
        'appThemeMode': appThemeModeValues.reverse[state.appThemeMode],
      };
    } catch (_) {}
    return null;
  }
}

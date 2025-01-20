part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final ThemeData? themeData;
  final AppThemeMode appThemeMode;

  const ThemeState({
    this.themeData,
    required this.appThemeMode,
  });

  @override
  List<Object?> get props => [themeData, appThemeMode];

  ThemeState copyWith({
    ThemeData? themeData,
    AppThemeMode? appThemeMode,
  }) {
    return ThemeState(
      themeData: themeData ?? this.themeData,
      appThemeMode: appThemeMode ?? this.appThemeMode,
    );
  }
}

import 'package:flutter/material.dart';
import '../../core/enums/app_theme_mode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/blocs/theme/theme_bloc.dart';
import 'package:flutter_theme_changer/utils/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: Container(
        color: Theme.of(context).background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 26),
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Choose Theme',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: AppThemeMode.values.length,
                itemBuilder: (context, index) {
                  // Enums expose their values as a list - perfect for ListView
                  // Store the theme for the current ListView item
                  final itemAppTheme = AppThemeMode.values[index];
                  return Card(
                    // Style the cards with the to-be-selected theme colors
                    shape: RoundedRectangleBorder(
                      side: context.read<ThemeBloc>().state.appThemeMode == AppThemeMode.values[index] ? BorderSide(color: Colors.black) : BorderSide.none,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: Text(itemAppTheme.toString().replaceAll('AppThemeMode.', '')),
                      onTap: () {
                        // This will make the Bloc output a new ThemeState,
                        // which will rebuild the UI because of the BlocBuilder in main.dart
                        context.read<ThemeBloc>().add(ThemeChanged(appThemeMode: itemAppTheme));
                        // BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(theme: itemAppTheme));
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

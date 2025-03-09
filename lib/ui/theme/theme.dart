import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The [AppTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade package to version 8.1.1.
///
/// Use in [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    scheme: FlexScheme.blueM3,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.blueM3,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

InputBorder defaultTextFieldBorder(BuildContext context,
        {final double radius = 8}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: Colors.blueGrey, width: 2));
InputBorder defaultFocusedTextFieldBorder(BuildContext context,
        {final double radius = 8}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface, width: 2));
InputBorder defaultErrorTextFieldBorder(BuildContext context,
        {final double radius = 8}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: Colors.redAccent, width: 2));

InputDecoration defaultTextFieldInputDecoration(BuildContext context,
        {final double radius = 8}) =>
    InputDecoration(
        border: defaultTextFieldBorder(context, radius: radius),
        enabledBorder: defaultTextFieldBorder(context, radius: radius),
        errorBorder: defaultErrorTextFieldBorder(context, radius: radius),
        focusedBorder: defaultFocusedTextFieldBorder(context, radius: radius),
        labelStyle: TextStyle(color: Colors.blueGrey),
        floatingLabelStyle:
            TextStyle(color: Theme.of(context).colorScheme.onSurface),
        errorStyle: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: Colors.redAccent),
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        alignLabelWithHint: true,
        prefixIconColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return Theme.of(context).colorScheme.onSurface;
          }
          if (states.contains(WidgetState.error)) {
            return Colors.redAccent;
          }
          return Theme.of(context).colorScheme.onSurface;
        }));

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/services/app_settings.dart';
import 'package:innotes/view/auth/authentication.dart';
import 'package:innotes/view/userdialog/widget/button.dart';
import 'package:provider/provider.dart';

class ThemeModeSelector extends StatefulWidget {
  const ThemeModeSelector({super.key});

  @override
  State<ThemeModeSelector> createState() => _ThemeModeSelectorState();
}

class _ThemeModeSelectorState extends State<ThemeModeSelector> {
  bool _expand = false;
  @override
  Widget build(BuildContext context) {
    final currentThemeMode = context.read<AppSettingsService>().themeMode;
    return Column(
      children: [
        ButtonTile(
          onTap: () {
            setState(() {
              _expand = !_expand;
            });
          },
          prefix: Icon(currentThemeMode == ThemeMode.dark
              ? FluentIcons.weather_moon_24_regular
              : currentThemeMode == ThemeMode.system
                  ? FluentIcons.phone_24_regular
                  : FluentIcons.weather_sunny_24_regular),
          suffix: AnimatedRotation(
              duration: AnimationConsts.defaultDuration,
              curve: AnimationConsts.curve,
              turns: _expand ? 0.5 : 0,
              child: const Icon(FluentIcons.chevron_down_24_regular)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('App Theme',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(height: 1.1)),
              const SizedBox(height: 3),
              Text(
                'Dark',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          duration: AnimationConsts.defaultDuration,
          firstCurve: AnimationConsts.curve,
          secondCurve: AnimationConsts.curve,
          sizeCurve: AnimationConsts.curve,
          layoutBuilder: (Widget topChild, Key topChildKey, Widget bottomChild,
                  Key bottomChildKey) =>
              Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned(
                key: bottomChildKey,
                left: 0.0,
                top: 0.0,
                right: 0.0,
                child: bottomChild,
              ),
              Positioned(
                key: topChildKey,
                child: topChild,
              ),
            ],
          ),
          firstChild: SizedBox.shrink(),
          secondChild: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTile(
                  ThemeMode.dark, 'Dark', FluentIcons.weather_moon_24_regular),
              _buildTile(ThemeMode.light, 'Light',
                  FluentIcons.weather_sunny_24_regular),
              _buildTile(ThemeMode.system, "System\'s theme",
                  FluentIcons.phone_24_regular),
            ],
          ),
          crossFadeState:
              _expand ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ],
    );
  }

  Widget _buildTile(ThemeMode themeMode, String label, IconData icon) {
    final appSettingsService = context.read<AppSettingsService>();
    return ButtonTile(
      prefix: Icon(icon),
      onTap: () {
        appSettingsService.themeMode = themeMode;
      },
      suffix: appSettingsService.themeMode == themeMode
          ? const Icon(FluentIcons.checkmark_24_regular)
          : null,
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).primaryColor),
      ),
    );
  }
}

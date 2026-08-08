import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'shared/widgets/main_navigation.dart';

class YiLinkApp extends StatelessWidget {
  const YiLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YiLink Health',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigation(),
    );
  }
}
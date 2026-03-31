import 'package:autovault/core/app/route.dart';
import 'package:autovault/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:autovault/core/theme/font.dart';
import 'package:autovault/core/utils/size_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoVault extends ConsumerWidget {
  const AutoVault({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Manrope", "Inter");
    MaterialTheme theme = MaterialTheme(textTheme);
    SizeConfig().init(context);

    return MaterialApp.router(
      routerConfig: router,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      debugShowCheckedModeBanner: false,
      title: 'AutoVault',
    );
  }
}

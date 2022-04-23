import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelive/themes/color_schemer.dart';
import 'package:timelive/timeline_screen.dart';

import 'bloc/events_cubit.dart';

class TimeliveApp extends StatelessWidget {
  const TimeliveApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = EventsCubit();
        cubit.refreshEvents();
        return cubit;
      },
      child: MaterialApp(
        title: 'Timelive',
        // themeMode: ThemeMode.system,
        themeMode: ThemeMode.light,
        theme: ColorSchemer.lightTheme(),
        darkTheme: ColorSchemer.darkTheme(),
        home: TimelineScreen(),
      ),
    );
  }
}

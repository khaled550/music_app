import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/data/api/details_api.dart';
import 'package:music_app/data/api/home_api.dart';
import 'package:music_app/data/api/track_lyrics_api.dart';
import 'package:music_app/pages/details_page.dart';
import 'package:music_app/pages/home_page.dart';
import 'package:music_app/pages/no_connection.dart';

import 'bloc/cubit/home_cubit.dart';

class AppRouter {
  late HomeCubit homeCubit;

  AppRouter() {
    homeCubit = HomeCubit(HomeApi(), DetailsApi(), TrackLyricsApi());
  }

  Route? generateRoute(RouteSettings settings) {
    String pagePath = settings.name!;

    switch (pagePath) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: homeCubit..checkConnection(),
                  child: const HomePage(),
                ));
      case '/details':
        final trackId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (context) => BlocProvider.value(
                  value: homeCubit
                    ..getTracksDetailsData(
                      trackId,
                    ),
                  child: const DetailsPage(),
                ),
            settings: settings);
      case '/no_connection':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: homeCubit,
            child: const NoConnectionPage(),
          ),
          settings: settings,
        );
      default:
        return null;
    }
  }
}

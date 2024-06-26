import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_morty_wiki/app_navigator.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';
import 'package:ricky_morty_wiki/core/constants/custom_routes.dart';
import 'package:ricky_morty_wiki/core/constants/network_service.dart';
import 'package:ricky_morty_wiki/core/helper/shared_pref_helper.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/charcter_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/counter_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/bloc_cubit/drop_down_cubit.dart';
import 'package:ricky_morty_wiki/features/cast/repository/characters_repository.dart';
import 'package:ricky_morty_wiki/features/cast_details/bloc_cubit/cast_details_cubit.dart';
import 'package:ricky_morty_wiki/features/cast_details/screen/cast_details_screen.dart';
import 'package:ricky_morty_wiki/features/episodes/bloc_cubit/episode_cubit.dart';
import 'package:ricky_morty_wiki/features/home/bloc_cubit/favourite_characters_cubit.dart';
import 'package:ricky_morty_wiki/features/location/bloc_cubit/location_cubit.dart';
import 'package:ricky_morty_wiki/features/location/repository/location_repository.dart';
import 'package:ricky_morty_wiki/features/splash/bloc/splash_cubit.dart';

import 'features/bottom_nav_bar/bloc_cubit/bottomnav_bar_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HttpService().init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashCubit(),
        ),
        BlocProvider(
          create: (context) => BottomNavBarCubit(),
        ),
        BlocProvider(
          create: (context) => CharacterCubit(),
        ),
        BlocProvider(
          create: (context) => LocationCubit(),
        ),
        BlocProvider(
          create: (context) => DropdownCubit(),
        ),
        BlocProvider(
          create: (context) => FavouriteCharactersCubit(SharedPrefHelper()),
        ),
        BlocProvider(
          create: (context) => CastDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => EpisodeCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ricky and Morty Wiki',
        theme: ThemeData(
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: customRouteGenerator,
      ),
    );
  }
}
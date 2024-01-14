import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_trip_flutter_app/constant/app_colors.dart';
import 'package:my_trip_flutter_app/data/bloc/login_bloc/login_bloc.dart';
import 'package:my_trip_flutter_app/presentation/onboarding/onboarding.dart';
import 'data/bloc/trip_place_bloc/trip_place_bloc.dart';
import 'data/bloc/user_bloc/user_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => TripBloc()),
      ],
      child: MaterialApp(
        title: 'My Trip App',
        theme: ThemeData(
          primaryColor: AppColors.grey.shade900,
        ),
        home: const Onboarding(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_mindd/features/Layout/cubit/home_cubit.dart';
import 'package:task_mindd/features/Layout/cubit/home_state.dart';
import 'package:task_mindd/features/auth/cubit/login_cubit.dart';
import 'package:task_mindd/features/auth/cubit/login_state.dart';
import 'package:task_mindd/features/Layout/home_screen.dart';

import 'block_observer.dart';
import 'core/utils/constant.dart';
import 'core/utils/local_data.dart';
import 'features/Layout/Layout_screen.dart';
import 'features/auth/login_screen.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.init();
  Widget? widget;
  token = CacheNetwork.getData(key: "token");
  print(token);
  if (token != null) {
    widget = const LayoutScreen();
  } else {
    widget = const LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ),);
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({super.key, this.startWidget});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: const Locale("ar"),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: startWidget,
          );
        },
      ),
    );
  }
}



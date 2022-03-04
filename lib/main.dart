import 'package:arafa/Layout/AppLayout.dart';
import 'package:arafa/cubit/App/AppStates.dart';
import 'package:arafa/firebase_options.dart';
import 'package:arafa/modules/login_screen.dart';
import 'package:arafa/network/local/cashHelper.dart';
import 'package:arafa/shared/bloc_observer.dart';
import 'package:arafa/styles/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constents/constents.dart';
import 'cubit/App/AppCubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

   uId = CashHelper.getData(key: 'uId');
  print(uId.toString());
  Widget? widget;


  if (uId != null) {
    widget = App_layout();
  } else {
    widget = AppLogin_Screen();
  }

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}


class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: LightTheme,
            darkTheme: DarkTheme,
            home: AppLogin_Screen(),
          );
        },
      ),
    );
  }
}

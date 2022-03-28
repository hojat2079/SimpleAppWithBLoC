import 'package:bolc/data/data.dart';
import 'package:bolc/data/repository/repository_impl.dart';
import 'package:bolc/data/source/hive_task_local_source.dart';
import 'package:bolc/ui/colors.dart';
import 'package:bolc/ui/screen/home/home.dart';
import 'package:bolc/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>(taskBoxName);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryVariantColor,
      statusBarIconBrightness: Brightness.light));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<RepositoryImpl<Task>>(
        create: (context) =>
            RepositoryImpl<Task>(HiveTaskLocalSource(Hive.box(taskBoxName)))),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const backgroundTextColor = Color(0xff1D2830);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(const TextTheme(
              headline6: TextStyle(fontWeight: FontWeight.bold))),
          inputDecorationTheme: const InputDecorationTheme(
              iconColor: secondaryTextColor,
              labelStyle: TextStyle(color: secondaryTextColor)),
          colorScheme: const ColorScheme.light(
              primary: primaryColor,
              primaryContainer: primaryVariantColor,
              background: Color(0xfff3f5f8),
              onSurface: backgroundTextColor,
              onBackground: backgroundTextColor,
              onPrimary: Colors.white,
              secondary: primaryColor,
              onSecondary: Colors.white)),
      home: HomeScreen(),
    );
  }
}

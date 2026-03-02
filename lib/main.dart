import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Setup window
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = WindowOptions(
    size: Size(500, 700),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    minimumSize: Size(450, 600),
  );
  
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  
  runApp(MyApp()); // Hapus 'const' di sini
}

class MyApp extends StatelessWidget {
  MyApp({super.key}); // Hapus 'const' di constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotspot Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme( // Hapus 'const'
          centerTitle: true,
          elevation: 2,
        ),
        cardTheme: CardThemeData( // Hapus 'const'
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme( // Hapus 'const'
          centerTitle: true,
          elevation: 2,
        ),
        cardTheme: CardThemeData( // Hapus 'const'
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: HomeScreen(), // Hapus 'const'
    );
  }
}
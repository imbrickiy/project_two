import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_two/common/colors.dart';
import 'package:project_two/states/station_player_state.dart';
import 'package:project_two/widgets/layout_with_footer.dart';
import 'package:provider/provider.dart';

import 'model/stations.dart';
import 'pages/list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PlayerProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Data? data;

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  Future<void> loadJson() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/stations.json',
      );
      final jsonMap = jsonDecode(jsonString);

      if (jsonMap is! Map<String, dynamic> || !jsonMap.containsKey('result')) {
        throw const FormatException('Неверный формат данных');
      }

      setState(() {
        data = Data.fromJson(jsonMap);
      });
    } catch (e, stack) {
      debugPrint('Ошибка загрузки или парсинга JSON: $e\n$stack');
      setState(() {
        data = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Radio Stations'),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: LayoutWithFooter(
        child: FixedSizeGrid(stations: data!.result!.stations),
      ),
    );
  }
}

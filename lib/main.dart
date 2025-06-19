import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'list_screen.dart';
import 'model/stations.dart';

void main() {
  runApp(const MyApp());
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
      backgroundColor: const Color(0xFF262626).withValues(alpha: 0.9),
      appBar: AppBar(
        backgroundColor: const Color(
          0xFF262626,
        ), // 90% opacity// Transparent background
        elevation: 0,
        title: const Text(
          'Stations',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: FixedSizeGrid(stations: data!.result!.stations),
    );
  }
}

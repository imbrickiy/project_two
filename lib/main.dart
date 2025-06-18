import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_two/station_screen.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Список'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Сетка'),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StationScreen()),
            );
          } else {
            // Здесь можно добавить логику для сетки, если нужно
          }
        },
      ),
      backgroundColor: const Color(0xFF141414),
      appBar: AppBar(
        title: const Text('Сетка станций'),
        backgroundColor: const Color(0xFF262626),
      ),
      body: FixedSizeGrid(items: data!.result!.stations),
    );
  }
}

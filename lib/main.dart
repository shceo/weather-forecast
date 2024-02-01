import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/domain/hive/favorite_history.dart';
import 'package:weather_app/domain/hive/hive_boxes.dart';
import 'package:weather_app/weather_app.dart';

Future<void> main() async {
  
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteHistoryAdapter());
  await Hive.openBox<FavoriteHistory>(HiveBoxes.favBox);
  
  await dotenv.load(fileName: '.env');

  runApp(const WeatherApp());
}

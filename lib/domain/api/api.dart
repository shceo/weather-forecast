import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/domain/models/coord.dart';
import 'package:weather_app/domain/models/weather_data.dart';

abstract class Api {
  static final apiKey = dotenv.get('API_KEY');

  // Ссылка для получения координат
  //https://api.openweathermap.org/data/2.5/weather?q=London&appid=49cc8c821cd2aff9af04c9f98c36eb74

  static Future<Coord> getCoords({String? cityName}) async {
    final dio = Dio();
    final response = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&lang=ru');

    try {
      final coords = Coord.fromJson(response.data);
      return coords;
    } catch (e) {
      final coords = Coord.fromJson(response.data);
      return coords;
    }
  }

// Ссылка для получения погоды
//https://api.openweathermap.org/data/2.5/onecall?lat=55.7522&lon=37.6156&exclude=hourly,minutely&appid=49cc8c821cd2aff9af04c9f98c36eb74

  static Future<WeatherData?> getWeather(Coord? coord) async {
    if (coord != null) {
      final dio = Dio();
      final lat = coord.lat.toString();
      final lon = coord.lon.toString();

      final response = await dio.get(
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=hourly,minutely&appid=$apiKey&lang=ru');

      final weatherData = WeatherData.fromJson(response.data);
      return weatherData;
    }
    return null;
  }
}

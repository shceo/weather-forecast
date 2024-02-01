import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/domain/api/api.dart';
import 'package:weather_app/domain/hive/favorite_history.dart';
import 'package:weather_app/domain/hive/hive_boxes.dart';
import 'package:weather_app/domain/models/coord.dart';
import 'package:weather_app/domain/models/weather_data.dart';
import 'package:weather_app/ui/resources/app_bg.dart';
import 'package:weather_app/ui/routes/app_routes.dart';
import 'package:weather_app/ui/theme/app_colors.dart';

class WeatherProvider extends ChangeNotifier {
  //хранение координат
  Coord? coords;

  //хранение данных о погоде
  WeatherData? weatherData;

  //хранение текущих данных о погоде
  Current? current;

  //коньроллер для установки города
  TextEditingController cityController = TextEditingController();

// подключение SharpedPreferences
  final pref = SharedPreferences.getInstance();

  //Главную функцию которую мы запустим в FutureBuilder
  Future<WeatherData?> setUp({String? cityName}) async {
    // (await pref).clear(); // очищает sharpedpreferences
    cityName = (await pref).getString('city_name');

    coords = await Api.getCoords(cityName: cityName ?? 'Ташкент');
    weatherData = await Api.getWeather(coords);
    current = weatherData?.current;
    //
    setCurrentTime();
    setCurrentTemp();
    setWeekDays();
    return weatherData;
  }

  //установка текущего города

  void setCurrentCity(BuildContext context, {String? cityName}) async {
    if (cityController.text != '') {
      cityName = cityController.text;

      (await pref).setString('city_name', cityName);
      await setUp(cityName: (await pref).getString('city_name'))
          .then((value) => context.go(AppRoutes.home))
          .then(
            (value) => cityController.clear(),
          );
      notifyListeners();
    }
  }

  //изменение заднего фона
  String? currentBg;

  String setBg() {
    int id = current?.weather?[0].id ?? -1;

    if (id == -1 || current?.sunset == null || current?.dt == null) {
      currentBg = AppBg.shinyDay;
    }

    try {
      if (current?.sunset < current?.dt) {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyNight;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowNight;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogNight;
        } else if (id == 800) {
          currentBg = AppBg.shinyNight;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyNight;
        }
      } else {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyDay;
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowDay;
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogDay;
        } else if (id == 800) {
          currentBg = AppBg.shinyDay;
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyDay;
        }
      }
    } catch (e) {
      return AppBg.shinyDay;
    }
    return currentBg ?? AppBg.shinyDay;
  }

  //текущее время

  String? currentTime;
  String setCurrentTime() {
    final getTime = (current?.dt ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000);
    currentTime = DateFormat('HH:mm a').format(setTime);
    return currentTime ?? 'Error';
  }

  //метод превращения первой буквы слова в заглавную, остальные строчные
  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);

  /* текущий статус погоды */

  String iconUrl = 'https://api.openweathermap.org/img/w/';

  // метод получение текущей иконки
  String iconData() {
    return '$iconUrl${current?.weather?[0].icon}.png';
  }

  // метод текущего статуса погоды
  String currentStatus = 'Ошибка';

  String getCurrentStatus() {
    currentStatus = current?.weather?[0].description ?? 'Ошибка';
    return capitalize(currentStatus);
  }

  //получиение текущей темперaтуры
  int currentTemp = 0;
  int kelvin = -273;

  int setCurrentTemp() {
    currentTemp = ((current?.temp ?? -kelvin) + kelvin).round();
    return currentTemp;
  }

  // получение максимальной температуры
  int maxTemp = 0;

  int setMaxTemp() {
    maxTemp = ((weatherData?.daily?[0].temp?.max ?? -kelvin) + kelvin).round();
    return maxTemp;
  }

  //получение минимальной температуры
  int minTemp = 0;
  int setMinTemp() {
    minTemp = ((weatherData?.daily?[0].temp?.min ?? -kelvin) + kelvin).round();
    return minTemp;
  }

  //установка дней недели

  final List<String> date = [];
  List<Daily> daily = [];

  void setWeekDays() {
    daily = weatherData?.daily ?? [];
    for (var i = 0; i < daily.length; i++) {
      if (i == 0 && daily.isNotEmpty) {
        date.clear();
      }
      if (i == 0) {
        date.add('Сегодня');
      } else {
        var timeNum = daily[i].dt * 1000;
        var itemDate = DateTime.fromMillisecondsSinceEpoch(timeNum);
        date.add(
          capitalize(
            DateFormat('EEEE', 'ru').format(itemDate),
          ),
        );
      }
    }
  }

  //метод получение иконок на всю неделю

  // ignore: non_constant_identifier_names
  String SetDailyIcons(int index) {
    final String getIcon = '${weatherData?.daily?[index].weather?[0].icon}';
    final String setIcon = '$iconUrl$getIcon.png';

    return setIcon;
  }

  /* получение дневной температуры на каждый день*/

  int dailyTemp = 0;

  int setDailyTemp(int index) {
    dailyTemp =
        ((weatherData?.daily?[index].temp?.morn ?? -kelvin) + kelvin).round();
    return dailyTemp;
  }

  /* получение вечерней температуры на каждый день*/

  int nightTemp = 0;

  int setNightTemp(int index) {
    nightTemp =
        ((weatherData?.daily?[index].temp?.night ?? -kelvin) + kelvin).round();
    return nightTemp;
  }

  // добовление массив о погодных условиях
  final List<dynamic> _weatherValue = [];
  List<dynamic> get weatherValue => _weatherValue;

  dynamic setValues(int index) {
    _weatherValue.add(current?.windSpeed ?? 0);
    _weatherValue.add(((current?.feelsLike ?? -kelvin) + kelvin).round());
    _weatherValue.add((current?.humidity ?? 0) / 1);
    _weatherValue.add((current?.visibility ?? 0) / 1000);

    return weatherValue[index];
  }

  // текущее время восхода
  String sunRise = '';

  String setCurrentSunRise() {
    final getSunTime =
        (current?.sunrise ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunRise = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunRise = DateFormat('HH:mm a').format(setSunRise);
    return sunRise;
  }

  // текущее время заката

  String sunSet = '';

  String setCurrentSunSet() {
    final getSunTime =
        (current?.sunset ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunSet = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunSet = DateFormat('HH:mm a').format(setSunSet);
    return sunSet;
  }

  /// ********************************

  // добовление в избранное

  Future<void> setFavorite(BuildContext context, {String? cityName}) async {
    var box = Hive.box<FavoriteHistory>(HiveBoxes.favBox);

    box
        .add(
          FavoriteHistory(
              weatherData?.timezone ?? 'Error', currentBg ?? AppBg.shinyDay),
        )
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.black.withOpacity(0.3),
              content: Text(
                'Город $cityName добавлен в избранное',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
  }
  
  // удаление из избранных 
  Future<void> deleteFav(int index) async {
     var box = Hive.box<FavoriteHistory>(HiveBoxes.favBox);
     box.deleteAt(index);
  }
  
}

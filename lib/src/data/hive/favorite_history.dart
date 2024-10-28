import 'package:hive/hive.dart';

part 'favorite_history.g.dart';

@HiveType(typeId: 0)
class FavoriteHistory {
@HiveField(0)
 String cityName;

@HiveField(1)
 String bg;  
 
 FavoriteHistory(this.cityName, this.bg);
}
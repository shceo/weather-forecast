import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/exports.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<Box<FavoriteHistory>>(
          valueListenable:
              Hive.box<FavoriteHistory>(HiveBoxes.favBox).listenable(),
          builder: (context, value, _) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              itemBuilder: (context, i) {
                return FavoriteCard(
                  index: i,
                  value: value,
                );
              },
              separatorBuilder: (context, i) => const SizedBox(
                height: 10,
              ),
              itemCount: value.length,
            );
          }),
    );
  }
}

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.index, required this.value});
  final int index;
  final Box<FavoriteHistory> value;
  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(value.getAt(index)?.bg ?? AppBg.shinyDay),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value.getAt(index)?.cityName ?? 'Error',
            style: AppStyle.fontStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
          // Text(
          //   '${model.currentTemp} °C',
          //   style: AppStyle.fontStyle,         

          // ),
          IconButton(
            onPressed: () {
              model.deleteFav(index);
            },
            icon: Icon(
              Icons.delete,
              color: AppColors.redColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class WeekDayWidget extends StatelessWidget {
  const WeekDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.weekdayBgColor.withOpacity(0.5),
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 22, top: 20, bottom: 20),
        itemBuilder: (context, i) {
          return WeekDayItem(
            text: model.date[i],
            dailyIcon: model.SetDailyIcons(i),
            dayTemp: model.setDailyTemp(i),
            nightTemp: model.setNightTemp(i),
          );
        },
        separatorBuilder: (context, i) => const SizedBox(height: 16),
        itemCount: 7,
      ),
    );
  }
}

class WeekDayItem extends StatelessWidget {
  const WeekDayItem({
    super.key,
    required this.text,
    required this.dailyIcon,
    this.dayTemp = 0,
    this.nightTemp = 0,
  });

  final String text, dailyIcon;
  final int dayTemp, nightTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            text,
            style: AppStyle.fontStyle.copyWith(
              color: AppColors.darkBlue,
            ),
          ),
        ),
        //иконка в виде картинки
        Image.network(
          dailyIcon,
          width: 30,
          height: 30,
        ),

        //alt + 0176 = °
        Expanded(
          flex: 2,
          child: Text(
            '$dayTemp°C',
            textAlign: TextAlign.center,
            style: AppStyle.fontStyle,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '$nightTemp°C',
            textAlign: TextAlign.center,
            style: AppStyle.fontStyle.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}

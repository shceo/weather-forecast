import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/resources/app_icon.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class GridItems extends StatelessWidget {
  const GridItems({super.key});

  @override
  Widget build(BuildContext context) {
     final model = context.watch<WeatherProvider>();
    return SizedBox(
      height: 340,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            mainAxisExtent: 160,
          ),
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, i) {
            return SizedBox(
              width: 180,
              child: Card(
                margin: const EdgeInsets.all(0),
                elevation: 0,
                color: AppColors.weekdayBgColor.withOpacity(0.5),
                child: Center(
                  child: ListTile(
                    leading: SvgPicture.asset(
                      GreedIcons.gridIcons[i],
                      color: AppColors.darkBlue,
                    ),
                    title: Text(
                      '${model.setValues(i)} ${GridUnits.gridUnits[i]}',
                      style: AppStyle.fontStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    subtitle: Text(
                      GridDescription.gridDesc[i],
                      style: AppStyle.fontStyle.copyWith(
                        fontSize: 10,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class GreedIcons {
  static List<String> gridIcons = [
    AppIcon.speed,
    AppIcon.thermometer,
    AppIcon.raindrops,
    AppIcon.glasses,
  ];
}

class GridUnits {
  static List<String> gridUnits = [
    'км/ч',
    '°',
    '%',
    'км',
  ];
}

class GridDescription {
  static List<String> gridDesc = [
    'Скорость ветра',
    'Ощущается',
    'Влажность',
    'Видимость',
  ];
}

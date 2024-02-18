import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/resources/app_icon.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class MaxMinTemprature extends StatelessWidget {
  const MaxMinTemprature({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppIcon.arrowUp,
          color: AppColors.redColor,
        ),
        const SizedBox(width: 4),
        Text(
          '${model.setMaxTemp()}°',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 25,
            color: Colors.white
          ),
        ),
        const SizedBox(width: 65),
        SvgPicture.asset(
          AppIcon.arrowDown,
          color: AppColors.lightBlue,
        ),
        const SizedBox(width: 4),
        Text(
          '${model.setMinTemp()}°',
          style: AppStyle.fontStyle.copyWith(
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}

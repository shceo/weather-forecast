import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/resources/app_icon.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class SunRiseSunSetWidget extends StatelessWidget {
  const SunRiseSunSetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.weekdayBgColor.withOpacity(0.3),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RowItem(
            icon: AppIcon.sunrise,
            text: 'Восход ${model.setCurrentSunRise()}',
          ),
          RowItem(
            icon: AppIcon.sunset,
            text: 'Закат ${model.setCurrentSunSet()}',
          ),
        ],
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  const RowItem({
    super.key,
    required this.icon,
    required this.text,
  });

  final String icon, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          color: AppColors.darkBlue,
        ),
        const SizedBox(height: 18),
        Text(
          text,
          style: AppStyle.fontStyle.copyWith(
            fontSize: 16,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

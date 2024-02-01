import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class CurrentWeatherStatus extends StatelessWidget {
  const CurrentWeatherStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(model.iconData(), 
        // width: 52,
        // height: 52,
        ),
        const SizedBox(width: 25),
        Text(
          model.getCurrentStatus(),
          style: AppStyle.fontStyle.copyWith(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}

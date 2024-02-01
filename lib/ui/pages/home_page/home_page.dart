import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/provider/weather_provider.dart';
import 'package:weather_app/ui/components/current_weather_status.dart';
import 'package:weather_app/ui/components/grid_items.dart';
import 'package:weather_app/ui/components/max_min_temprature.dart';
import 'package:weather_app/ui/components/sunrise_sunset_widget.dart';
import 'package:weather_app/ui/components/weekday_widget.dart';
import 'package:weather_app/ui/routes/app_routes.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.watch<WeatherProvider>().setUp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const HomePageWidget();
          } else {
            return const Center(
              child: CupertinoActivityIndicator(
                radius: 50,
                color: Colors.red,
              ),
            );
          }
        });
  }
}

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: TextButton.icon(
      //     onPressed: () {},
      //     icon: Icon(
      //       Icons.location_on_rounded,
      //       color: AppColors.redColor,
      //     ),
      //     label: Text(
      //       'Ташкент',
      //       style: AppStyle.fontStyle,
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         context.go(AppRoutes.search);
      //       },
      //       icon: Icon(
      //         Icons.add,
      //         color: AppColors.darkBlue,
      //       ),
      //     ),
      //   ],
      //   bottom: const BottomAppBar(),
      // ),
      body: HomeBody(),
    );
  }
}

class BottomAppBar extends StatelessWidget {
  const BottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Padding(
      padding: const EdgeInsets.only(left: 90),
      child: Text(
        '${model.date.last} ${model.currentTime}',
        textAlign: TextAlign.center,
        style: AppStyle.fontStyle.copyWith(
          fontSize: 14,
        ),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherView = context.watch<WeatherProvider>();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            weatherView.setBg(),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Expanded(child: ListViewWidget(weatherView: weatherView)),
      ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Center(
        child: TextButton.icon(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 80),
          ),
          onPressed: () {
            model.setFavorite(context, cityName: model.weatherData?.timezone);
          },
          icon: Icon(
            Icons.location_on_rounded,
            color: AppColors.redColor,
          ),
          label: Text(
            '${model.weatherData?.timezone}',
            style: AppStyle.fontStyle,
          ),
        ),
      ),
      subtitle: const BottomAppBar(),
      trailing: IconButton(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(0),
          onPressed: () {
            context.go(AppRoutes.search);
          },
          icon: Icon(
            Icons.pageview_outlined,
            color: AppColors.darkBlue,
          )),
    );
  }
}

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({
    super.key,
    required this.weatherView,
  });

  final WeatherProvider weatherView;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const AppBarWidget(),

        const CurrentWeatherStatus(),
        const SizedBox(height: 10),
        //alt + 0176 = °
        Text(
          '${weatherView.currentTemp}℃',
          textAlign: TextAlign.center,
          style: AppStyle.fontStyle.copyWith(fontSize: 90),
        ),
        const SizedBox(height: 18),
        const MaxMinTemprature(),
        const SizedBox(height: 40),
        const WeekDayWidget(),
        const SizedBox(height: 27),
        const GridItems(),
        const SizedBox(height: 30),
        const SunRiseSunSetWidget(),
        const SizedBox(height: 30),
      ],
    );
  }
}























// Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             context.go(AppRoutes.search);
//           },
//           icon: const Icon(Icons.next_plan),
//         ),
//       ),
//     );
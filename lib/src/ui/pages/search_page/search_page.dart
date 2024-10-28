import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/src/exports.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<WeatherProvider>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.go(AppRoutes.home);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.darkBlue,
          ),
        ),
        title: SizedBox(
          height: 35,
          child: TextField(
            controller: model.cityController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                fillColor: AppColors.inputColor.withOpacity(0.4),
                filled: true,
                hintText: 'Введите город/регион',
                hintStyle: AppStyle.fontStyle.copyWith(
                  fontSize: 14,
                  color: AppColors.black.withOpacity(0.5),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5)),
            cursorColor: AppColors.darkBlue,
            cursorWidth: 3,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              model.setCurrentCity(context);
            },
            icon: Icon(
              Icons.search_rounded,
              color: AppColors.darkBlue,
            ),
          ),
        ],
      ),
      body: WeatherSearchBody(
        model: model,
      ),
    );
  }
}

class WeatherSearchBody extends StatelessWidget {
  const WeatherSearchBody({super.key, required this.model});
  final WeatherProvider model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            model.setBg(),
          ),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CurrentRegionItem(),
          const SizedBox(height: 25),
          Text(
            'Избранное',
            style: AppStyle.fontStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white.withOpacity(0.7)
            ),
          ),
          const SizedBox(height: 16),
          const FavoriteList(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/ui/routes/app_routes.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/theme/app_style.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            Icons.arrow_back_ios_new,
            color: AppColors.darkBlue,
          ),
        ),
        title: Text(
          'Error',
          style: AppStyle.fontStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: Text(
            'Error 404. Page Not Found',
            style: AppStyle.fontStyle.copyWith(
              color: Colors.brown[600],
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

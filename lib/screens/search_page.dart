import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_services.dart';

class SearchPage extends StatelessWidget {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: TextField(
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          onChanged: (data) {
            cityName = data;
          },
          onSubmitted: (data) async {
            cityName = data;
            BlocProvider.of<WeatherCubit>(context).getWeather(cityName: cityName!);
            BlocProvider.of<WeatherCubit>(context).cityName = cityName;
            print('Done');
            Navigator.pop(context);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            suffixIcon: GestureDetector(
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onTap: () async {
                BlocProvider.of<WeatherCubit>(context).getWeather(cityName: cityName!);
                Navigator.pop(context);
              },
            ),
            suffixIconColor: Colors.white,
            focusColor: Colors.white,
            hintText: 'Enter A City Name',
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            label: Text('Search'),
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

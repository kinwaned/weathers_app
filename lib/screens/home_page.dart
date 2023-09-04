import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/search_page.dart';

import '../Cubits/weather_cubit/weather_cubit.dart';

class HomePage extends StatelessWidget {
  WeatherModel? weatherData;

  void updateUi() {}

  @override
  Widget build(BuildContext context) {
    // weatherData = Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 30, left: 30),
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SearchPage(
                    );
                  }),
                );
              },
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherSuccess) {
          return SuccessScreen(weatherData: state.weatherModel);
        } else if (state is WeatherFailure) {
          return Text('Something went wrong, Please try again!');
        } else {
          return MainScreen();
        }
      }),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
            size: 58,
          ),
          Text(
            'There are no weather searches. ',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          Text('Search now!', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Weather',
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xff171717),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        BlocProvider.of<WeatherCubit>(context).cityName!,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    weatherData!.date,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(weatherData!.getImage(), width: 58),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            weatherData!.temp.toInt().toString() + '°',
                            style: TextStyle(
                              fontSize: 58,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            weatherData!.weatherState,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            weatherData!.minTemp.toInt().toString() +
                                '°' +
                                ' / ' +
                                weatherData!.maxTemp.toInt().toString() +
                                '°',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Feels like ' +
                                weatherData!.temp.toInt().toString() +
                                '°',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xff171717)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yesterday',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            color: Colors.cyanAccent,
                          ),
                          Text(
                            weatherData!.avghumidity.toInt().toString() + '%',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.nights_stay,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      Text(
                        weatherData!.minTemp.toInt().toString() +
                            '°' +
                            ' / ' +
                            weatherData!.maxTemp.toInt().toString() +
                            '°',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Monday',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            color: Colors.cyanAccent,
                          ),
                          Text(
                            '0%',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.nights_stay,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      Text(
                        '28°/ 15°',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tuesday',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            color: Colors.cyanAccent,
                          ),
                          Text(
                            '0%',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.nights_stay,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      Text(
                        '28°/ 15°',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wednesday',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            color: Colors.cyanAccent,
                          ),
                          Text(
                            '0%',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.nights_stay,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      Text(
                        '28°/ 15°',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thursday',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            color: Colors.cyanAccent,
                          ),
                          Text(
                            '0%',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.nights_stay,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      Text(
                        '28°/ 15°',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Friday',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            color: Colors.cyanAccent,
                          ),
                          Text(
                            '0%',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Icon(
                            Icons.nights_stay,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      Text(
                        '28°/ 15°',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

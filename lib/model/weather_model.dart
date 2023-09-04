class WeatherModel {
  String date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherState;
  double avghumidity;

  WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherState,required this.avghumidity, });

  factory WeatherModel.fromJason(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];
    var jsonData1 = data['forecast']['forecastday'][0]['hour'];
    print('$jsonData');
    return WeatherModel(
        date: data['location']['localtime'],
        temp: jsonData['avgtemp_c'],
        maxTemp: jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c'],
        avghumidity: jsonData['avghumidity'],
        weatherState: jsonData['condition']['text']);
  }

 String getImage(){
  if (weatherState == 'Clear' || weatherState == 'Light cloud'){
    return 'assets/images/clear.png';
  } else if (weatherState == 'Sleet' || weatherState == 'Snow' || weatherState == 'Hail' ){
    return 'assets/images/snowy.png';
  } else if (weatherState == 'Heavy cloud' || weatherState == 'Fog' || weatherState == 'Mist'){
    return 'assets/images/cloudy.png';
  }else if(weatherState == 'Light rain' || weatherState == 'Heavy rain' || weatherState == 'Patchy rain possible'){
    return 'assets/images/rainy.png';
  }else if(weatherState == 'Thunderstorm' || weatherState == 'Thunder'){
    return 'assets/images/thunderstorm.png';
  }else {
    return 'assets/images/clear.png';
  }
  }
}

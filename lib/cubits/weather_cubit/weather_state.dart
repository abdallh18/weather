import 'package:weather/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccsess extends WeatherState {
  WeatherModel weatherModel;
  WeatherSuccsess({required this.weatherModel});
}

class WeatherFaillure extends WeatherState {}

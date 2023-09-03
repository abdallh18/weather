import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/providers/weather_provider.dart';
import 'package:weather/services/weather_servicse.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search a city'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (data) {
              cityName = data;
            },
            onSubmitted: (data) async {
              cityName = data;
              BlocProvider.of<WeatherCubit>(context)
                  .getWeather(cityName: cityName!);
              BlocProvider.of<WeatherCubit>(context).cityName = cityName;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
              label: const Text(
                'search',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              suffixIcon: GestureDetector(
                  onTap: () async {
                    WeatherService service = WeatherService();
                    WeatherModel? weather =
                        await service.getWeather(cityName: cityName!);
                    // ignore: use_build_context_synchronously
                    Provider.of<WeatherProvider>(context, listen: false)
                        .weatherData = weather;
                    // ignore: use_build_context_synchronously
                    Provider.of<WeatherProvider>(context, listen: false)
                        .cityName = cityName;
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.search)),
              hintText: 'Enter The city',
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}

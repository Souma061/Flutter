import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/hourly_forecast_class.dart';
import 'package:weather_app/info_card.dart';
import 'package:weather_app/model/hourly_weather_model.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherModel? weatherData;
  List<HourlyWeather> hourlyData = [];
  IconData? weatherIcon;

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  // Apicall
  Future<void> fetchWeatherData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final apiKey = dotenv.env['OPEN_WEATHER_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      setState(() {
        isLoading = false;
        errorMessage = 'API key not found';
      });
      debugPrint('API key missing');
      return;
    }

    const city = 'Howrah';

    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          weatherData = WeatherModel.fromForecastJson(data['list'][0]);

          weatherIcon = weatherData!.condition == 'Clear'
              ? Icons.wb_sunny
              : weatherData!.condition == 'Clouds'
              ? Icons.cloud
              : Icons.nights_stay;

          // Parse hourly forecast data
          hourlyData = [];
          for (int i = 0; i < (data['list'] as List).length && i < 6; i++) {
            final forecast = data['list'][i];
            final dateTime = DateTime.parse(forecast['dt_txt']);
            final formattedTime =
                '${dateTime.hour.toString().padLeft(2, '0')}:00';
            final temp = forecast['main']['temp'].toDouble();
            final condition = forecast['weather'][0]['main'];

            final icon = condition == 'Clear'
                ? Icons.wb_sunny
                : condition == 'Clouds'
                ? Icons.cloud
                : condition == 'Rain'
                ? Icons.grain
                : Icons.nights_stay;

            hourlyData.add(
              HourlyWeather(time: formattedTime, temperature: temp, icon: icon),
            );
          }

          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Error: ${response.statusCode} - ${response.body}';
        });
        debugPrint('API Error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: $e';
      });
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: fetchWeatherData,
            icon: Icon(Icons.refresh),
          ), //instead of actionbutton we can also use GestureDetector or InkWell widget
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 30,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  '${weatherData!.temperature.toStringAsFixed(1)}°C',
                                  style: const TextStyle(fontSize: 32),
                                ),
                                const SizedBox(height: 16),
                                Icon(weatherIcon ?? Icons.cloud, size: 64),
                                const SizedBox(height: 16),
                                Text(
                                  weatherData!.condition,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ), // Main Weather Display
                const SizedBox(height: 20),
                const Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: hourlyData.isEmpty
                          ? [
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('No hourly data available'),
                              ),
                            ]
                          : hourlyData
                                .map(
                                  (hourly) => HourlyForecastClass(
                                    time: hourly.time,
                                    icon: hourly.icon,
                                    temperature:
                                        '${hourly.temperature.toStringAsFixed(1)}°C',
                                  ),
                                )
                                .toList(),
                    ),
                  ),
                ),

                // Hourly Forecast(Widget Cards)
                const SizedBox(height: 20),
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Add your additional information widgets here
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: InfoCard(
                                  title: 'Humidity',
                                  icon: Icons.water_drop,
                                  value: '${weatherData?.humidity ?? 0}%',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: InfoCard(
                                  title: 'Wind Speed',
                                  icon: Icons.air,
                                  value:
                                      '${(weatherData?.windSpeed ?? 0).toStringAsFixed(1)} km/h',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: InfoCard(
                                  title: 'Pressure',
                                  icon: Icons.speed,
                                  value: '${weatherData?.pressure ?? 0} hPa',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // const Placeholder(fallbackHeight: 150), // Addditional Info
              ],
            ),
    );
  }
}

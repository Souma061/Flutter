class WeatherModel {
  final double temperature;

  final String condition;
  final int humidity;
  final double windSpeed;
  final int pressure;

  WeatherModel({
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'],
    );
  }

  factory WeatherModel.fromForecastJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'],
    );
  }
}

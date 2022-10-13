class Weather {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  int? pressure;
  Weather({
    this.cityName,
    this.temp,
    this.wind,
    this.humidity,
    this.pressure,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    print(cityName);
    temp = json["main"]["temp"];
    humidity = json["main"]["humidity"];
    wind = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
    print(wind);
  }
}

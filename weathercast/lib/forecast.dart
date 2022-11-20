import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import 'location.dart';
import 'weather.dart';

Future<Weather> forecast() async {
  const url = 'https://data.tmd.go.th/nwpapi/v1/forecast/location/hourly/at';
  const token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZjODY4ZjJiMTMxNDc3YzA2ZDQyYTAzNmQwZTNkZDdlMjc1NzU0YzM1MmE2NDRkZjE0ZWUyYjRiZTViZDMyZmJmNzExYzgwMmEwNDc1NzRhIn0.eyJhdWQiOiIyIiwianRpIjoiNmM4NjhmMmIxMzE0NzdjMDZkNDJhMDM2ZDBlM2RkN2UyNzU3NTRjMzUyYTY0NGRmMTRlZTJiNGJlNWJkMzJmYmY3MTFjODAyYTA0NzU3NGEiLCJpYXQiOjE2Njg5MzM1MDcsIm5iZiI6MTY2ODkzMzUwNywiZXhwIjoxNzAwNDY5NTA3LCJzdWIiOiIxNDI5Iiwic2NvcGVzIjpbXX0.tyGkPRb5GGieVWoC0HWpc0rXF1KXbM7rFda4hoEGHGHNhj63_cGd-GsgxhLQtL1KwNWcoCPGybkXS545LP4HryVh7AOeRDX2bTSuFTQrK8qFLdH8YlGq9Ygawzt0YnnWVUGQs93Ol9RikHyaSpOcxB1DeHwc5k4sNh9miB2sz5OKuOh6qlbUyIwhN6scXrCpRPNEaNDvZ3y7JjnEYtn4BHcoIrQhmTjXoPsZqyT6P66_uU0voc9GM57ABuFc8CMMt3wJ6jSg483U3nBUFh9BJNBHM-mlSRZP6Spk_8F2E_RCap9yU6HKJgs-P2wJirIXzubJIcu1oCFCkSptPQ3WsrEO5eU5qsv5en-8ERby1pA5gWu41_EmJSmsWni7HRbpu_E7pCoSe2fJv11JX88J7Mir9bRpurWKPE10tH3aUcIellNGx5rhAkSQC9PQVmvCyuhjaIeprmcxQtL66dOfaWHoe1bzSEmMBOrP971dPSEK3P8qG8BGxTwyWYm8RzQZDNZsGmWtgRJDz8THSwPnxcHSTnffBmyeEDiwolJNqPSKo1WJO6am9s-hVdXrA3O0jGDwyCYRIZHS-EAwJFaMXxiK8AX1SMgJbD3v5LcZaokzbQQNb7ZTuUa0I3H1nErzTgebg7qk-vZsGVbTb-zXO3tzgFOMPSX7EYsBmyT6NoI';

  try {
    Position location = await getCurrentLocation();
    http.Response response = await http.get(
      Uri.parse('$url?lat=${location.latitude}&lon=${location.longitude}&fields=tc,cond'), 
      headers: {
        'accept': 'application/json',
        'authorization': 'Bearer $token',
      }
    );
    if(response.statusCode == 200) {
      var result = jsonDecode(response.body)['WeatherForecasts'][0]['forecasts'][0]['data'];
      Placemark address = (await placemarkFromCoordinates(location.latitude, location.longitude)).first;
      return Weather(
        address: '${address.subLocality}\n${address.administrativeArea}',
        temperature: result['tc'],
        cond: result['cond'],
      );
    } else {
      return Future.error(response.statusCode);
    }
  } catch (e) {
    return Future.error(e);
  }
}
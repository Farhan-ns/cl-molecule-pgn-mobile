import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  // final String _url = '192.168.43.138:8000';
  final String _url = 'musdaxviihipmijabar.cyberlabs.co.id';
  // final String _url = '192.168.1.35:8000';

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    return jsonDecode(localStorage.getString('token') ?? '');
  }

  Future<http.Response> authData(Map data, String apiUrl) async {
    Uri url = Uri.https(_url, apiUrl);
    print(url);

    return await http.post(
      url,
      body: data,
      headers: await _setHeadersWithoutAuth(),
    );
  }

  Future<http.Response> getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(),
    );
  }

  Future<http.Response> postData(data, apiUrl) async {
    Uri url = Uri.https(_url, apiUrl);
    print(url);

    return await http.post(
      url,
      headers: await _setHeaders(),
      body: data,
    );
  }

  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.clear();
  }

  _setHeaders() async => {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
        // ignore: prefer_interpolation_to_compose_strings
        'Authorization': 'Bearer ' + await _getToken(),
      };

  _setHeadersWithoutAuth() async => {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
}

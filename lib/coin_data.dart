import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

// const String url =
//     "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=C1E7F10E-E665-4287-8F6A-1BBC8F0469C2";

const coinUrl = 'https://rest.coinapi.io/v1/exchangerate';
// const apiKey = 'C1E7F10E-E665-4287-8F6A-1BBC8F0469C2';
const apiKey = '65BBFE46-44C1-4976-81BE-361E95591187';

class CoinData {
  Future getCoinData({String slectedCurrency, String type}) async {
    String requestUrl = '$coinUrl/$type/$slectedCurrency?apikey=$apiKey';

    http.Response response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
      throw 'Problem with get request';
    }
  }
}

// // const String url =
// //     "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=C1E7F10E-E665-4287-8F6A-1BBC8F0469C2";

// import 'package:bitcoin_ticker/coin_data.dart';

// const coinUrl = 'https://rest.coinapi.io/v1/exchangerate/BTC/';
// const apiKey = 'C1E7F10E-E665-4287-8F6A-1BBC8F0469C2';

// class CoinModal {
//   Future<dynamic> getData(String currency) async {
//     String url = '$coinUrl/$currency?apikey=$apiKey';

//     CoinData coinData = CoinData(url: url);

//     var currencyData = await coinData.getCoinData();

//     return currencyData;
//   }
// }

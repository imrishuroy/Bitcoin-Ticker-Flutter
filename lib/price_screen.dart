import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

const String url =
    "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=C1E7F10E-E665-4287-8F6A-1BBC8F0469C2";

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  // double rateInUsd;

  String bitCoinValueInUsd = '?';

  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItem = [];

    for (String currency in currenciesList) {
      // print(currenciesList[i]);
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItem.add(newItem);
    }
    return dropDownItem;
  }

  List<Text> getCupertinoPickeItems() {
    List<Text> cupertinoItems = [];

    for (String currency in currenciesList) {
      var newItem = Text(currency);
      cupertinoItems.add(newItem);
    }
    return cupertinoItems;
  }

  @override
  void initState() {
    // getData();
    coinData();
    super.initState();
  }

  // Future getData() async {
  //   http.Response response = await http.get(url);
  //   // print(response.body);
  //   var decodeddata = await jsonDecode(response.body);
  //   // print(decodeddata['time']);

  //   rateInUsd = decodeddata['rate'];

  //   return decodeddata;
  // }

  void coinData() async {
    double rate;
    CoinData coinData = CoinData();
    try {
      var reqdata = await coinData.getCoinData();
      setState(() {
        rate = reqdata['rate'];
        bitCoinValueInUsd = rate.toStringAsFixed(2);
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // getDropDownItems();
    // print(rateInUsd);
    // print(getData());

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  // '1 BTC = ${rateInUsd.toStringAsFixed(2)} USD',
                  '1 BTC = $bitCoinValueInUsd USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? CupertinoPicker(
                    itemExtent: 32.0,
                    onSelectedItemChanged: (value) {
                      print(value);
                    },
                    children: getCupertinoPickeItems(),
                  )
                : DropdownButton(
                    value: selectedCurrency,
                    items: getDropDownItems(),
                    onChanged: (value) {
                      setState(
                        () {
                          print(value);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

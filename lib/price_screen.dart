import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItem = [];

    for (String currency in currenciesList) {
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
    // coinData();
    // coinData2();
    getLTCData();
    super.initState();
  }

  String bitCoinValue = '?';
  String bitCoinValue1 = '?';
  String bitCoinValue2 = '?';

  void coinData() async {
    double rate;
    CoinData coinData = CoinData();
    try {
      var reqdata = await coinData.getCoinData(
          slectedCurrency: selectedCurrency, type: 'BTC');
      setState(() {
        rate = reqdata['rate'];
        bitCoinValue1 = rate.toStringAsFixed(0);
      });
    } catch (error) {
      print(error);
    }
  }

  void coinData2() async {
    double rate;
    CoinData coinData = CoinData();
    try {
      var reqdata = await coinData.getCoinData(
          slectedCurrency: selectedCurrency, type: 'ETH');
      setState(() {
        rate = reqdata['rate'];
        bitCoinValue2 = rate.toStringAsFixed(0);
      });
    } catch (error) {
      print(error);
    }
  }

  void getLTCData() async {
    double rate;
    CoinData coinData = CoinData();
    try {
      for (String i in cryptoList) {
        var reqdata = await coinData.getCoinData(
            slectedCurrency: selectedCurrency, type: i);
        setState(() {
          rate = reqdata['rate'];
          bitCoinValue = rate.toStringAsFixed(0);
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: [
                  CoinCard(
                      cryptoName: 'BTC',
                      bitCoinValue: bitCoinValue,
                      selectedCurrency: selectedCurrency),
                  CoinCard(
                      cryptoName: 'ETH',
                      bitCoinValue: bitCoinValue1,
                      selectedCurrency: selectedCurrency),
                  CoinCard(
                      cryptoName: 'LTC',
                      bitCoinValue: bitCoinValue2,
                      selectedCurrency: selectedCurrency),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS
                  ? CupertinoPicker(
                      itemExtent: 32.0,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedCurrency = currenciesList[index];
                          coinData();
                          coinData2();
                          getLTCData();
                        });
                        // print(value);
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
                            selectedCurrency = value;
                            coinData();
                            coinData2();
                            getLTCData();
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  final String cryptoName;
  final String bitCoinValue;
  final String selectedCurrency;

  CoinCard({this.cryptoName, this.bitCoinValue, this.selectedCurrency});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(18, 10, 10, 18),
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
              '1 $cryptoName = $bitCoinValue $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

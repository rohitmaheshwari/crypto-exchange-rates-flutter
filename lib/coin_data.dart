import 'dart:collection';
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
  'PKR',
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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
// const apiKey = '28BC7265-7285-4693-A016-0B0BC0A90B7E';
const apiKey = '83E46FAA-C5A8-4F70-902E-BB00BE6BD506';

class CoinData {
  final String currency;

  CoinData({this.currency});

  Future<Map> getCoinData() async {
    /// Map and LinkedHashMap uses FIFO structure and are both same
    LinkedHashMap<String, String> exchangeRatesMap = LinkedHashMap();
    String uri;
    var decodedData, lastPrice;
    for (String crypto in cryptoList) {
      uri = '$coinAPIURL/$crypto/$currency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        decodedData = jsonDecode(response.body);
        lastPrice = decodedData['rate'];
        lastPrice = lastPrice.toStringAsFixed(0);
        exchangeRatesMap.putIfAbsent(crypto, () => lastPrice);
      } else {
        print(response.statusCode);

        throw ("Problem with the get request");
      }
    }
    return exchangeRatesMap;
  }
}

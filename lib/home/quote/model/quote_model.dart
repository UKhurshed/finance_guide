import 'dart:convert';

Quote quoteFromJson(String str) => Quote.fromJson(json.decode(str));

class Quote {
  String symbol;
  String companyName;
  String primaryExchange;
  String calculationPrice;
  double open;
  dynamic openTime;
  String openSource;
  double close;
  dynamic closeTime;
  String closeSource;
  double high;
  dynamic highTime;
  String highSource;
  double low;
  dynamic lowTime;
  String lowSource;
  double latestPrice;
  String latestSource;
  String latestTime;
  dynamic latestUpdate;
  dynamic latestVolume;
  double delayedPrice;
  dynamic delayedPriceTime;
  double oddLotDelayedPrice;
  dynamic oddLotDelayedPriceTime;
  double extendedPrice;
  double extendedChange;
  double extendedChangePercent;
  dynamic extendedPriceTime;
  double previousClose;
  dynamic previousVolume;
  double change;
  double changePercent;
  dynamic volume;
  dynamic avgTotalVolume;
  double iexClose;
  dynamic iexCloseTime;
  dynamic marketCap;
  double peRatio;
  double week52High;
  double week52Low;
  double ytdChange;
  dynamic lastTradeTime;
  bool isUSMarketOpen;

  Quote(
      {this.symbol,
        this.companyName,
        this.primaryExchange,
        this.calculationPrice,
        this.open,
        this.openTime,
        this.openSource,
        this.close,
        this.closeTime,
        this.closeSource,
        this.high,
        this.highTime,
        this.highSource,
        this.low,
        this.lowTime,
        this.lowSource,
        this.latestPrice,
        this.latestSource,
        this.latestTime,
        this.latestUpdate,
        this.latestVolume,
        this.delayedPrice,
        this.delayedPriceTime,
        this.oddLotDelayedPrice,
        this.oddLotDelayedPriceTime,
        this.extendedPrice,
        this.extendedChange,
        this.extendedChangePercent,
        this.extendedPriceTime,
        this.previousClose,
        this.previousVolume,
        this.change,
        this.changePercent,
        this.volume,
        this.avgTotalVolume,
        this.iexClose,
        this.iexCloseTime,
        this.marketCap,
        this.peRatio,
        this.week52High,
        this.week52Low,
        this.ytdChange,
        this.lastTradeTime,
        this.isUSMarketOpen});

  Quote.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    companyName = json['companyName'];
    primaryExchange = json['primaryExchange'];
    calculationPrice = json['calculationPrice'];
    open = json['open'];
    openTime = json['openTime'];
    openSource = json['openSource'];
    close = json['close'];
    closeTime = json['closeTime'];
    closeSource = json['closeSource'];
    high = json['high'];
    highTime = json['highTime'];
    highSource = json['highSource'];
    low = json['low'];
    lowTime = json['lowTime'];
    lowSource = json['lowSource'];
    latestPrice = json['latestPrice'];
    latestSource = json['latestSource'];
    latestTime = json['latestTime'];
    latestUpdate = json['latestUpdate'];
    latestVolume = json['latestVolume'];
    delayedPrice = json['delayedPrice'];
    delayedPriceTime = json['delayedPriceTime'];
    oddLotDelayedPrice = json['oddLotDelayedPrice'];
    oddLotDelayedPriceTime = json['oddLotDelayedPriceTime'];
    extendedPrice = json['extendedPrice'];
    extendedChange = json['extendedChange'];
    extendedChangePercent = json['extendedChangePercent'];
    extendedPriceTime = json['extendedPriceTime'];
    previousClose = json['previousClose'];
    previousVolume = json['previousVolume'];
    change = json['change'];
    changePercent = json['changePercent'];
    volume = json['volume'];
    avgTotalVolume = json['avgTotalVolume'];
    iexClose = json['iexClose'];
    iexCloseTime = json['iexCloseTime'];
    marketCap = json['marketCap'];
    peRatio = json['peRatio'];
    week52High = json['week52High'];
    week52Low = json['week52Low'];
    ytdChange = json['ytdChange'];
    lastTradeTime = json['lastTradeTime'];
    isUSMarketOpen = json['isUSMarketOpen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['companyName'] = this.companyName;
    data['primaryExchange'] = this.primaryExchange;
    data['calculationPrice'] = this.calculationPrice;
    data['open'] = this.open;
    data['openTime'] = this.openTime;
    data['openSource'] = this.openSource;
    data['close'] = this.close;
    data['closeTime'] = this.closeTime;
    data['closeSource'] = this.closeSource;
    data['high'] = this.high;
    data['highTime'] = this.highTime;
    data['highSource'] = this.highSource;
    data['low'] = this.low;
    data['lowTime'] = this.lowTime;
    data['lowSource'] = this.lowSource;
    data['latestPrice'] = this.latestPrice;
    data['latestSource'] = this.latestSource;
    data['latestTime'] = this.latestTime;
    data['latestUpdate'] = this.latestUpdate;
    data['latestVolume'] = this.latestVolume;
    data['delayedPrice'] = this.delayedPrice;
    data['delayedPriceTime'] = this.delayedPriceTime;
    data['oddLotDelayedPrice'] = this.oddLotDelayedPrice;
    data['oddLotDelayedPriceTime'] = this.oddLotDelayedPriceTime;
    data['extendedPrice'] = this.extendedPrice;
    data['extendedChange'] = this.extendedChange;
    data['extendedChangePercent'] = this.extendedChangePercent;
    data['extendedPriceTime'] = this.extendedPriceTime;
    data['previousClose'] = this.previousClose;
    data['previousVolume'] = this.previousVolume;
    data['change'] = this.change;
    data['changePercent'] = this.changePercent;
    data['volume'] = this.volume;
    data['avgTotalVolume'] = this.avgTotalVolume;
    data['iexClose'] = this.iexClose;
    data['iexCloseTime'] = this.iexCloseTime;
    data['marketCap'] = this.marketCap;
    data['peRatio'] = this.peRatio;
    data['week52High'] = this.week52High;
    data['week52Low'] = this.week52Low;
    data['ytdChange'] = this.ytdChange;
    data['lastTradeTime'] = this.lastTradeTime;
    data['isUSMarketOpen'] = this.isUSMarketOpen;
    return data;
  }
}

// import 'dart:convert';
//
// Quote quoteFromJson(String str) => Quote.fromJson(json.decode(str));
//
// String quoteToJson(Quote data) => json.encode(data.toJson());
//
// class Quote {
//   Quote({
//     this.symbol,
//     this.companyName,
//     this.primaryExchange,
//     this.calculationPrice,
//     this.open,
//     this.openTime,
//     this.openSource,
//     this.close,
//     this.closeTime,
//     this.closeSource,
//     this.high,
//     this.highTime,
//     this.highSource,
//     this.low,
//     this.lowTime,
//     this.lowSource,
//     this.latestPrice,
//     this.latestSource,
//     this.latestTime,
//     this.latestUpdate,
//     this.latestVolume,
//     this.iexRealtimePrice,
//     this.iexRealtimeSize,
//     this.iexLastUpdated,
//     this.delayedPrice,
//     this.delayedPriceTime,
//     this.oddLotDelayedPrice,
//     this.oddLotDelayedPriceTime,
//     this.extendedPrice,
//     this.extendedChange,
//     this.extendedChangePercent,
//     this.extendedPriceTime,
//     this.previousClose,
//     this.previousVolume,
//     this.change,
//     this.changePercent,
//     this.volume,
//     this.iexMarketPercent,
//     this.iexVolume,
//     this.avgTotalVolume,
//     this.iexBidPrice,
//     this.iexBidSize,
//     this.iexAskPrice,
//     this.iexAskSize,
//     this.iexOpen,
//     this.iexOpenTime,
//     this.iexClose,
//     this.iexCloseTime,
//     this.marketCap,
//     this.peRatio,
//     this.week52High,
//     this.week52Low,
//     this.ytdChange,
//     this.lastTradeTime,
//     this.isUsMarketOpen,
//   });
//
//   String symbol;
//   String companyName;
//   String primaryExchange;
//   String calculationPrice;
//   dynamic open;
//   dynamic openTime;
//   String openSource;
//   dynamic close;
//   dynamic closeTime;
//   String closeSource;
//   dynamic high;
//   int highTime;
//   String highSource;
//   dynamic low;
//   int lowTime;
//   String lowSource;
//   double latestPrice;
//   String latestSource;
//   String latestTime;
//   int latestUpdate;
//   dynamic latestVolume;
//   double iexRealtimePrice;
//   int iexRealtimeSize;
//   int iexLastUpdated;
//   dynamic delayedPrice;
//   dynamic delayedPriceTime;
//   dynamic oddLotDelayedPrice;
//   dynamic oddLotDelayedPriceTime;
//   dynamic extendedPrice;
//   dynamic extendedChange;
//   dynamic extendedChangePercent;
//   dynamic extendedPriceTime;
//   double previousClose;
//   int previousVolume;
//   double change;
//   double changePercent;
//   dynamic volume;
//   double iexMarketPercent;
//   int iexVolume;
//   int avgTotalVolume;
//   int iexBidPrice;
//   int iexBidSize;
//   int iexAskPrice;
//   int iexAskSize;
//   dynamic iexOpen;
//   dynamic iexOpenTime;
//   double iexClose;
//   int iexCloseTime;
//   int marketCap;
//   double peRatio;
//   double week52High;
//   double week52Low;
//   double ytdChange;
//   int lastTradeTime;
//   bool isUsMarketOpen;
//
//   factory Quote.fromJson(Map<String, dynamic> json) => Quote(
//     symbol: json["symbol"],
//     companyName: json["companyName"],
//     primaryExchange: json["primaryExchange"],
//     calculationPrice: json["calculationPrice"],
//     open: json["open"],
//     openTime: json["openTime"],
//     openSource: json["openSource"],
//     close: json["close"],
//     closeTime: json["closeTime"],
//     closeSource: json["closeSource"],
//     high: json["high"],
//     highTime: json["highTime"],
//     highSource: json["highSource"],
//     low: json["low"],
//     lowTime: json["lowTime"],
//     lowSource: json["lowSource"],
//     latestPrice: json["latestPrice"].toDouble(),
//     latestSource: json["latestSource"],
//     latestTime: json["latestTime"],
//     latestUpdate: json["latestUpdate"],
//     latestVolume: json["latestVolume"],
//     iexRealtimePrice: json["iexRealtimePrice"].toDouble(),
//     iexRealtimeSize: json["iexRealtimeSize"],
//     iexLastUpdated: json["iexLastUpdated"],
//     delayedPrice: json["delayedPrice"],
//     delayedPriceTime: json["delayedPriceTime"],
//     oddLotDelayedPrice: json["oddLotDelayedPrice"],
//     oddLotDelayedPriceTime: json["oddLotDelayedPriceTime"],
//     extendedPrice: json["extendedPrice"],
//     extendedChange: json["extendedChange"],
//     extendedChangePercent: json["extendedChangePercent"],
//     extendedPriceTime: json["extendedPriceTime"],
//     previousClose: json["previousClose"].toDouble(),
//     previousVolume: json["previousVolume"],
//     change: json["change"].toDouble(),
//     changePercent: json["changePercent"].toDouble(),
//     volume: json["volume"],
//     iexMarketPercent: json["iexMarketPercent"].toDouble(),
//     iexVolume: json["iexVolume"],
//     avgTotalVolume: json["avgTotalVolume"],
//     iexBidPrice: json["iexBidPrice"],
//     iexBidSize: json["iexBidSize"],
//     iexAskPrice: json["iexAskPrice"],
//     iexAskSize: json["iexAskSize"],
//     iexOpen: json["iexOpen"],
//     iexOpenTime: json["iexOpenTime"],
//     iexClose: json["iexClose"].toDouble(),
//     iexCloseTime: json["iexCloseTime"],
//     marketCap: json["marketCap"],
//     peRatio: json["peRatio"].toDouble(),
//     week52High: json["week52High"].toDouble(),
//     week52Low: json["week52Low"].toDouble(),
//     ytdChange: json["ytdChange"].toDouble(),
//     lastTradeTime: json["lastTradeTime"],
//     isUsMarketOpen: json["isUSMarketOpen"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "symbol": symbol,
//     "companyName": companyName,
//     "primaryExchange": primaryExchange,
//     "calculationPrice": calculationPrice,
//     "open": open,
//     "openTime": openTime,
//     "openSource": openSource,
//     "close": close,
//     "closeTime": closeTime,
//     "closeSource": closeSource,
//     "high": high,
//     "highTime": highTime,
//     "highSource": highSource,
//     "low": low,
//     "lowTime": lowTime,
//     "lowSource": lowSource,
//     "latestPrice": latestPrice,
//     "latestSource": latestSource,
//     "latestTime": latestTime,
//     "latestUpdate": latestUpdate,
//     "latestVolume": latestVolume,
//     "iexRealtimePrice": iexRealtimePrice,
//     "iexRealtimeSize": iexRealtimeSize,
//     "iexLastUpdated": iexLastUpdated,
//     "delayedPrice": delayedPrice,
//     "delayedPriceTime": delayedPriceTime,
//     "oddLotDelayedPrice": oddLotDelayedPrice,
//     "oddLotDelayedPriceTime": oddLotDelayedPriceTime,
//     "extendedPrice": extendedPrice,
//     "extendedChange": extendedChange,
//     "extendedChangePercent": extendedChangePercent,
//     "extendedPriceTime": extendedPriceTime,
//     "previousClose": previousClose,
//     "previousVolume": previousVolume,
//     "change": change,
//     "changePercent": changePercent,
//     "volume": volume,
//     "iexMarketPercent": iexMarketPercent,
//     "iexVolume": iexVolume,
//     "avgTotalVolume": avgTotalVolume,
//     "iexBidPrice": iexBidPrice,
//     "iexBidSize": iexBidSize,
//     "iexAskPrice": iexAskPrice,
//     "iexAskSize": iexAskSize,
//     "iexOpen": iexOpen,
//     "iexOpenTime": iexOpenTime,
//     "iexClose": iexClose,
//     "iexCloseTime": iexCloseTime,
//     "marketCap": marketCap,
//     "peRatio": peRatio,
//     "week52High": week52High,
//     "week52Low": week52Low,
//     "ytdChange": ytdChange,
//     "lastTradeTime": lastTradeTime,
//     "isUSMarketOpen": isUsMarketOpen,
//   };
// }
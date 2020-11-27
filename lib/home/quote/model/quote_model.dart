import 'dart:convert';

Quote quoteFromJson(String str) => Quote.fromJson(json.decode(str));

String quoteToJson(Quote data) => json.encode(data.toJson());

class Quote {
  Quote({
    this.symbol,
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
    this.iexRealtimePrice,
    this.iexRealtimeSize,
    this.iexLastUpdated,
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
    this.iexMarketPercent,
    this.iexVolume,
    this.avgTotalVolume,
    this.iexBidPrice,
    this.iexBidSize,
    this.iexAskPrice,
    this.iexAskSize,
    this.iexOpen,
    this.iexOpenTime,
    this.iexClose,
    this.iexCloseTime,
    this.marketCap,
    this.peRatio,
    this.week52High,
    this.week52Low,
    this.ytdChange,
    this.lastTradeTime,
    this.isUsMarketOpen,
  });

  String symbol;
  String companyName;
  String primaryExchange;
  String calculationPrice;
  dynamic open;
  dynamic openTime;
  String openSource;
  dynamic close;
  dynamic closeTime;
  String closeSource;
  dynamic high;
  int highTime;
  String highSource;
  dynamic low;
  int lowTime;
  String lowSource;
  double latestPrice;
  String latestSource;
  String latestTime;
  int latestUpdate;
  dynamic latestVolume;
  double iexRealtimePrice;
  int iexRealtimeSize;
  int iexLastUpdated;
  dynamic delayedPrice;
  dynamic delayedPriceTime;
  dynamic oddLotDelayedPrice;
  dynamic oddLotDelayedPriceTime;
  dynamic extendedPrice;
  dynamic extendedChange;
  dynamic extendedChangePercent;
  dynamic extendedPriceTime;
  double previousClose;
  int previousVolume;
  double change;
  double changePercent;
  dynamic volume;
  double iexMarketPercent;
  int iexVolume;
  int avgTotalVolume;
  int iexBidPrice;
  int iexBidSize;
  int iexAskPrice;
  int iexAskSize;
  dynamic iexOpen;
  dynamic iexOpenTime;
  double iexClose;
  int iexCloseTime;
  int marketCap;
  double peRatio;
  double week52High;
  double week52Low;
  double ytdChange;
  int lastTradeTime;
  bool isUsMarketOpen;

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    symbol: json["symbol"],
    companyName: json["companyName"],
    primaryExchange: json["primaryExchange"],
    calculationPrice: json["calculationPrice"],
    open: json["open"],
    openTime: json["openTime"],
    openSource: json["openSource"],
    close: json["close"],
    closeTime: json["closeTime"],
    closeSource: json["closeSource"],
    high: json["high"],
    highTime: json["highTime"],
    highSource: json["highSource"],
    low: json["low"],
    lowTime: json["lowTime"],
    lowSource: json["lowSource"],
    latestPrice: json["latestPrice"].toDouble(),
    latestSource: json["latestSource"],
    latestTime: json["latestTime"],
    latestUpdate: json["latestUpdate"],
    latestVolume: json["latestVolume"],
    iexRealtimePrice: json["iexRealtimePrice"].toDouble(),
    iexRealtimeSize: json["iexRealtimeSize"],
    iexLastUpdated: json["iexLastUpdated"],
    delayedPrice: json["delayedPrice"],
    delayedPriceTime: json["delayedPriceTime"],
    oddLotDelayedPrice: json["oddLotDelayedPrice"],
    oddLotDelayedPriceTime: json["oddLotDelayedPriceTime"],
    extendedPrice: json["extendedPrice"],
    extendedChange: json["extendedChange"],
    extendedChangePercent: json["extendedChangePercent"],
    extendedPriceTime: json["extendedPriceTime"],
    previousClose: json["previousClose"].toDouble(),
    previousVolume: json["previousVolume"],
    change: json["change"].toDouble(),
    changePercent: json["changePercent"].toDouble(),
    volume: json["volume"],
    iexMarketPercent: json["iexMarketPercent"].toDouble(),
    iexVolume: json["iexVolume"],
    avgTotalVolume: json["avgTotalVolume"],
    iexBidPrice: json["iexBidPrice"],
    iexBidSize: json["iexBidSize"],
    iexAskPrice: json["iexAskPrice"],
    iexAskSize: json["iexAskSize"],
    iexOpen: json["iexOpen"],
    iexOpenTime: json["iexOpenTime"],
    iexClose: json["iexClose"].toDouble(),
    iexCloseTime: json["iexCloseTime"],
    marketCap: json["marketCap"],
    peRatio: json["peRatio"].toDouble(),
    week52High: json["week52High"].toDouble(),
    week52Low: json["week52Low"].toDouble(),
    ytdChange: json["ytdChange"].toDouble(),
    lastTradeTime: json["lastTradeTime"],
    isUsMarketOpen: json["isUSMarketOpen"],
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
    "companyName": companyName,
    "primaryExchange": primaryExchange,
    "calculationPrice": calculationPrice,
    "open": open,
    "openTime": openTime,
    "openSource": openSource,
    "close": close,
    "closeTime": closeTime,
    "closeSource": closeSource,
    "high": high,
    "highTime": highTime,
    "highSource": highSource,
    "low": low,
    "lowTime": lowTime,
    "lowSource": lowSource,
    "latestPrice": latestPrice,
    "latestSource": latestSource,
    "latestTime": latestTime,
    "latestUpdate": latestUpdate,
    "latestVolume": latestVolume,
    "iexRealtimePrice": iexRealtimePrice,
    "iexRealtimeSize": iexRealtimeSize,
    "iexLastUpdated": iexLastUpdated,
    "delayedPrice": delayedPrice,
    "delayedPriceTime": delayedPriceTime,
    "oddLotDelayedPrice": oddLotDelayedPrice,
    "oddLotDelayedPriceTime": oddLotDelayedPriceTime,
    "extendedPrice": extendedPrice,
    "extendedChange": extendedChange,
    "extendedChangePercent": extendedChangePercent,
    "extendedPriceTime": extendedPriceTime,
    "previousClose": previousClose,
    "previousVolume": previousVolume,
    "change": change,
    "changePercent": changePercent,
    "volume": volume,
    "iexMarketPercent": iexMarketPercent,
    "iexVolume": iexVolume,
    "avgTotalVolume": avgTotalVolume,
    "iexBidPrice": iexBidPrice,
    "iexBidSize": iexBidSize,
    "iexAskPrice": iexAskPrice,
    "iexAskSize": iexAskSize,
    "iexOpen": iexOpen,
    "iexOpenTime": iexOpenTime,
    "iexClose": iexClose,
    "iexCloseTime": iexCloseTime,
    "marketCap": marketCap,
    "peRatio": peRatio,
    "week52High": week52High,
    "week52Low": week52Low,
    "ytdChange": ytdChange,
    "lastTradeTime": lastTradeTime,
    "isUSMarketOpen": isUsMarketOpen,
  };
}
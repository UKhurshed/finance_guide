import 'dart:convert';

QuoteOneDay quoteDetailsFromJson(String str) => QuoteOneDay.fromJson(json.decode(str));

String quoteDetailsToJson(QuoteOneDay data) => json.encode(data.toJson());

class QuoteOneDay {
  QuoteOneDay({
    this.history,
  });

  History history;

  factory QuoteOneDay.fromJson(Map<String, dynamic> json) => QuoteOneDay(
    history: History.fromJson(json["history"]),
  );

  Map<String, dynamic> toJson() => {
    "history": history.toJson(),
  };
}

class History {
  History({
    this.day,
  });

  Day day;

  factory History.fromJson(Map<String, dynamic> json) => History(
    day: Day.fromJson(json["day"]),
  );

  Map<String, dynamic> toJson() => {
    "day": day.toJson(),
  };
}

class Day {
  Day({
    this.date,
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
  });

  DateTime date;
  double open;
  double high;
  double low;
  double close;
  int volume;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    date: DateTime.parse(json["date"]),
    open: json["open"].toDouble(),
    high: json["high"].toDouble(),
    low: json["low"].toDouble(),
    close: json["close"].toDouble(),
    volume: json["volume"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "open": open,
    "high": high,
    "low": low,
    "close": close,
    "volume": volume,
  };
}

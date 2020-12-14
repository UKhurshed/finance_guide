import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    this.history,
  });

  History history;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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

  List<Day> day;

  factory History.fromJson(Map<String, dynamic> json) => History(
    day: List<Day>.from(json["day"].map((x) => Day.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "day": List<dynamic>.from(day.map((x) => x.toJson())),
  };
}

class Day {
  Day({
    this.open,
    this.high,
    this.low,
    this.close,
    this.volumeto,
  });

  double open;
  double high;
  double low;
  double close;
  int volumeto;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    open: json["open"].toDouble(),
    high: json["high"].toDouble(),
    low: json["low"].toDouble(),
    close: json["close"].toDouble(),
    volumeto: json["volume"],
  );

  Map<String, dynamic> toJson() => {
    "open": open,
    "high": high,
    "low": low,
    "close": close,
    "volumeto": volumeto,
  };
}

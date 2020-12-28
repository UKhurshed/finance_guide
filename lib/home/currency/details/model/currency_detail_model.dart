
import 'dart:convert';

Rates ratesFromJson(String str) => Rates.fromJson(json.decode(str));

String ratesToJson(Rates data) => json.encode(data.toJson());

class Rates {
  Rates({
    this.rates,
    this.startAt,
    this.base,
    this.endAt,
  });

  Map<String, Rate> rates;
  DateTime startAt;
  String base;
  DateTime endAt;

  factory Rates.fromJson(Map<String, dynamic> json) => Rates(
    rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, Rate>(k, Rate.fromJson(v))),
    startAt: DateTime.parse(json["start_at"]),
    base: json["base"],
    endAt: DateTime.parse(json["end_at"]),
  );

  Map<String, dynamic> toJson() => {
    "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "start_at": "${startAt.year.toString().padLeft(4, '0')}-${startAt.month.toString().padLeft(2, '0')}-${startAt.day.toString().padLeft(2, '0')}",
    "base": base,
    "end_at": "${endAt.year.toString().padLeft(4, '0')}-${endAt.month.toString().padLeft(2, '0')}-${endAt.day.toString().padLeft(2, '0')}",
  };
}

class Rate {
  Rate({
    this.rub,
  });

  double rub;

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
    rub: json["RUB"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "RUB": rub,
  };
}
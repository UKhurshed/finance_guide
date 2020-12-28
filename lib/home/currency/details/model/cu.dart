import 'dart:convert';

DetailRate ratesFromJson(String str) => DetailRate.fromJson(json.decode(str));

String ratesToJson(DetailRate data) => json.encode(data.toJson());

class DetailRate {
  DetailRate({
    this.rates,
    this.startAt,
    this.base,
    this.endAt,
  });

  Map<String, Map<String, double>> rates;
  DateTime startAt;
  String base;
  DateTime endAt;

  factory DetailRate.fromJson(Map<String, dynamic> json) => DetailRate(
    rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, Map<String, double>>(k, Map.from(v).map((k, v) => MapEntry<String, double>(k, v.toDouble())))),
    startAt: DateTime.parse(json["start_at"]),
    base: json["base"],
    endAt: DateTime.parse(json["end_at"]),
  );

  Map<String, dynamic> toJson() => {
    "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "start_at": "${startAt.year.toString().padLeft(4, '0')}-${startAt.month.toString().padLeft(2, '0')}-${startAt.day.toString().padLeft(2, '0')}",
    "base": base,
    "end_at": "${endAt.year.toString().padLeft(4, '0')}-${endAt.month.toString().padLeft(2, '0')}-${endAt.day.toString().padLeft(2, '0')}",
  };
}
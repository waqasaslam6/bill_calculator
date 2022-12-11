import 'dart:convert';

class Meter{
  String? referenceNumber;
  String? meterName;
  String? meterImage;
  String? meterOldReading;
  String? meterCurrentReading;

  Meter({
    this.referenceNumber,
    this.meterName,
    this.meterImage,
    this.meterOldReading,
    this.meterCurrentReading
});
  factory Meter.fromJson(Map<String,dynamic> json)=>Meter(
    referenceNumber: json["referenceNumber"],
    meterName: json["meterName"],
    meterImage: json["meterImage"],
    meterOldReading: json["meterOldReading"],
    meterCurrentReading: json["meterCurrentReading"],
  );
  static Map<String, dynamic> toMap(Meter meter) => {
    'referenceNumber': meter.referenceNumber,
    'meterName': meter.meterName,
    'meterImage': meter.meterImage,
    'meterOldReading': meter.meterOldReading,
    'meterCurrentReading': meter.meterCurrentReading,
  };

  static String encode(List<Meter> meters) => json.encode(
    meters
        .map<Map<String, dynamic>>((meter) => Meter.toMap(meter))
        .toList(),
  );

  static List<Meter> decode(String meters) =>
      (json.decode(meters) as List<dynamic>)
          .map<Meter>((item) => Meter.fromJson(item))
          .toList();


}
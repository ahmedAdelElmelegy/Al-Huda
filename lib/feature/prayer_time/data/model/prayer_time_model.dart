class PrayerTimeModel {
  PrayerTimeModel({
    required this.code,
    required this.status,
    required this.data,
  });

  final int? code;
  static const String codeKey = "code";

  final String? status;
  static const String statusKey = "status";

  final Data? data;
  static const String dataKey = "data";

  factory PrayerTimeModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimeModel(
      code: json["code"],
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  Data({required this.timings, required this.date, required this.meta});

  final Timings? timings;
  static const String timingsKey = "timings";

  final Date? date;
  static const String dateKey = "date";

  final Meta? meta;
  static const String metaKey = "meta";

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      timings: json["timings"] == null
          ? null
          : Timings.fromJson(json["timings"]),
      date: json["date"] == null ? null : Date.fromJson(json["date"]),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "timings": timings?.toJson(),
    "date": date?.toJson(),
    "meta": meta?.toJson(),
  };
}

class Date {
  Date({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  final String? readable;
  static const String readableKey = "readable";

  final String? timestamp;
  static const String timestampKey = "timestamp";

  final Gregorian? hijri;
  static const String hijriKey = "hijri";

  final Gregorian? gregorian;
  static const String gregorianKey = "gregorian";

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      readable: json["readable"],
      timestamp: json["timestamp"],
      hijri: json["hijri"] == null ? null : Gregorian.fromJson(json["hijri"]),
      gregorian: json["gregorian"] == null
          ? null
          : Gregorian.fromJson(json["gregorian"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "readable": readable,
    "timestamp": timestamp,
    "hijri": hijri?.toJson(),
    "gregorian": gregorian?.toJson(),
  };
}

class Gregorian {
  Gregorian({required this.json});
  final Map<String, dynamic> json;

  factory Gregorian.fromJson(Map<String, dynamic> json) {
    return Gregorian(json: json);
  }

  Map<String, dynamic> toJson() => {};
}

class Meta {
  Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });

  final double? latitude;
  static const String latitudeKey = "latitude";

  final double? longitude;
  static const String longitudeKey = "longitude";

  final String? timezone;
  static const String timezoneKey = "timezone";

  final Method? method;
  static const String methodKey = "method";

  final String? latitudeAdjustmentMethod;
  static const String latitudeAdjustmentMethodKey = "latitudeAdjustmentMethod";

  final String? midnightMode;
  static const String midnightModeKey = "midnightMode";

  final String? school;
  static const String schoolKey = "school";

  final Map<String, int> offset;
  static const String offsetKey = "offset";

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      latitude: json["latitude"],
      longitude: json["longitude"],
      timezone: json["timezone"],
      method: json["method"] == null ? null : Method.fromJson(json["method"]),
      latitudeAdjustmentMethod: json["latitudeAdjustmentMethod"],
      midnightMode: json["midnightMode"],
      school: json["school"],
      offset: Map.from(
        json["offset"],
      ).map((k, v) => MapEntry<String, int>(k, v)),
    );
  }

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "timezone": timezone,
    "method": method?.toJson(),
    "latitudeAdjustmentMethod": latitudeAdjustmentMethod,
    "midnightMode": midnightMode,
    "school": school,
    "offset": Map.from(offset).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class Method {
  Method({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  final int? id;
  static const String idKey = "id";

  final String? name;
  static const String nameKey = "name";

  final Params? params;
  static const String paramsKey = "params";

  final Location? location;
  static const String locationKey = "location";

  factory Method.fromJson(Map<String, dynamic> json) {
    return Method(
      id: json["id"],
      name: json["name"],
      params: json["params"] == null ? null : Params.fromJson(json["params"]),
      location: json["location"] == null
          ? null
          : Location.fromJson(json["location"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "params": params?.toJson(),
    "location": location?.toJson(),
  };
}

class Location {
  Location({required this.latitude, required this.longitude});

  final double? latitude;
  static const String latitudeKey = "latitude";

  final double? longitude;
  static const String longitudeKey = "longitude";

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(latitude: json["latitude"], longitude: json["longitude"]);
  }

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Params {
  Params({required this.fajr, required this.isha});

  final double? fajr;
  static const String fajrKey = "Fajr";

  final String? isha;
  static const String ishaKey = "Isha";

  factory Params.fromJson(Map<String, dynamic> json) {
    return Params(fajr: json["Fajr"], isha: json["Isha"]);
  }

  Map<String, dynamic> toJson() => {"Fajr": fajr, "Isha": isha};
}

class Timings {
  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  final String? fajr;
  static const String fajrKey = "Fajr";

  final String? sunrise;
  static const String sunriseKey = "Sunrise";

  final String? dhuhr;
  static const String dhuhrKey = "Dhuhr";

  final String? asr;
  static const String asrKey = "Asr";

  final String? sunset;
  static const String sunsetKey = "Sunset";

  final String? maghrib;
  static const String maghribKey = "Maghrib";

  final String? isha;
  static const String ishaKey = "Isha";

  final String? imsak;
  static const String imsakKey = "Imsak";

  final String? midnight;
  static const String midnightKey = "Midnight";

  final String? firstthird;
  static const String firstthirdKey = "Firstthird";

  final String? lastthird;
  static const String lastthirdKey = "Lastthird";

  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: json["Fajr"],
      sunrise: json["Sunrise"],
      dhuhr: json["Dhuhr"],
      asr: json["Asr"],
      sunset: json["Sunset"],
      maghrib: json["Maghrib"],
      isha: json["Isha"],
      imsak: json["Imsak"],
      midnight: json["Midnight"],
      firstthird: json["Firstthird"],
      lastthird: json["Lastthird"],
    );
  }

  Map<String, dynamic> toJson() => {
    "Fajr": fajr,
    "Sunrise": sunrise,
    "Dhuhr": dhuhr,
    "Asr": asr,
    "Sunset": sunset,
    "Maghrib": maghrib,
    "Isha": isha,
    "Imsak": imsak,
    "Midnight": midnight,
    "Firstthird": firstthird,
    "Lastthird": lastthird,
  };
}

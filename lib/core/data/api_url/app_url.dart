class AppURL {
  static const String baseUrl = "https://api.alquran.cloud/v1/";

  static const String prayer = "https://api.aladhan.com/v1/timings?";
  static String latitude = "30.593890918406988";
  static String longitude = "31.899578638506828";
  static String method = "8";

  static const String surah = "surah";

  static const String readerName = "ar.alafasy";
  static const String radio = "https://data-rosy.vercel.app/radio.json";
  static const String allahNames = "assets/data/6_allah_names.json";

  static const String doaa = "assets/data/";
  static List<String> doaaListUrl = [
    "doaa_qran.json",
    "doaa_sunnah.json",
    "doaa_rouqia.json",
  ];
}

// https://api.aladhan.com/v1/timings/26-08-2025?latitude=30.0444&longitude=31.2357&method=8
// https://api.alquran.cloud/v1/surah/1/ar.alafasy

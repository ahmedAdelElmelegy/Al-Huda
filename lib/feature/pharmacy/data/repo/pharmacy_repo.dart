import 'package:al_huda/feature/pharmacy/data/model/mood_prescription.dart';
import 'package:flutter/material.dart';

class PharmacyRepo {
  List<MoodPrescription> getPresets() {
    return [
      const MoodPrescription(
        id: 1,
        moodName: "قلق", // Anxious
        icon: Icons.waves,
        color: Colors.blueAccent,
        verseText: "الَّذِينَ آمَنُوا وَتَطْمَئِنُّ قُلُوبُهُم بِذِكْرِ اللَّهِ ۗ أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
        verseSource: "سورة الرعد: 28",
        dua: "اللهم إني أعوذ بك من الهم والحزن، والعجز والكسل، والجبن والبخل",
        action: "توضأ وصلِّ ركعتين في هدوء، وأطل السجود.",
      ),
      const MoodPrescription(
        id: 2,
        moodName: "حزين", // Sad
        icon: Icons.cloud,
        color: Colors.blueGrey,
        verseText: "لَا تَحْزَنْ إِنَّ اللَّهَ مَعَنَا",
        verseSource: "سورة التوبة: 40",
        dua: "يا حي يا قيوم برحمتك أستغيث، أصلح لي شأني كله ولا تكلني إلى نفسي طرفة عين",
        action: "تصدق ولو بالقليل، فإن الصدقة تطفئ غضب الرب وتدفع البلاء.",
      ),
      const MoodPrescription(
        id: 3,
        moodName: "غاضب", // Angry
        icon: Icons.local_fire_department,
        color: Colors.deepOrange,
        verseText: "وَالْكَاظِمِينَ الْغَيْظَ وَالْعَافِينَ عَنِ النَّاسِ ۗ وَاللَّهُ يُحِبُّ الْمُحْسِنِينَ",
        verseSource: "سورة آل عمران: 134",
        dua: "أعوذ بالله من الشيطان الرجيم",
        action: "غير وضعيتك (اجلس إذا كنت واقفاً)، وتوضأ بالماء البارد.",
      ),
      const MoodPrescription(
        id: 4,
        moodName: "مذنب", // Sinful/Guilty
        icon: Icons.undo,
        color: Colors.purple,
        verseText: "قُلْ يَا عِبَادِيَ الَّذِينَ أَسْرَفُوا عَلَىٰ أَنفُسِهِمْ لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ ۚ إِنَّ اللَّهَ يَغْفِرُ الذُّنُوبَ جَمِيعًا",
        verseSource: "سورة الزمر: 53",
        dua: "اللهم أنت ربي لا إله إلا أنت، خلقتني وأنا عبدك، وأنا على عهدك ووعدك ما استطعت",
        action: "استغفر الله 100 مرة، واعزم على عدم العودة للصغير والكبير.",
      ),
      const MoodPrescription(
        id: 5,
        moodName: "كسول", // Lazy
        icon: Icons.snooze,
        color: Colors.amber,
        verseText: "وَوسَارِعُوا إِلَىٰ مَغْفِرَةٍ مِّن رَّبِّكُمْ وَجَنَّةٍ عَرْضُهَا السَّمَاوَاتُ وَالْأَرْضُ",
        verseSource: "سورة آل عمران: 133",
        dua: "اللهم إني أعوذ بك من العجز والكسل",
        action: "قم الآن وتوضأ، وابدأ بأبسط عمل ممكن لمدة 5 دقائق فقط.",
      ),
      const MoodPrescription(
        id: 6,
        moodName: "تائه", // Lost/Confused
        icon: Icons.explore,
        color: Colors.teal,
        verseText: "وَوَجَدَكَ ضَالًّا فَهَدَىٰ",
        verseSource: "سورة الضحى: 7",
        dua: "اللهم اهدني فيمن هديت، وتولني فيمن توليت، وبارك لي فيما أعطيت",
        action: "اقرأ سورة الضحى بتدبر، فهي نزلت لتواسي النبي ﷺ في لحظات الانتظار.",
      ),
    ];
  }
}

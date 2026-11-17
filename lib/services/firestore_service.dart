import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference placesCollection = FirebaseFirestore.instance.collection('places');

  Stream<QuerySnapshot> getPlacesStream() {
    seedDatabaseIfNeeded();
    return placesCollection.snapshots();
  }

  Future<void> seedDatabaseIfNeeded() async {
    var snapshot = await placesCollection.limit(1).get();
    if (snapshot.docs.isEmpty) {
      List<Map<String, dynamic>> initialPlaces = [
        {"name": "البتراء", "location": "معان", "rating": 4.9, "desc": "المدينة الوردية المنحوتة في الصخر، إحدى عجائب الدنيا السبع.", "image": "https://images.unsplash.com/photo-1541432901042-2d8bd64b4a9b?q=80&w=600"},
        {"name": "وادي رم", "location": "العقبة", "rating": 4.8, "desc": "وادي القمر، رمال حمراء ساحرة وجبال صخرية شاهقة بيئة مثالية للتخييم والمغامرة.", "image": "https://images.unsplash.com/photo-1582967788606-a171c1080cb0?q=80&w=600"},
        {"name": "جرش الأثرية", "location": "جرش", "rating": 4.7, "desc": "مدينة الألف عمود، واحدة من أكبر وأفضل المدن الرومانية المحافظ عليها في العالم.", "image": "https://images.unsplash.com/photo-1595825227318-7b957e841fba?q=80&w=600"},
        {"name": "البحر الميت", "location": "شمال وادي الأردن", "rating": 4.8, "desc": "أخفض نقطة على سطح الأرض، مياه غنية بالأملاح العلاجية وتجربة طفو فريدة.", "image": "https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?q=80&w=600"},
        {"name": "قلعة عمان", "location": "عمان", "rating": 4.5, "desc": "إطلالة تاريخية ساحرة على وسط البلد تحتوي على جبل القلعة ومعبد هرقل.", "image": "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=600"},
        {"name": "قلعة عجلون", "location": "عجلون", "rating": 4.6, "desc": "قلعة تاريخية بناها القائد عز الدين أسامة أحد قادة صلاح الدين الأيوبي لحماية المنطقة.", "image": "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?q=80&w=600"},
        {"name": "خليج العقبة", "location": "العقبة", "rating": 4.7, "desc": "منفذ الأردن البحري المتميز بالشعاب المرجانية الساحرة والرياضات المائية المثيرة.", "image": "https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=600"},
        {"name": "مأدبا الخريطة", "location": "مأدبا", "rating": 4.6, "desc": "مدينة الفسيفساء، تحتوي على أقدم خريطة أثرية للأراضي المقدسة.", "image": "https://images.unsplash.com/photo-1576085898323-2183fa9bc3a0?q=80&w=600"},
        {"name": "محمية ضانا", "location": "الطفيلة", "rating": 4.7, "desc": "سلسلة من الأودية والجبال الساحرة الممتدة من غوري الأردن إلى صحراء وادي عربة.", "image": "https://images.unsplash.com/photo-107525428034-b723cf961d3e?q=80&w=600"},
        {"name": "حمامات ماعين", "location": "مأدبا", "rating": 4.5, "desc": "شلالات ينابيع معدنية ساخنة تتدفق من أعلى الجبال لتوفر ملاذاً علاجياً استثنائياً.", "image": "https://images.unsplash.com/photo-1540555700478-4be289fbecef?q=80&w=600"}
      ];

      for (var place in initialPlaces) {
        await placesCollection.add(place);
      }
    }
  }
}
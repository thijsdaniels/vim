import 'package:cloud_firestore/cloud_firestore.dart';

class Consumption {
  static final CollectionReference<Consumption> _collection = FirebaseFirestore.instance
      .collection('consumptions')
      .withConverter<Consumption>(
        fromFirestore: (snapshot, _) => Consumption.fromSnapshot(snapshot),
        toFirestore: (consumption, _) => consumption.toMap(),
      );

  DocumentReference? _reference;

  late final Timestamp timestamp;
  final String name;
  final int calories;
  final int carbohydrates;
  final int fat;
  final int protein;

  Consumption({
    Timestamp? timestamp,
    required this.name,
    required this.calories,
    this.carbohydrates = 0,
    this.fat = 0,
    this.protein = 0,
  }) {
    this.timestamp = timestamp ?? Timestamp.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'name': name,
      'calories': calories,
      'carbohydrates': carbohydrates,
      'fat': fat,
      'protein': protein,
    };
  }

  static Consumption fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> map = snapshot.data()!;

    Consumption consumption = fromMap(map);
    consumption._reference = snapshot.reference;

    return consumption;
  }

  static Consumption fromMap(Map<String, dynamic> map) {
    return Consumption(
      timestamp: map['timestamp'],
      name: map['name'],
      calories: map['calories'],
      carbohydrates: map['carbohydrates'],
      fat: map['fat'],
      protein: map['protein'],
    );
  }

  Future<void> save() async {
    _reference = await _collection.add(this);
  }

  Future<void> delete() async {
    await _reference?.delete();
  }

  static Future<List<Consumption>> forDate(DateTime date) async {
    DateTime today = DateTime(date.year, date.month, date.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    QuerySnapshot<Consumption> snapshot = await _collection.where(
      'timestamp',
      isGreaterThanOrEqualTo: Timestamp.fromDate(today),
      isLessThan: Timestamp.fromDate(tomorrow),
    ).get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/nutrition.dart';

class Consumption {
  static final CollectionReference<Consumption> _collection = FirebaseFirestore
      .instance
      .collection('consumptions')
      .withConverter<Consumption>(
        fromFirestore: (snapshot, _) => Consumption.fromSnapshot(snapshot),
        toFirestore: (consumption, _) => consumption.toMap(),
      );

  DocumentReference? _reference;

  late Timestamp timestamp;
  String name;
  Nutrition nutrition;

  Consumption({
    Timestamp? timestamp,
    required this.name,
    required this.nutrition,
  }) {
    this.timestamp = timestamp ?? Timestamp.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'name': name,
      'nutrition': nutrition.toMap(),
    };
  }

  static Consumption fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    Consumption consumption = fromMap(map);
    consumption._reference = snapshot.reference;

    return consumption;
  }

  static Consumption fromMap(Map<String, dynamic> map) {
    return Consumption(
      timestamp: map['timestamp'],
      name: map['name'],
      nutrition: Nutrition.fromMap(map['nutrition']),
    );
  }

  Future<void> save() async {
    if (_reference == null) {
      _reference = await _collection.add(this);
    } else {
      await _reference!.set(toMap());
    }
  }

  Future<void> delete() async {
    await _reference?.delete();
  }

  static Future<List<Consumption>> forDate(DateTime date) async {
    DateTime today = DateTime(date.year, date.month, date.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    QuerySnapshot<Consumption> snapshot = await _collection
        .where(
          'timestamp',
          isGreaterThanOrEqualTo: Timestamp.fromDate(today),
          isLessThan: Timestamp.fromDate(tomorrow),
        )
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

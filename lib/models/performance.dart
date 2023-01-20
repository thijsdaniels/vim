import 'package:cloud_firestore/cloud_firestore.dart';

class Performance {
  static final CollectionReference<Performance> _collection = FirebaseFirestore
      .instance
      .collection('performances')
      .withConverter<Performance>(
        fromFirestore: (snapshot, _) => Performance.fromSnapshot(snapshot),
        toFirestore: (performance, _) => performance.toMap(),
      );

  DocumentReference? _reference;

  late Timestamp timestamp;
  String name;
  int calories;

  Performance({
    Timestamp? timestamp,
    required this.name,
    required this.calories,
  }) {
    this.timestamp = timestamp ?? Timestamp.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'name': name,
      'calories': calories,
    };
  }

  static Performance fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    Performance performance = fromMap(map);
    performance._reference = snapshot.reference;

    return performance;
  }

  static Performance fromMap(Map<String, dynamic> map) {
    return Performance(
      timestamp: map['timestamp'],
      name: map['name'],
      calories: map['calories'],
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

  static Future<List<Performance>> forDate(DateTime date) async {
    DateTime today = DateTime(date.year, date.month, date.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    QuerySnapshot<Performance> snapshot = await _collection
        .where(
          'timestamp',
          isGreaterThanOrEqualTo: Timestamp.fromDate(today),
          isLessThan: Timestamp.fromDate(tomorrow),
        )
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

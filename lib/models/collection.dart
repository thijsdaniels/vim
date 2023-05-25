import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:vim/models/model.dart';

/// TODO: Get rid of this class, because it's bad practice. I should just use
/// the `List` class, and where necessary add extensions on it.
class Collection<M extends Model> {
  @protected
  final List<M> entries;

  int get length => entries.length;
  bool get isEmpty => entries.isEmpty;
  bool get isNotEmpty => entries.isNotEmpty;
  M get first => entries.first;
  M get last => entries.last;

  const Collection([this.entries = const []]);

  M get(int index) {
    return entries[index];
  }

  List<Map<String, dynamic>> toMap() {
    return entries.map((exercise) => exercise.toMap()).toList();
  }

  Iterable<E> map<E>(E Function(M) toElement) {
    return entries.map(toElement);
  }

  Iterable<M> where(bool Function(M) test) {
    return entries.where(test);
  }

  Map<int, M> asMap() {
    return entries.asMap();
  }

  M? firstWhereOrNull(bool Function(M) test) {
    return entries.firstWhereOrNull(test);
  }

  ListSlice<M> slice(int start, [int? end]) {
    return entries.slice(start, end);
  }
}

class MutableCollection<M extends Model> extends Collection<M> {
  const MutableCollection([super.entries = const []]);

  void add(M entry) {
    entries.add(entry);
  }

  void remove(M entry) {
    entries.remove(entry);
  }

  M removeAt(int index) {
    return entries.removeAt(index);
  }

  void replace(int index, M value) {
    entries[index] = value;
  }

  void move(int from, int to) {
    entries.insert(to, removeAt(from));
  }
}

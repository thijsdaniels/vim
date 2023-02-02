import 'package:flutter/foundation.dart';
import 'package:vim/models/model.dart';

class Collection<M extends Model> {
  @protected
  final List<M> entries;

  int get length => entries.length;

  Collection([this.entries = const []]);

  M get(int index) {
    return entries[index];
  }

  List<Map<String, dynamic>> toMap() {
    return entries.map((exercise) => exercise.toMap()).toList();
  }

  Iterable<E> map<E>(E Function(M) toElement) {
    return entries.map(toElement);
  }
}

class MutableCollection<M extends Model> extends Collection<M> {
  void add(M entry) {
    entries.add(entry);
  }

  void remove(M entry) {
    entries.remove(entry);
  }

  void removeAt(int index) {
    entries.removeAt(index);
  }
}

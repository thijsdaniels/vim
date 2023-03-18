import 'package:flutter/foundation.dart';
import 'package:vim/models/model.dart';

/// @todo This is basically a wrapper for `List`, but it seems like really bad
/// practice to have to manually expose some of List's functionality here, like
/// as the `length` getter and such. It would be much better to _extend_ `List`
/// if I can figure out how to do that.
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

  void move(int from, int to) {
    entries.insert(to, removeAt(from));
  }
}

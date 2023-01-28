import 'package:vim/models/model.dart';

abstract class Collection<M extends Model> {
  int get length;

  M get(int index);

  List<Map<String, dynamic>> toMap();

  Iterable<E> map<E>(E Function(M) toElement);
}

abstract class MutableCollection<M extends Model> extends Collection<M> {
  void add(M);

  void remove(int index);
}

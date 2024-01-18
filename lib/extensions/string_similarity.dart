import 'dart:math';

import 'package:collection/collection.dart';
import 'package:string_similarity/string_similarity.dart';

extension SimilaritySort on List<String> {
  List<String> sortedBySimilarity(String target) {
    return _sortedBySimilarity(
      this,
      (item) => item,
      target,
    );
  }

  List<({String item, num similarity})> withSimilarity(
    String target, {
    String Function(String)? keyOf,
    num? minSimilarity,
    bool? normalizeSimilarity,
    int? maxResults,
  }) {
    return _withSimilarity(
      this,
      keyOf ?? (item) => item,
      target,
      minSimilarity: minSimilarity,
      normalizeSimilarity: normalizeSimilarity,
      maxResults: maxResults,
    );
  }
}

extension DynamicSimilaritySort<T> on List<T> {
  List<T> sortedBySimilarity(
    String Function(T) keyOf,
    String target,
  ) {
    return _sortedBySimilarity(
      this,
      keyOf,
      target,
    );
  }

  List<({T item, num similarity})> withSimilarity(
    String Function(T) keyOf,
    String target, {
    num? minSimilarity,
    bool? normalizeSimilarity,
    int? maxResults,
  }) {
    return _withSimilarity(
      this,
      keyOf,
      target,
      minSimilarity: minSimilarity,
      normalizeSimilarity: normalizeSimilarity,
      maxResults: maxResults,
    );
  }
}

List<T> _sortedBySimilarity<T>(
  List<T> items,
  String Function(T) keyOf,
  String target,
) {
  Map<T, double> similarities = {
    for (T entry in items) entry: keyOf(entry).similarityTo(target),
  };

  return items
    ..sort(
      (a, b) => similarities[b]!.compareTo(similarities[a]!),
    );
}

List<({T item, num similarity})> _withSimilarity<T>(
  List<T> items,
  String Function(T) keyOf,
  String target, {
  num? minSimilarity,
  bool? normalizeSimilarity,
  int? maxResults,
}) {
  Map<T, double> similarities = {
    for (T entry in items) entry: keyOf(entry).similarityTo(target),
  };

  var maxSimilarity = similarities.values.max;

  if (maxSimilarity == 0) {
    return [];
  }

  if (normalizeSimilarity == true) {
    similarities = {
      for (T entry in items) entry: similarities[entry]! / maxSimilarity,
    };
  }

  var results = items;

  if (minSimilarity != null) {
    results = results.where((entry) {
      return similarities[entry]! >= minSimilarity;
    }).toList();
  }

  results.sort(
    (a, b) => similarities[b]!.compareTo(similarities[a]!),
  );

  if (maxResults != null) {
    results = results.sublist(0, min(maxResults, results.length));
  }

  return results
      .map(
        (item) => (
          item: item,
          similarity: similarities[item]!,
        ),
      )
      .toList();
}

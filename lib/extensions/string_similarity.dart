import 'package:string_similarity/string_similarity.dart';

extension SimilaritySort on List<String> {
  List<String> sortedBySimilarity(String target) {
    Map<String, double> similarityMap = {
      for (String entry in this) entry: entry.similarityTo(target),
    };

    return this..sort((a, b) => similarityMap[b]!.compareTo(similarityMap[a]!));
  }
}

extension DynamicSimilaritySort<T> on List<T> {
  List<T> sortedBySimilarity(
    String Function(T) keyOf,
    String target,
  ) {
    Map<T, double> similarityMap = {
      for (T entry in this) entry: keyOf(entry).similarityTo(target),
    };

    return this..sort((a, b) => similarityMap[b]!.compareTo(similarityMap[a]!));
  }
}

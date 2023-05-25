import 'package:vim/models/exercise/performance.dart';

extension PerformancesListExtension on List<Performance> {
  Future<num> get calories async {
    return isNotEmpty
        ? map((performance) => performance.calories)
            .reduce((total, entry) async => await total + await entry)
        : Future(() => 0);
  }
}

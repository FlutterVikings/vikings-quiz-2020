import 'package:test/test.dart';
import 'package:vikings_quiz/configurations.dart';

void main() {
  test("Making sure that all configurations are set with a value", () {
    expect(ConfigurationValues.titoSecret, isNotEmpty);
    expect(ConfigurationValues.totalQuizDuration.inSeconds, isNonZero);
    expect(ConfigurationValues.totalQuizQuestions, isNonZero);
    expect(ConfigurationValues.questionsToBePicked, isNonZero);
    expect(ConfigurationValues.httpTimeout.inSeconds, isNonZero);
  });
}

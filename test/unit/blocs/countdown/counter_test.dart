import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/countdown/models/counter.dart';

void main() {
  final totalSeconds = 3;

  test("Testing the countdown stream", () {
    final counter = Counter().periodicStream(3);
    final expects =
        List<int>.generate(totalSeconds, (index) => totalSeconds - index - 1);

    expectLater(counter, emitsInOrder(expects));
  });
}

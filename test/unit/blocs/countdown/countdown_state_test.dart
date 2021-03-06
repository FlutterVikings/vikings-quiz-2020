import 'package:test/test.dart';
import 'package:vikings_quiz/blocs/countdown/countdown.dart';

void main() {
  group("CountdownState tests to make sure that value comparison works", () {
    test("Making sure Equatable has been properly overridden", () {
      expect(const CountdownInitial(1), const CountdownInitial(1));
      expect(const CountdownInProgress(1), const CountdownInProgress(1));
      expect(const CountdownCompleted(), const CountdownCompleted());

      expect(const CountdownInitial(1), isNot(const CountdownInitial(2)));
      expect(const CountdownInProgress(1), isNot(const CountdownInitial(2)));
    });
  });
}

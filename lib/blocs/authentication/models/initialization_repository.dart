import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vikings_quiz/blocs/authentication/models/authentication_exception.dart';

/// This class is used to initialize the dependencies and the state of the app.
class InitializationRepository {
  const InitializationRepository();

  /// Initializes instances of packages that require startup setup
  Future<void> execute() async {
    try {
      // Firebase init
      await Firebase.initializeApp();
    } on Exception catch (ex) {
      throw AuthenticationException("Exception: $ex");
    }
  }

  /// Tells whether users can play the quiz or not. Admins can "block" or "enable"
  /// the quiz remotely simply by changing a flag on Firestore
  Future<bool> isQuizDisabled() async {
    try {
      final document = await FirebaseFirestore.instance
          .collection("quiz_status")
          .doc("status")
          .get();

      return document.get("disabled") as bool;
    } on Exception catch (_) {
      return false;
    }
  }
}

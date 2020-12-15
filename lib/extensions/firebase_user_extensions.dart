part of 'extensions.dart';

// FirebaseUser --> User jadi beda dengan yang di users.dart
extension FirebaseUserExtension on User {
  Users convertToUser({String name = "No Name"}) =>
      Users(this.uid, this.email, name: name);
}

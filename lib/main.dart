import 'package:autovault/core/autovault.dart';
import 'package:autovault/core/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveBoxes {
  HiveBoxes._();
  static const String auth = 'authBox';
}

class HiveKeys {
  HiveKeys._();
  static const String currentUser = 'currentUser';
  static const String authToken = 'authToken'; // Firebase UID
  static const String userRole = 'userRole';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox(HiveBoxes.auth);

  runApp(
    const ProviderScope(
      child: AutoVault(),
    ),
  );
}

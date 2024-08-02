import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:SpeedyServe/screens/auth_screens/register.dart';
import 'package:SpeedyServe/screens/onboarding_screens/signin_register_screen.dart';
import 'mock.dart'; 

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('SigninScreen widget test', (WidgetTester tester) async {
  // Build the SigninScreen widget
  await tester.pumpWidget(const MaterialApp(
    home: SigninScreen(),
  ));

  // Verify the presence of widgets and their properties
  expect(find.text('SpeedyServe'), findsOneWidget);
  expect(find.text('Order your favorite Meals Here!'), findsOneWidget);
  expect(find.text('Sign in'), findsOneWidget);
  expect(find.text('Register'), findsOneWidget);

  // Find the OutlinedButton widget by its text
  final registerButtonFinder = find.widgetWithText(OutlinedButton, 'Register');

  // Ensure that the OutlinedButton widget is visible
  expect(registerButtonFinder, findsOneWidget);

  // Tap on the Register button
  await tester.tap(registerButtonFinder);
  await tester.pumpAndSettle();

  // Verify if it navigates to the Registration screen
  expect(find.byType(Registration), findsOneWidget);
});

}

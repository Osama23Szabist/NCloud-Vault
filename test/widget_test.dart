import 'package:flutter_test/flutter_test.dart';
import 'package:n_cloud_vault/main.dart';
import 'package:provider/provider.dart';
import 'package:n_cloud_vault/providers/auth_provider.dart';
import 'package:n_cloud_vault/providers/password_provider.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => PasswordProvider()),
        ],
        child: MyApp(),
      ),
    );

    // Verify that splash screen text is present
    expect(find.textContaining('NCloud Vault'), findsAtLeast(1));

    // Wait for timers to complete or pump until they are done
    await tester.pumpAndSettle(const Duration(seconds: 5));
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:serviko_admin/main.dart';

void main() {
  testWidgets('Serviko Admin App', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const ServikoAdminApp());
  });
}

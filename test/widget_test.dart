import 'package:flutter_test/flutter_test.dart';
import 'package:whot_empire/main.dart';

void main() {
  testWidgets('Whot Empire app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const WhotEmpireApp());

    expect(find.text('WHOT EMPIRE'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cv_flutter_dekens/main.dart';

void main() {
  testWidgets('L\'application s\'ouvre sur la page de connexion', (tester) async {
    GoogleFonts.config.allowRuntimeFetching = false;
    await tester.pumpWidget(const CvApp());
    expect(find.text('Se connecter'), findsOneWidget);
    expect(find.text('Identifiant'), findsOneWidget);
    expect(find.text('Mot de passe'), findsOneWidget);
  });
}

fvm dart run tools/convert_json_to_arb.dart
fvm flutter gen-l10n


final t = AppLocalizations.of(context)!;
Text(t.appTitle); // dari key app_title -> getter appTitle
Text(t.loginButton); // key login_button -> getter loginButton
Text(t.dashboardGreeting(name: 'Reza')); // placeholder (name) jika key punya placeholder

fvm flutter build apk --release
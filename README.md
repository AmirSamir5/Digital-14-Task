- if you are using an old version of flutter kindly change this line inside(android/app/src/main/AndroidManifest.xml)
  from (android:name="io.flutter.app.FlutterApplication") to (android:name="${applicationName}")

- to use the searchbar inside the app , after type the word you have to press on the search icon inside the keyboard (TextInputAction), I tried onChange but there was a bug with the favorites.

- This app handles favorite events using shared_preferences, i was thinking about firebase realtime database, but there was no time.

Shared preferences are a simple key-value storage mechanism that can be used to store small amounts
of data. However, since shared preferences are stored in plain text, it is not suitable for storing
sensitive information. To address this issue, you can use AES encryption to encrypt the data before
saving it to shared preferences.

To use shared preferences with AES encryption support, you can add this package to your project as
dependency.

[Open pub.dev](https://pub.dev/packages/encrypt_shared_preferences)

```dart
void main() {
  await EncryptedSharedPreferences.initialize(key 16 length);
  var sharedPref = EncryptedSharedPreferences.getInstance();

  await sharedPref.setString('user_token', 'xxxxxxxxxxxx');

  sharedPref.getString('user_token'); //xxxxxxxxxxxx


  await sharedPref.setInt('age', 99);

  sharedPref.getInt('age'); //99


  await sharedPref.setDouble('pi', 3.14);

  sharedPref.getDouble('pi'); //3.14


  await sharedPref.setBoolean('isPremium', true);


  sharedPref.getBoolean('isPremium'); //true

  await sharedPref.remove('user_token'); //true/false

  await sharedPref.clear(); //true/false

  sharedPref.listen(key: 'token').listen((event) { //event = key
    print(event);
  });

  sharedPref.listenSet(keys: {'key1', 'key2', 'keyN'}).listen((event) { //event = key
    print(event);
  });
}
```

[Shared builder] Here is example of how to use SharedBuilder widget

```dart
  @override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      body: SharedBuilder(
        listenKeys: const {"key1", "key2"}, //Optional
        builder: (String updatedKey, EncryptedSharedPreferences encryptedSharedPreferences) {
          return Text(
              "key $updatedKey   value : ${encryptedSharedPreferences.getString(updatedKey)}");
        },
      ),
      appBar: AppBar(
        title: const Text('Shared Builder Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          EncryptedSharedPreferences.getInstance()
              .setString('key1', 'dataValue');
          Future.delayed(const Duration(seconds: 3), () {
            EncryptedSharedPreferences.getInstance()
                .setString('key2', 'dataValue');
          });
        },
      ),
    ),
  );
}

```

import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});
  await EncryptedSharedPreferences.initialize("1111111111111111");
  final sharedPref = EncryptedSharedPreferences.getInstance();
  await sharedPref.clear();

  test('test listen key', () async {
    sharedPref.listen(key: 'singleKey').listen(
      expectAsync1(
        (event) {
          expect(event, 'singleKey');
        },
      ),
    );
    await Future.delayed(Duration.zero);
    await sharedPref.setString('singleKey', "Hi");
  });

  test('test listen key with observe method', () async {
    sharedPref.observe(key: 'singleKeyObserve').listen(
      expectAsync1(
        (event) {
          expect(event, 'singleKeyObserve');
        },
      ),
    );
    await Future.delayed(Duration.zero);
    await sharedPref.setString('singleKeyObserve', "Hi");
  });

  test('test listen set of keys', () async {
    sharedPref.observeSet(keys: {"keySet1", 'keySet2'}).listen(
      expectAsync1(
        (event) {
          expect(event, 'keySet1');
        },
      ),
    );
    await Future.delayed(Duration.zero);
    await sharedPref.setString('keySet1', "Hi");
  });
  test('test listen set of keys with observeSet method', () async {
    sharedPref.observeSet(keys: {"keySet1Observe", 'keySet2Observe'}).listen(
      expectAsync1(
        (event) {
          expect(event, 'keySet1Observe');
        },
      ),
    );
    await Future.delayed(Duration.zero);
    await sharedPref.setString('keySet1Observe', "Hi");
  });

  test('check data string saved', () async {
    await sharedPref.setString("dataKey", "dataValue");
    expect(sharedPref.getString('dataKey'), "dataValue");
  });

  test('check empty string saved', () async {
    await sharedPref.setString("keyDataEmpty", "");
    expect(sharedPref.getString("keyDataEmpty"), "");
  });

  test('check data int saved', () async {
    await sharedPref.setInt("age", 99);
    expect(sharedPref.getInt('age'), 99);
  });

  test('check data double saved', () async {
    await sharedPref.setDouble("pi", 3.14);
    expect(sharedPref.getDouble('pi'), 3.14);
  });

  test('check data boolean saved', () async {
    sharedPref.setBoolean("isPremium", true);
    expect(sharedPref.getBoolean('isPremium'), true);
  });

  test('check data clear', () async {
    var res = await sharedPref.clear();
    expect(res, true);
    expect(sharedPref.getString('dataKey'), null);
  });

  test('check data removed', () async {
    await sharedPref.setString("dataKey", "dataValue");
    expect(sharedPref.getString('dataKey'), "dataValue");
    await sharedPref.remove('dataKey');
    expect(sharedPref.getString('dataKey'), null);
  });

  test('check get all keys', () async {
    await sharedPref.setString("dataKey", "dataValue");
    var keys = await sharedPref.getKeys();
    expect(keys.length, 1);
  });

  test('read value of any type', () async {
    await sharedPref.clear();
    expect(sharedPref.getKeys().length, 0);
    //set
    await sharedPref.setString("valueKey1", "dataValue");
    await sharedPref.setInt("valueKey2", 100);
    await sharedPref.setDouble("valueKey3", 101.0);
    await sharedPref.setBoolean("valueKey4", true);
    //get
    String valueStr = sharedPref.get("valueKey1") as String;
    int valueInt =  int.parse(sharedPref.get("valueKey2").toString());
    double valueDouble = double.parse(sharedPref.get("valueKey3").toString());
    bool valueBool =  bool.parse(sharedPref.get("valueKey4").toString());
    expect(valueStr, "dataValue");
    expect(valueInt, 100);
    expect(valueBool, true);
    expect(valueDouble, 101.0);
  });
}

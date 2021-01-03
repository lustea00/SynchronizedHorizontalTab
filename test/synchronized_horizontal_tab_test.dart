import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:synchronized_horizontal_tab/synchronized_horizontal_tab.dart';

void main() {
  const MethodChannel channel = MethodChannel('synchronized_horizontal_tab');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SynchronizedHorizontalTab.platformVersion, '42');
  });
}

import 'dart:math' as math;

const kPatternOff = [false, false, false, false, false, false, false];

final _randomSeed = math.Random();

///　100の桁を抽出
///
/// 時速 123.4 km なら "1"
int fetch100(double speedKmh) {
  var temp = speedKmh;
  if (temp < 100) {
    return -1;
  }

  if (speedKmh > 1000) {
    temp = speedKmh % 1000;
  }
  return temp ~/ 100;
}

///　10の桁を抽出
///
/// 時速 123.4 km なら "2"
int fetch010(double speedKmh) {
  var temp = speedKmh;
  if (temp < 10) {
    return -1;
  }

  if (speedKmh > 100) {
    temp = speedKmh % 100;
  }
  return temp ~/ 10;
}

///　1の桁を抽出
///
/// 時速 123.4 km なら "3"
int fetch001(double speedKmh) {
  var temp = speedKmh;
  if (temp < 0) {
    return -1;
  }

  if (speedKmh > 10) {
    temp = speedKmh % 10;
  }
  return temp.toInt();
}

///　小数点以下を抽出
///
/// 時速 123.4 km なら "4"
int fetchMinor(double speedKmh) {
  var temp = speedKmh;
  if (temp < 0) {
    return -1;
  }

  if (speedKmh > 1) {
    temp = speedKmh % 1;
  }
  temp = (temp * 10.0);
  return temp.floor().toInt();
}

const Map<int, List<bool>> kNumberPatternMap = {
  0: [true, true, true, false, true, true, true],
  1: [false, false, true, false, false, true, false],
  2: [true, false, true, true, true, false, true],
  3: [true, false, true, true, false, true, true],
  4: [false, true, true, true, false, true, false],
  5: [true, true, false, true, false, true, true],
  6: [true, true, false, true, true, true, true],
  7: [true, true, true, false, false, true, false],
  8: [true, true, true, true, true, true, true],
  9: [true, true, true, true, false, true, true],
};

List<bool> makeRandomInformation() {
  var value = _randomSeed.nextInt(160);
  if (value < 0) {
    value = 0;
  }
  return makeInformation(input: value + (_randomSeed.nextDouble()));
}

List<bool> makeInformation({double input = 0.0}) {
  final result = <bool>[];
  result.addAll(kNumberPatternMap[fetch100(input)] ?? kPatternOff);
  result.addAll(kNumberPatternMap[fetch010(input)] ?? kPatternOff);
  result.addAll(kNumberPatternMap[fetch001(input)] ?? kPatternOff);
  result.add(true);
  result.addAll(kNumberPatternMap[fetchMinor(input)] ?? kPatternOff);

  return result;
}

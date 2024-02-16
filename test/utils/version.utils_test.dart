import "package:nice_flutter_kit/nice_flutter_kit.dart";
import "package:test/test.dart";

void main() {
  group("VersionUtils", () {
    group("compare", () {
      test("Same versions should return 0", () {
        expect(VersionUtils.compare("0", "0"), equals(0));
        expect(VersionUtils.compare("1", "1"), equals(0));

        expect(VersionUtils.compare("0.0", "0.0"), equals(0));
        expect(VersionUtils.compare("1.0", "1.0"), equals(0));
        expect(VersionUtils.compare("1.42", "1.42"), equals(0));

        expect(VersionUtils.compare("1.0.0", "1.0.0"), equals(0));
        expect(VersionUtils.compare("1.2.0", "1.2.0"), equals(0));
        expect(VersionUtils.compare("3.0.2", "3.0.2"), equals(0));

        expect(VersionUtils.compare("3.0.2.0", "3.0.2.0"), equals(0));
        expect(VersionUtils.compare("3.0.2.2", "3.0.2.2"), equals(0));
        expect(VersionUtils.compare("3.0.2.999", "3.0.2.999"), equals(0));
      });

      test("Lower version should return -1", () {
        expect(VersionUtils.compare("0", "1"), equals(-1));
        expect(VersionUtils.compare("1", "3"), equals(-1));
        expect(VersionUtils.compare("8", "42"), equals(-1));

        expect(VersionUtils.compare("0", "0.1"), equals(-1));
        expect(VersionUtils.compare("0.0", "0.1"), equals(-1));
        expect(VersionUtils.compare("1.0", "1.1"), equals(-1));

        expect(VersionUtils.compare("1.1", "1.1.1"), equals(-1));
        expect(VersionUtils.compare("1.3.0", "1.3.1"), equals(-1));

        expect(VersionUtils.compare("1.1.3", "1.4.1.1"), equals(-1));
        expect(VersionUtils.compare("1.3.0.1", "99.3.1"), equals(-1));
      });

      test("Higher version should return -1", () {
        expect(VersionUtils.compare("1", "0"), equals(1));
        expect(VersionUtils.compare("3", "1"), equals(1));
        expect(VersionUtils.compare("42", "8"), equals(1));

        expect(VersionUtils.compare("0.1", "0"), equals(1));
        expect(VersionUtils.compare("0.1", "0.0"), equals(1));
        expect(VersionUtils.compare("1.1", "1.0"), equals(1));

        expect(VersionUtils.compare("1.1.1", "1.1"), equals(1));
        expect(VersionUtils.compare("1.3.1", "1.3.0"), equals(1));

        expect(VersionUtils.compare("1.4.1.1", "1.1.3"), equals(1));
        expect(VersionUtils.compare("99.3.1", "1.3.0.1"), equals(1));
      });
    });

    test("isLessThan", () {
      expect(VersionUtils.isLessThan("0.0.0", "0.0.1"), equals(true));
      expect(VersionUtils.isLessThan("0.0.0", "0.1"), equals(true));
      expect(VersionUtils.isLessThan("0.1", "0.1.0"), equals(true));
      expect(VersionUtils.isLessThan("0.1", "0.1.1"), equals(true));
      expect(VersionUtils.isLessThan("1.8.33", "1.8.33"), equals(false));
      expect(VersionUtils.isLessThan("1.7.33", "1.8.33"), equals(true));
      expect(VersionUtils.isLessThan("1.8.34", "1.8.33"), equals(false));
      expect(VersionUtils.isLessThan("1.8.33", "1.8.33.4"), equals(true));
    });
  });
}

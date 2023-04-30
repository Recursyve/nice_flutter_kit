import "dart:convert";

class NiceJwtUtils {
  const NiceJwtUtils._();

  static Map<String, dynamic>? getTokenPayload(String accessToken) {
    final parts = accessToken.split(".");
    if (parts.length != 3) {
      return null;
    }

    final payload = _base64ToJson(parts[1]);
    return payload;
  }

  static bool isTokenValid(String accessToken, {int bufferSeconds = 5}) {
    final payload = getTokenPayload(accessToken);
    if (payload == null) {
      return false;
    }
    final now = DateTime.now().millisecondsSinceEpoch / 1000;
    return now + bufferSeconds < payload["exp"];
  }

  static Map<String, dynamic> _base64ToJson(String str) {
    return json.decode(
      utf8.decode(
        base64Url.decode(
          base64Url.normalize(str),
        ),
      ),
    );
  }
}

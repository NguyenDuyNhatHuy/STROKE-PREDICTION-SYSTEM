import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  // URL bạn đã deploy
  static const _scriptUrl = 'https://script.google.com/macros/s/AKfycbwzcTOzBkBebw1tSWC18Vcn4ub93Ef3MNcVXu1pcMi-wjgvQOkkqFpVSte63g_Jgu8/exec';
  final http.Client _client;

  EmailService([http.Client? client]) : _client = client ?? http.Client();

  /// Gửi OTP về email
  /// [email]: địa chỉ người nhận
  /// [code]: chuỗi 6 chữ số
  Future<void> sendOtp({
    required String email,
    required String code,
  }) async {
    final subject = 'Your OTP Code';
    final body    = 'Mã OTP của bạn là: $code';

    final uri = Uri.parse(_scriptUrl).replace(queryParameters: {
      'email'  : email,
      'subject': subject,
      'body'   : body,
    });

    final resp = await _client.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('HTTP error: ${resp.statusCode}');
    }

    final data = json.decode(resp.body) as Map<String, dynamic>;
    if (data['result'] != 'ok') {
      throw Exception('Lỗi từ server: ${data['message'] ?? 'Unknown'}');
    }
  }
}

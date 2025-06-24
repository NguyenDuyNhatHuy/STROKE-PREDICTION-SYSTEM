import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailService {
  static const String _webAppUrl =
      'https://script.google.com/macros/s/AKfycbyyyPL9tg8ocQwexLCdy2evCN4VqeOIAXr0c97-ZtvQBnz6Jg2l9qZu4t9IbouG7FrJzA/exec';

  /// Gửi OTP
  Future<bool> sendOtp({
    required String email,
    required String code,
  }) async {
    final response = await http.post(
      Uri.parse(_webAppUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'subject': 'Mã xác nhận của bạn',
        'body': 'Mã OTP: $code',
      }),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['result'] == 'ok';
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }

  /// Gửi thông báo chung (nếu cần)
  Future<bool> sendNotification({
    required String email,
    required String title,
    required String message,
  }) async {
    final response = await http.post(
      Uri.parse(_webAppUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'subject': title,
        'body': message,
      }),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['result'] == 'ok';
    }
    throw Exception('Error ${response.statusCode}: ${response.body}');
  }
}
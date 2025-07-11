import 'package:flutter/material.dart';

class StrokeInfoScreen extends StatelessWidget {
  const StrokeInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 40),
                    const Text(
                      'Thông tin về đột quỵ.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSection(
                      icon: Icons.warning_amber_rounded,
                      iconColor: Colors.red,
                      title: 'Dấu hiệu cảnh báo',
                      items: [
                        'Tê hoặc yếu đột ngột ở mặt, cánh tay, hoặc chân',
                        'Đột nhiên lú lẫn hoặc khó nói',
                        'Đột nhiên gặp vấn đề về thị lực ở một hoặc cả hai mắt',
                        'Đột nhiên gặp khó khăn khi đi bộ hoặc mất thăng bằng',
                        'Đau đầu dữ dội đột ngột',
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildSection(
                      icon: Icons.access_time_rounded,
                      iconColor: Colors.cyan,
                      title: 'Hành động khi có dấu hiệu',
                      items: [
                        'Gọi cấp cứu khẩn cấp (115) NGAY LẬP TỨC',
                        'Cố gắng giữ bình tĩnh',
                        'Không tùy tiện ăn, uống hoặc dùng thuốc',
                        'Hạn chế di chuyển',
                      ],
                      isBoldFirst: true,
                    ),
                    const SizedBox(height: 16),
                    _buildSection(
                      icon: Icons.favorite_border,
                      iconColor: Colors.teal,
                      title: 'Phòng ngừa',
                      items: [
                        'Kiểm soát huyết áp',
                        'Duy trì cân nặng khỏe mạnh',
                        'Tập thể dục thường xuyên',
                        'Chế độ ăn uống lành mạnh',
                        'Không hút thuốc lá',
                        'Hạn chế uống rượu',
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required Color iconColor,
    required String title,
    required List<String> items,
    bool isBoldFirst = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.asMap().entries.map(
                (entry) {
              final index = entry.key;
              final item = entry.value;
              final bool bold = isBoldFirst && index == 0;
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '• $item',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
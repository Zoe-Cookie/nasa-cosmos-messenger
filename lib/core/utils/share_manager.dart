import 'dart:io';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nasa_cosmos_messenger/data/models/apod_model.dart';
import 'package:nasa_cosmos_messenger/ui/widgets/share_card_layout.dart';

class ShareManager {
  static final ScreenshotController _screenshotController = ScreenshotController();

  static Future<void> generateAndShareCard(BuildContext context, ApodModel apod) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final shareWidget = ShareCardLayout(apod: apod);

      final imageBytes = await _screenshotController.captureFromWidget(
        shareWidget,
        context: context,
        targetSize: const Size(1080, 1440), 
      );

      final tempDir = await getTemporaryDirectory();
      final fileName = 'nova_share_${apod.date}.png';
      final file = await File('${tempDir.path}/$fileName').create();
      await file.writeAsBytes(imageBytes);
      final displayDate = apod.date.replaceAll('-', '/');

      if (context.mounted) Navigator.pop(context);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: '這是我在 #NovaSpace 上發現 $displayDate 的絕美天文圖！🔭\n標題：${apod.title}',
      );

    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('抱歉，分享失敗了... 請再試一次！')),
        );
      }
      debugPrint('分享出錯: $e');
    }
  }
}
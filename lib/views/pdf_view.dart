import 'dart:io';

import 'package:comic_world/const.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class ComicPdfView extends StatefulWidget {
  final String pdfUrl;
  final int comicId;
  const ComicPdfView({super.key, required this.pdfUrl, required this.comicId});

  @override
  _ComicPdfViewState createState() => _ComicPdfViewState();
}

class _ComicPdfViewState extends State<ComicPdfView> {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    getUnityAds();
  }

  viewed() async {
    try {
      final data = await supabase
          .from('most_viewed')
          .select()
          .eq('user_name', kUser!.email.toString())
          .eq('comic_id', widget.comicId)
          .maybeSingle();
      if (data == null) {
        await supabase.rpc(
          'increment_views',
          params: {'comic_id': widget.comicId},
        );
        await supabase.from('most_viewed').insert({
          'user_name': kUser!.email.toString(),
          'comic_id': widget.comicId,
        });
      }
    } on SocketException {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('يرجي التحقق من اتصالك بالانترنت')),
      );
    } on Exception catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfPdfViewer.network(
          canShowPageLoadingIndicator: true,
          canShowScrollStatus: true,
          widget.pdfUrl,
          key: pdfViewerKey,
          enableDoubleTapZooming: true,
          onDocumentLoaded: (PdfDocumentLoadedDetails details) {},
        ),
      ),
    );
  }

  getUnityAds() {
    UnityAds.load(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) {
        UnityAds.showVideoAd(
          placementId: placementId,
          onSkipped: (placementId) => viewed(),
          onComplete: (placementId) => viewed(),
          onFailed: (placementId, error, message) =>getUnityAds()
        );
      },
      onFailed: (placementId, error, message) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('يرجي التحقق من اتصالك بالانترنت')),
            );
          },
    );
  }
}

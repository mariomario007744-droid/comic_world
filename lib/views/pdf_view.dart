import 'package:comic_world/const.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
    viewed();
  }
  viewed()async{
        final data = await supabase
  .from('most_viewed')
  .select().eq('user_name', kUser!.email.toString()).eq('comic_id', widget.comicId).maybeSingle();
  if(data == null){
await supabase
  .rpc('increment_views', params: {
    'comic_id': widget.comicId,});
    await supabase
    .from('most_viewed')
    .insert({'user_name': kUser!.email.toString(), 'comic_id': widget.comicId});
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
}

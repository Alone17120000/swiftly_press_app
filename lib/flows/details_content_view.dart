// lib/flows/details_content_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../config/app_config.dart';
import '../data/data_manager.dart';
import '../models/blog_post_model.dart';

class DetailsContentView extends StatefulWidget {
  final BlogPostModel post;
  const DetailsContentView({super.key, required this.post});

  @override
  State<DetailsContentView> createState() => _DetailsContentViewState();
}

class _DetailsContentViewState extends State<DetailsContentView> {
  bool _showSummary = false;

  String _getFormattedDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('MMMM d, yyyy').format(dateTime);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<DataManager>(context);
    final isFavorite = manager.favoritePostIds.contains(widget.post.id.toString());
    final summary = manager.summaries[widget.post.id];
    final imageUrl = widget.post.embedded.media?.first.large;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
                onPressed: () => manager.toggleFavorite(widget.post.id),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.post.category, style: const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
              background: imageUrl != null
                  ? Image.network(imageUrl, fit: BoxFit.cover, color: Colors.black.withOpacity(0.4), colorBlendMode: BlendMode.darken)
                  : Container(color: AppConfig.primaryLightColor),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.post.title.rendered.replaceAll(RegExp(r'<[^>]*>'), ''), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppConfig.primaryDarkColor)),
                  const SizedBox(height: 8),
                  Text(
                    'Published on ${_getFormattedDate(widget.post.dateGmt)}',
                    style: const TextStyle(color: AppConfig.primaryLightColor, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 20),
                  _showSummary && summary != null
                      ? Text(summary, style: const TextStyle(fontSize: 17.0, height: 1.5))
                      : Html(data: widget.post.content.rendered, style: {"body": Style(fontSize: FontSize(17.0), lineHeight: LineHeight.number(1.5))}),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConfig.actionDarkColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: manager.isSummarizing ? null : () async {
            if (summary != null) {
              setState(() => _showSummary = !_showSummary);
            } else {
              try {
                await manager.summarizePost(widget.post);
                if (mounted) {
                  setState(() => _showSummary = true);
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString().replaceFirst('Exception: ', '')),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              }
            }
          },
          child: manager.isSummarizing
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
              : Text(
            summary != null ? (_showSummary ? "Show Original" : "Show Summary") : "Summarize Post",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

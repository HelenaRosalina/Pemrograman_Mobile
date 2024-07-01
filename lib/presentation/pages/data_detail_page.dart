import 'package:flutter/material.dart';
import '../../data/recipe.dart';

class DataDetailPage extends StatelessWidget {
  final Recipe recipe;

  DataDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(recipe.image),
              SizedBox(height: 16),
              Text(
                recipe.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildFormattedText(recipe.summary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormattedText(String text) {
    final textSpans = <TextSpan>[];
    final regex = RegExp(r'<(/?[^>]+)>|([^<]+)');

    final matches = regex.allMatches(text);

    for (var match in matches) {
      final tag = match.group(1);
      final content = match.group(2);

      if (tag != null) {
        if (tag.startsWith('/')) {
          // Closing tag, pop the style
          if (textSpans.isNotEmpty) {
            textSpans.add(TextSpan(text: ''));
          }
        } else {
          // Opening tag, push the style
          switch (tag) {
            case 'b':
              textSpans.add(TextSpan(style: TextStyle(fontWeight: FontWeight.bold)));
              break;
            case 'i':
              textSpans.add(TextSpan(style: TextStyle(fontStyle: FontStyle.italic)));
              break;
            case 'u':
              textSpans.add(TextSpan(style: TextStyle(decoration: TextDecoration.underline)));
              break;
            default:
              break;
          }
        }
      } else if (content != null) {
        // Text content, add to the list
        textSpans.add(TextSpan(text: content));
      }
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.black, fontSize: 16),
        children: textSpans,
      ),
    );
  }
}
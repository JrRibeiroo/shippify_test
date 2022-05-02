import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CodeItem extends StatelessWidget {
  const CodeItem({
    Key? key,
    required this.title,
    required this.onDelete,
  }) : super(key: key);

  final String title;
  final Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: IconButton(
        onPressed: () => onDelete(title),
        icon: const Icon(Icons.delete),
      ),
      onTap: Uri.tryParse(title)!.hasAbsolutePath
          ? () => launchUrl(
                Uri.parse(title),
                mode: LaunchMode.externalApplication,
              )
          : null,
    );
  }
}

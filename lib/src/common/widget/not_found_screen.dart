import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  /// {@macro not_found}
  const NotFoundScreen({
    super.key,
    this.title,
    this.message,
  });

  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            title ?? 'Not found',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Text(message ?? 'Content not found'),
          ),
        ),
      );
}

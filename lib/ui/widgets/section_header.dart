import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.onTap})
      : super(key: key);

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              subtitle.toUpperCase(),
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.6),
                  decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }
}

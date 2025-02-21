import 'package:flutter/material.dart';

class InfoContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onPressed;


  const InfoContainer(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imagePath,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 200,
        height: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            Container(
              color: Colors.white70,
              height: 60,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Add padding around title
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 4.0),
                    child: Text(title),
                  ),
                  // Add padding around subtitle
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 4.0),
                      child: Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

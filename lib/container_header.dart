import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerHeader extends StatelessWidget {
  const ContainerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 120),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              'VISMA',
              style: GoogleFonts.ubuntu(
                fontSize: 30,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

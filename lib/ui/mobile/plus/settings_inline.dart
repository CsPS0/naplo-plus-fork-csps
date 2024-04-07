import 'package:flutter/material.dart';
import 'package:refilc_mobile_ui/plus/plus_screen.dart';

class PlusSettingsInline extends StatelessWidget {
  const PlusSettingsInline({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .push(MaterialPageRoute(builder: (context) {
            return const PlusScreen();
          }));
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/btn_plus_standard.png'),
              fit: BoxFit.fitWidth,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 2.0,
                  ),
                  Image.asset(
                    'assets/images/plus_tier_cap.png',
                    width: 23.0,
                    height: 23.0,
                  ),
                  const SizedBox(
                    width: 14.0,
                  ),
                  const Text(
                    'reFilc+',
                    style: TextStyle(
                      color: Color(0xFF150D4E),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Text(
                '0.99 €',
                style: TextStyle(
                  color: Color(0xFF150D4E),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

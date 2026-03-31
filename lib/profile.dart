import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 4;
    if (width < 600) {
      crossAxisCount = 1;
    } else if (width < 1000) {
      crossAxisCount = 2;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0B),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            children: [
              /// 🔥 PROFILE IMAGE
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD4AF37), width: 3),
                ),
                child: ClipOval(
                  child: Image.asset("assets/photo.jpg", fit: BoxFit.cover),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Muhammad Faris Musyaffa",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFD4AF37),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "ini diisi apa ya?",
                style: TextStyle(fontSize: 15, color: Colors.white54),
              ),

              const SizedBox(height: 50),

              GridView.count(
                shrinkWrap: true,
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
                childAspectRatio: 1.5,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  InfoBox(title: "Status", value: "Active Student"),
                  InfoBox(title: "Campus", value: "PENS"),
                  InfoBox(title: "NRP", value: "3124521021"),
                  InfoBox(title: "Major", value: "Informatics"),
                ],
              ),

              const SizedBox(height: 55),

              SizedBox(
                width: width < 600 ? double.infinity : 260,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Kembali ke HelloScreen
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 199, 6, 6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;
  final String value;

  const InfoBox({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 13, color: Colors.white54),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFD4AF37),
            ),
          ),
        ],
      ),
    );
  }
}

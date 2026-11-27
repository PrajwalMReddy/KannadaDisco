import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:kannada_disco/const/color.dart';
import 'package:kannada_disco/service/notification_service.dart';

/// Shown in the drawer. Keep in sync with `version` in pubspec.yaml.
const String appVersion = "1.2.0";

const String _playStoreUrl =
    'https://play.google.com/store/apps/details?id=com.prajwalmreddy.kannada_disco&hl=en-IN';

/// The numeric Apple ID from App Store Connect (App Information > Apple ID).
/// Leave empty until the app exists there; the Feedback item is hidden on iOS
/// until then, because App Review rejects links to other app stores.
const String appStoreId = '';

/// Where Feedback sends people to leave a review, or null if there is nowhere.
String? feedbackUrl(TargetPlatform platform) => switch (platform) {
      TargetPlatform.android => _playStoreUrl,
      TargetPlatform.iOS => appStoreId.isEmpty
          ? null
          : 'https://apps.apple.com/app/id$appStoreId?action=write-review',
      _ => null,
    };

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            const _Header(),
            const SizedBox(height: 20),
            _SideBarItem(
              title: "About",
              icon: Icons.info,
              onTap: () => Navigator.pushNamed(context, '/about'),
            ),
            _SideBarItem(
              title: "Usage",
              icon: Icons.smartphone,
              onTap: () => Navigator.pushNamed(context, '/usage'),
            ),
            _SideBarItem(
              title: "Settings",
              icon: Icons.settings,
              onTap: () => _pickNotificationTime(context),
            ),
            if (feedbackUrl(defaultTargetPlatform) case final url?)
              _SideBarItem(
                title: "Feedback",
                icon: Icons.feedback,
                onTap: () => launchUrl(Uri.parse(url),
                    mode: LaunchMode.externalApplication),
              ),
            const Divider(),
            const Center(
              child: Text(
                "Version: $appVersion",
                style: TextStyle(fontSize: 15.0, color: kannadaBlue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickNotificationTime(BuildContext context) async {
    final parts = (await NotificationService.savedTime()).split(':');
    if (!context.mounted) return;

    final picked = await showTimePicker(
      context: context,
      helpText: 'Set notification time',
      initialTime:
          TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1])),
    );
    if (picked == null) return;

    await NotificationService.saveTime(picked.hour, picked.minute);
    final scheduled =
        await NotificationService.instance.scheduleDailyNotification();
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(scheduled
          ? "Notification time set to ${picked.format(context)}"
          : "Couldn't schedule the notification. Check that notifications are allowed."),
    ));
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(60.0),
          bottomLeft: Radius.circular(60.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 11, 31, 48),
            Color.fromARGB(255, 29, 66, 97),
            Color.fromARGB(255, 109, 161, 204),
          ],
        ),
      ),
      height: 200,
      width: double.infinity,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("KannadaDisco",
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
          SizedBox(height: 10.0),
          Text("ಕನ್ನಡ ಡಿಸ್ಕೋ",
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
        ],
      ),
    );
  }
}

class _SideBarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _SideBarItem(
      {required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kannadaBlue),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}

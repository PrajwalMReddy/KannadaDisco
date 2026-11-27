import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

/// Shown in the drawer. Keep in sync with `version` in pubspec.yaml.
const String appVersion = "1.4.0";

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
    final reviewUrl = feedbackUrl(defaultTargetPlatform);

    // Close the drawer first, so going back returns to the screen.
    void open(String route) {
      Navigator.pop(context);
      Navigator.pushNamed(context, route);
    }

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Header(),
          const SizedBox(height: 12),
          _SideBarItem(
            title: "About",
            icon: Icons.info_outline,
            onTap: () => open('/about'),
          ),
          _SideBarItem(
            title: "How to use",
            icon: Icons.help_outline,
            onTap: () => open('/usage'),
          ),
          _SideBarItem(
            title: "Settings",
            icon: Icons.settings_outlined,
            onTap: () => open('/settings'),
          ),
          if (reviewUrl != null)
            _SideBarItem(
              title: "Rate the app",
              icon: Icons.star_outline,
              onTap: () => launchUrl(Uri.parse(reviewUrl),
                  mode: LaunchMode.externalApplication),
            ),
          const Spacer(),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Version $appVersion",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onBar = theme.appBarTheme.foregroundColor!;
    // The English and Kannada names carry equal weight.
    final nameStyle = theme.textTheme.titleLarge!
        .copyWith(color: onBar, fontWeight: FontWeight.w700);

    return Container(
      color: theme.appBarTheme.backgroundColor,
      padding: EdgeInsets.fromLTRB(
          24, MediaQuery.paddingOf(context).top + 24, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.asset("assets/logo.png"),
            ),
          ),
          const SizedBox(height: 16),
          Text("KannadaDisco", style: nameStyle),
          const SizedBox(height: 2),
          Text("ಕನ್ನಡ ಡಿಸ್ಕೋ", style: nameStyle),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        shape: const StadiumBorder(),
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w500)),
        onTap: onTap,
      ),
    );
  }
}

import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/service/notification_service.dart';

/// Turns on the daily Word of the Day reminder.
///
/// If notifications are already allowed, it quietly schedules the reminder
/// and shows nothing. Otherwise it offers a button, so people are asked for
/// permission when they choose to, not the moment the app opens.
class ReminderPrompt extends StatefulWidget {
  const ReminderPrompt({super.key});

  @override
  State<ReminderPrompt> createState() => _ReminderPromptState();
}

class _ReminderPromptState extends State<ReminderPrompt> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final service = NotificationService.instance;
    // Turned off in Settings: respect that and don't offer it here.
    if (await NotificationService.remindersEnabled() == false) return;
    if (await service.notificationsAllowed()) {
      await service.scheduleDailyNotification();
    } else if (service.isAvailable && mounted) {
      setState(() => _showButton = true);
    }
  }

  Future<void> _turnOn() async {
    final service = NotificationService.instance;
    final granted = await service.requestPermission();
    if (granted) await NotificationService.setRemindersEnabled(true);
    final scheduled = granted && await service.scheduleDailyNotification();
    if (!mounted) return;

    final time = (await NotificationService.savedTime()).split(':');
    if (!mounted) return;
    if (scheduled) setState(() => _showButton = false);

    final when = TimeOfDay(hour: int.parse(time[0]), minute: int.parse(time[1]))
        .format(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(scheduled
          ? "You'll get a new word every day at $when. Change the time in Settings."
          : "Notifications are off for KannadaDisco. You can turn them on in your phone's settings."),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (!_showButton) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextButton.icon(
        onPressed: _turnOn,
        style: TextButton.styleFrom(foregroundColor: Colors.white),
        icon: const Icon(Icons.notifications_active_outlined),
        label: const Text("Remind me every day"),
      ),
    );
  }
}

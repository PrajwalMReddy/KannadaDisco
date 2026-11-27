import 'package:material_ui/material_ui.dart';

import 'package:kannada_disco/const/theme.dart';
import 'package:kannada_disco/service/notification_service.dart';

/// Settings: the daily Word of the Day reminder and its time.
class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _service = NotificationService.instance;
  bool _loaded = false;
  bool _remindersOn = false;
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 0);

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final enabled = await NotificationService.remindersEnabled();
    final allowed = await _service.notificationsAllowed();
    final time = await _savedTime();
    if (!mounted) return;
    setState(() {
      _remindersOn = enabled != false && allowed;
      _time = time;
      _loaded = true;
    });
  }

  static Future<TimeOfDay> _savedTime() async {
    final parts = (await NotificationService.savedTime()).split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  Future<void> _setReminders(bool on) async {
    if (on) {
      if (!await _service.requestPermission()) {
        _say("Notifications are off for KannadaDisco. "
            "Turn them on in your phone's settings first.");
        return;
      }
      await NotificationService.setRemindersEnabled(true);
      await _service.scheduleDailyNotification();
    } else {
      await NotificationService.setRemindersEnabled(false);
      await _service.cancelDailyNotification();
    }
    if (mounted) setState(() => _remindersOn = on);
  }

  Future<void> _pickTime() async {
    final picked = await showModalBottomSheet<TimeOfDay>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => ReminderTimeSheet(initial: _time),
    );
    if (picked == null || !mounted) return;

    await NotificationService.saveTime(picked.hour, picked.minute);
    await _service.scheduleDailyNotification();
    if (!mounted) return;
    setState(() => _time = picked);
    _say("You'll get your word every day at ${picked.format(context)}.");
  }

  void _say(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
                  child: Text("Daily reminder", style: context.sectionStyle),
                ),
                Card(
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: _remindersOn,
                        onChanged: _service.isAvailable ? _setReminders : null,
                        secondary: const Icon(Icons.notifications_outlined),
                        title: const Text("Word of the Day"),
                        subtitle: const Text("A new Kannada word every day"),
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      ListTile(
                        enabled: _remindersOn,
                        onTap: _pickTime,
                        leading: const Icon(Icons.schedule),
                        title: const Text("Time"),
                        trailing: Text(
                          _time.format(context),
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: _remindersOn
                                ? theme.colorScheme.primary
                                : theme.disabledColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

/// Bottom sheet for choosing the reminder time: one-tap presets plus
/// hour / minute / AM-PM wheels. Pops with the chosen [TimeOfDay].
class ReminderTimeSheet extends StatefulWidget {
  final TimeOfDay initial;

  const ReminderTimeSheet({super.key, required this.initial});

  static const presets = [
    TimeOfDay(hour: 7, minute: 0),
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 12, minute: 30),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 21, minute: 0),
  ];

  @override
  State<ReminderTimeSheet> createState() => _ReminderTimeSheetState();
}

class _ReminderTimeSheetState extends State<ReminderTimeSheet> {
  static const _minuteStep = 5;
  static const _itemExtent = 48.0;

  // Minutes are picked in steps of 5.
  late TimeOfDay _time = TimeOfDay(
    hour: widget.initial.hour,
    minute: (widget.initial.minute ~/ _minuteStep) * _minuteStep,
  );

  late final _hour = FixedExtentScrollController(initialItem: _hour12 - 1);
  late final _minute =
      FixedExtentScrollController(initialItem: _time.minute ~/ _minuteStep);
  late final _period = FixedExtentScrollController(initialItem: _isPm ? 1 : 0);

  int get _hour12 => _time.hourOfPeriod == 0 ? 12 : _time.hourOfPeriod;
  bool get _isPm => _time.hour >= 12;

  @override
  void dispose() {
    _hour.dispose();
    _minute.dispose();
    _period.dispose();
    super.dispose();
  }

  void _set({int? hour12, int? minute, bool? pm}) {
    final h = (hour12 ?? _hour12) % 12 + ((pm ?? _isPm) ? 12 : 0);
    setState(() => _time = TimeOfDay(hour: h, minute: minute ?? _time.minute));
  }

  /// Turns a looping wheel the short way round to [target].
  void _spin(FixedExtentScrollController c, int target, int count) {
    final current = c.selectedItem;
    var delta = (target - current) % count;
    if (delta > count / 2) delta -= count;
    c.animateToItem(current + delta,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  void _choose(TimeOfDay preset) {
    setState(() => _time = preset);
    _spin(_hour, _hour12 - 1, 12);
    _spin(_minute, preset.minute ~/ _minuteStep, 60 ~/ _minuteStep);
    _period.animateToItem(_isPm ? 1 : 0,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  Widget _wheel({
    required FixedExtentScrollController controller,
    required List<String> labels,
    required ValueChanged<int> onChanged,
    bool loop = true,
    double width = 64,
  }) {
    final style = Theme.of(context).textTheme.headlineSmall;
    final children = [
      for (final label in labels) Center(child: Text(label, style: style)),
    ];
    return SizedBox(
      width: width,
      height: _itemExtent * 4,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: _itemExtent,
        physics: const FixedExtentScrollPhysics(),
        diameterRatio: 1.4,
        overAndUnderCenterOpacity: 0.35,
        onSelectedItemChanged: onChanged,
        childDelegate: loop
            ? ListWheelChildLoopingListDelegate(children: children)
            : ListWheelChildListDelegate(children: children),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Reminder time", style: theme.textTheme.titleLarge),
            const SizedBox(height: 4),
            Text("When should your new word arrive?",
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final preset in ReminderTimeSheet.presets)
                  ChoiceChip(
                    label: Text(preset.format(context)),
                    selected: preset == _time,
                    onSelected: (_) => _choose(preset),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                // Highlights the selected row across all three wheels.
                Container(
                  height: _itemExtent,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _wheel(
                      controller: _hour,
                      labels: [for (var h = 1; h <= 12; h++) '$h'],
                      onChanged: (i) => _set(hour12: i % 12 + 1),
                    ),
                    Text(':', style: theme.textTheme.headlineSmall),
                    _wheel(
                      controller: _minute,
                      labels: [
                        for (var m = 0; m < 60; m += _minuteStep)
                          m.toString().padLeft(2, '0'),
                      ],
                      onChanged: (i) =>
                          _set(minute: (i % (60 ~/ _minuteStep)) * _minuteStep),
                    ),
                    const SizedBox(width: 8),
                    _wheel(
                      controller: _period,
                      labels: const ['AM', 'PM'],
                      loop: false,
                      width: 72,
                      onChanged: (i) => _set(pm: i == 1),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navigator.pop(context, _time),
              style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52)),
              child: Text("Remind me at ${_time.format(context)}"),
            ),
          ],
        ),
      ),
    );
  }
}

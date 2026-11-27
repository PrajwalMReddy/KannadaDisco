/// Keys used in SharedPreferences. The string values must not change, or
/// existing users lose their saved settings.
class PrefsKeys {
  PrefsKeys._();

  /// Daily reminder time, "HH:mm" (older versions stored "HH:mm:ss").
  static const notificationTime = 'notificationTime';

  /// The word currently shown on the home screen.
  static const todayWord = 'todayInfo';

  /// The word that will be shown next, also used in the reminder text.
  static const nextWord = 'info';

  /// Whether the daily reminder is on. Missing means the user hasn't chosen.
  static const remindersEnabled = 'remindersEnabled';

  /// Date (yyyy-MM-dd) the word of the day last changed.
  static const lastDate = 'lastDate';
}

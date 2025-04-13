import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderService {
  static const _reminderSentKey = 'reminder_sent';
  static const _reminderDateKey = 'reminder_date';
  static const _depressionStatusKey = 'depression_status';

  // Save the reminder data
  Future<void> saveReminderData(DateTime reminderDate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_reminderSentKey, true);
    await prefs.setString(_reminderDateKey, reminderDate.toIso8601String());
  }

  // Save depression status for the day
  Future<void> saveDepressionStatus(bool isDepressed) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> depressionList =
        prefs.getStringList(_depressionStatusKey) ?? [];

    // Get today's date as a string (in yyyy-mm-dd format)
    String todayDate = DateTime.now().toIso8601String().split('T').first;

    // Check if there's already an entry for today
    bool statusAddedToday = false;
    for (int i = 0; i < depressionList.length; i++) {
      if (depressionList[i].startsWith(todayDate)) {
        depressionList[i] =
            '$todayDate|$isDepressed'; // Update the status for today
        statusAddedToday = true;
        break;
      }
    }

    // If no status added for today, add it
    if (!statusAddedToday) {
      depressionList.add('$todayDate|$isDepressed');
    }

    await prefs.setStringList(_depressionStatusKey, depressionList);
  }

  // Check if the user has been depressed for 3 consecutive days
  Future<bool> checkThreeConsecutiveDaysDepressed() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> depressionList =
        prefs.getStringList(_depressionStatusKey) ?? [];
    if (depressionList.length < 3) {
      return false; // Not enough data for 3 consecutive days
    }

    // Check if the last 3 items are true (depressed)
    return depressionList
        .sublist(depressionList.length - 3)
        .every((status) => status.split('|')[1] == 'true');
  }

  // Send reminder if due
  Future<void> sendReminder() async {
    bool due = await isReminderDue();
    if (due) {
      // Trigger reminder action (e.g., send notification, show popup)
      debugPrint("Sending reminder to the user...");

      // Save the reminder data
      await saveReminderData(DateTime.now());
    } else {
      debugPrint("Reminder has already been sent within the last 2 days.");
    }
  }

  // Check if reminder is due
  Future<bool> isReminderDue() async {
    final prefs = await SharedPreferences.getInstance();
    bool reminderSent = prefs.getBool(_reminderSentKey) ?? false;
    if (!reminderSent) {
      return true; // reminder has not been sent yet
    }

    String? reminderDateStr = prefs.getString(_reminderDateKey);
    if (reminderDateStr == null) return true;

    DateTime reminderDate = DateTime.parse(reminderDateStr);
    DateTime now = DateTime.now();
    Duration difference = now.difference(reminderDate);

    return difference.inDays >= 2;
  }

  // Trigger special action if the user is depressed for 3 days in a row
  Future<void> triggerDepressionPopup() async {
    bool isDepressedForThreeDays = await checkThreeConsecutiveDaysDepressed();
    if (isDepressedForThreeDays) {
      // Call a function to handle the depression popup or other action
      debugPrint(
          "User has been depressed for 3 consecutive days. Triggering special popup...");

      // Example of triggering a popup (can be adjusted as needed)
      _showDepressionPopup();
    } else {
      debugPrint("User has not been depressed for 3 consecutive days.");
    }
  }

  // Show a depression popup
  void _showDepressionPopup() {
    // This is just a placeholder for the popup logic.
    debugPrint("Special popup for continuous depression.");
  }
}

import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class AppUtils {
  // Format file size
  static String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }

  // Format date
  static String formatDate(String dateString, {String format = 'yyyy-MM-dd'}) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat(format).format(date);
    } catch (e) {
      return dateString;
    }
  }

  // Format date time
  static String formatDateTime(String dateString, {String format = 'yyyy-MM-dd HH:mm:ss'}) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat(format).format(date);
    } catch (e) {
      return dateString;
    }
  }

  // Time ago format
  static String timeAgo(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 365) {
        return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() == 1 ? '' : 's'} ago';
      } else if (difference.inDays > 30) {
        return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() == 1 ? '' : 's'} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  // Generate unique filename
  static String generateUniqueFileName(String originalName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = originalName.split('.').last;
    final nameWithoutExtension = originalName.replaceAll('.$extension', '');
    return '${nameWithoutExtension}_$timestamp.$extension';
  }

  // Clean HTML content
  static String cleanHtml(String html) {
    final exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return html.replaceAll(exp, '');
  }

  // Truncate text
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  // Validate email
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(email);
  }

  // Validate password
  static bool isValidPassword(String password) {
    return password.length >= 8;
  }

  // Generate random string
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }


  static double getBottomNavigationBarHeight(BuildContext context) {
    final bottomNavigationBarHeight = MediaQuery.of(context).viewInsets.bottom;
    return bottomNavigationBarHeight;
  }

  static double getScreenWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  static double getScreenHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }
}
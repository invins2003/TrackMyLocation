import 'package:intl/intl.dart';

class LocationModel {
  final double latitude;
  final double longitude;
  final String? city;
  final String? state;
  final String? pincode;
  final DateTime updatedAt;

  LocationModel({
    required this.latitude,
    required this.longitude,
    this.city,
    this.state,
    this.pincode,
    required this.updatedAt,
  });

  String get formattedCoordinates =>
      '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}';

  String get formattedAddress {
    final parts = [city, state, pincode]
        .where((e) => e != null && e!.isNotEmpty)
        .toList();
    return parts.isEmpty ? 'Address not available' : parts.join(', ');
  }

  // Formatting logic moved here
  String get formattedTime {
    final date = updatedAt.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final checkDate = DateTime(date.year, date.month, date.day);

    final timeStr = DateFormat('h:mm a').format(date);

    if (checkDate == today) {
      return 'Today, $timeStr';
    } else if (checkDate == yesterday) {
      return 'Yesterday, $timeStr';
    } else {
      // Returns format like "Oct 25, 10:30 AM"
      return DateFormat('MMM d, h:mm a').format(date);
    }
  }
}
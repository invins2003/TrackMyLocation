import 'package:flutter/material.dart';
import '../../../../core/models/location_model.dart';

class LocationInfoCard extends StatelessWidget {
  final LocationModel? location;
  final String permissionStatus;
  final String? errorMessage;
  final VoidCallback onRefreshTap;
  final bool isGranted;

  const LocationInfoCard({
    super.key,
    required this.location,
    required this.permissionStatus,
    this.errorMessage,
    required this.onRefreshTap,
    required this.isGranted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo, // Dark theme for this card
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Current Status',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              InkWell(
                onTap: onRefreshTap,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.refresh, color: Colors.white, size: 18),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),

          if (errorMessage != null)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(errorMessage!,
                          style: const TextStyle(color: Colors.white))),
                ],
              ),
            )
          else if (location == null)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Waiting for signal...',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          else
            Column(
              children: [
                _buildInfoRow(Icons.location_on, location!.formattedAddress),
                const Divider(color: Colors.white24, height: 24),
                Row(
                  children: [
                    Expanded(
                        child: _buildInfoRow(
                            Icons.explore, location!.formattedCoordinates,
                            isSmall: true)),
                    Expanded(
                        child: _buildInfoRow(
                            Icons.access_time, location!.formattedTime,
                            isSmall: true)),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, {bool isSmall = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white70, size: isSmall ? 16 : 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSmall ? 13 : 15,
              fontWeight: isSmall ? FontWeight.normal : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
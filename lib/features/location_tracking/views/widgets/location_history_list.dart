import 'package:flutter/material.dart';
import '../../../../core/models/location_history_item.dart';

class LocationHistoryList extends StatelessWidget {
  final List<LocationHistoryItem> history;

  const LocationHistoryList({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'No history recorded yet',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = history[index];
          final loc = item.location;
          final isFirst = index == 0;

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Timeline visual (Fixed Width)
                SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        width: 2,
                        height: 20,
                        color: isFirst ? Colors.transparent : Colors.grey[300],
                      ),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isFirst ? Colors.indigo : Colors.white,
                          border: Border.all(
                            color: isFirst ? Colors.indigo : Colors.grey[400]!,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 2,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),

                // Content Card (Takes remaining space)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16, right: 16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Address Row
                          Text(
                            loc.formattedAddress,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8), // Increased spacing slightly
                          
                          // Footer Row (Coordinates + Time)
                          Row(
                            children: [
                              // FIX: Expanded forces coordinates to share space
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.gps_fixed, 
                                      size: 12, color: Colors.grey[400]),
                                    const SizedBox(width: 4),
                                    Expanded( // Inner Expanded handles text truncation
                                      child: Text(
                                        loc.formattedCoordinates,
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 12,
                                          fontFamily: 'Courier',
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(width: 8), // Gap between coords and time
                              
                              // Time stays visible
                              Text(
                                loc.formattedTime,
                                style: TextStyle(
                                  color: Colors.indigo[400],
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: history.length,
      ),
    );
  }
}
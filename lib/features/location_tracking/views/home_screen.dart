import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/location_view_model.dart';
import 'widgets/location_info_card.dart';
import 'widgets/location_history_list.dart';
import 'widgets/map_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationViewModel>(
      builder: (context, vm, _) {
        // Determine Status Color
        final isGranted = vm.permissionStatus == PermissionStatusView.granted;
        final statusColor = isGranted ? Colors.teal : Colors.orange;

        return Scaffold(
          backgroundColor: Colors.grey[50], // Light background for contrast
          body: CustomScrollView(
            slivers: [
              // 1. Modern App Bar
              SliverAppBar(
                expandedHeight: 0,
                floating: true,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                title: const Text(
                  'Location Tracker',
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                actions: [
                  // Permission Indicator Chip
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isGranted ? Icons.check_circle : Icons.warning_amber_rounded,
                          size: 16,
                          color: statusColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isGranted ? 'Active' : 'Perm. Req',
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // 2. Scrollable Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Map with Shadow & Radius
                      MapViewWidget(location: vm.currentLocation),
                      const SizedBox(height: 20),
                      
                      // Info Card
                      LocationInfoCard(
                        location: vm.currentLocation,
                        permissionStatus: vm.permissionStatus.toString().split('.').last,
                        errorMessage: vm.errorMessage,
                        onRefreshTap: isGranted ? vm.fetchCurrentLocation : vm.requestPermission,
                        isGranted: isGranted,
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // History Header
                      Row(
                        children: [
                          Icon(Icons.history, color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          Text(
                            'Recent Movements',
                            style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              // 3. The List (Rendered efficiently as a Sliver)
              LocationHistoryList(history: vm.history),
              
              // Bottom padding for FAB
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),

          // 4. Primary Action Button
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (vm.isTracking) {
                vm.stopLocationStream();
              } else {
                vm.startLocationStream();
              }
            },
            backgroundColor: vm.isTracking ? Colors.redAccent : Colors.indigo,
            icon: Icon(vm.isTracking ? Icons.stop : Icons.play_arrow, color: Colors.white,),
            label: Text(vm.isTracking ? 'Stop Tracking' : 'Start Tracking',style:TextStyle(color: Colors.white) ,),
          ),
        );
      },
    );
  }
}
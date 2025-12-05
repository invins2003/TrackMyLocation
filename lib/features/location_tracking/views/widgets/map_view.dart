import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/models/location_model.dart';

class MapViewWidget extends StatelessWidget {
  final LocationModel? location;

  const MapViewWidget({super.key, this.location});

  @override
  Widget build(BuildContext context) {
    final LatLng pos = location != null
        ? LatLng(location!.latitude, location!.longitude)
        : const LatLng(0, 0); // Default fallback

    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: location == null
            ? Container(
                color: Colors.grey[100],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map_outlined, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 8),
                      Text(
                        'Location unavailable',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              )
            : GoogleMap(
                initialCameraPosition: CameraPosition(target: pos, zoom: 16),
                markers: {
                  Marker(
                    markerId: const MarkerId('current'),
                    position: pos,
                    // Customized icon could go here
                  ),
                },
                myLocationEnabled: true,
                zoomControlsEnabled: false, // Cleaner UI
                mapToolbarEnabled: false,
              ),
      ),
    );
  }
}
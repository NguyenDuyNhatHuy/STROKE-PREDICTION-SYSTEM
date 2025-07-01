import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NearbyHospitalsScreen extends StatefulWidget {
  const NearbyHospitalsScreen({super.key});

  @override
  State<NearbyHospitalsScreen> createState() => _NearbyHospitalsScreenState();
}

class Hospital {
  final String name;
  final String address;
  final LatLng location;

  Hospital({required this.name, required this.address, required this.location});
}

class _NearbyHospitalsScreenState extends State<NearbyHospitalsScreen> {
  LatLng? currentLocation;
  GoogleMapController? _mapController;

  final List<Hospital> hospitals = [];

  List<MapEntry<Hospital, double>> sortedHospitals = [];
  int hospitalsToShow = 10;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      _sortHospitalsByDistance();
    });
  }

  void _sortHospitalsByDistance() {
    if (currentLocation == null) {
      sortedHospitals = [];
      return;
    }
    sortedHospitals = hospitals
        .map((h) => MapEntry(
              h,
              _calculateDistance(
                currentLocation!.latitude,
                currentLocation!.longitude,
                h.location.latitude,
                h.location.longitude,
              ),
            ))
        .toList();
    sortedHospitals.sort((a, b) => a.value.compareTo(b.value));
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    // Haversine formula
    const double R = 6371; // Earth radius in km
    double dLat = _deg2rad(lat2 - lat1);
    double dLon = _deg2rad(lon2 - lon1);
    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_deg2rad(lat1)) *
            math.cos(_deg2rad(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return R * c;
  }

  double _deg2rad(double deg) {
    return deg * (math.pi / 180);
  }

  Set<Marker> _buildMarkers() {
    final Set<Marker> markers = {};
    if (currentLocation != null) {
      markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: currentLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(title: 'Vị trí của bạn'),
        ),
      );
    }
    for (var entry in sortedHospitals.take(hospitalsToShow)) {
      final h = entry.key;
      markers.add(
        Marker(
          markerId: MarkerId(h.name),
          position: h.location,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: h.name, snippet: h.address),
        ),
      );
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      'Bệnh viện gần đây',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Google Map
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 300.h,
                  color: Colors.grey[200],
                  child: currentLocation == null
                      ? const Center(child: CircularProgressIndicator())
                      : GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: currentLocation!,
                            zoom: 13,
                          ),
                          markers: _buildMarkers(),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          onMapCreated: (controller) {
                            _mapController = controller;
                          },
                        ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            // Danh sách bệnh viện
            Expanded(
              child: currentLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : (sortedHospitals.isEmpty
                      ? Center(
                          child: Text(
                            'Không có bệnh viện nào.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                itemCount: sortedHospitals.length < hospitalsToShow
                                    ? sortedHospitals.length
                                    : hospitalsToShow,
                                itemBuilder: (context, index) {
                                  final entry = sortedHospitals[index];
                                  final h = entry.key;
                                  final distance = entry.value;
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    margin: EdgeInsets.only(bottom: 12),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: Row(
                                        children: [
                                          Icon(Icons.local_hospital, color: Colors.red, size: 32),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  h.name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    color: Color(0xff23272f),
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  h.address,
                                                  style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  'Cách bạn: ${distance.toStringAsFixed(2)} km',
                                                  style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xffaaf0fa),
                                              foregroundColor: Color(0xff23272f),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            onPressed: () {
                                              final lat = h.location.latitude;
                                              final lng = h.location.longitude;
                                              final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
                                              // Sử dụng url_launcher để mở url nếu muốn
                                            },
                                            icon: Icon(Icons.directions, size: 20),
                                            label: Text('Chỉ đường'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (hospitalsToShow < sortedHospitals.length)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      hospitalsToShow += 10;
                                    });
                                  },
                                  child: Text('Xem thêm'),
                                ),
                              ),
                          ],
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
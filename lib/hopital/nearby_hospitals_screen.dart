import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

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

  final List<Hospital> hospitals = [
    Hospital(
      name: "Bệnh viện Nhân dân 115",
      address: "527 Sư Vạn Hạnh, Quận 10, TP.HCM",
      location: LatLng(10.772622, 106.667997),
    ),
    Hospital(
      name: "Bệnh viện Chợ Rẫy",
      address: "201B Nguyễn Chí Thanh, Quận 5, TP.HCM",
      location: LatLng(10.755341, 106.663712),
    ),
  ];

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f8f9),
      body: SafeArea(
        child: Column(
          children: [
            // Header bo góc
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios_new_rounded, size: 28, color: Color(0xff23272f)),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Bệnh viện gần đây',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff23272f),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bản đồ bo góc
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 260,
                  color: Colors.grey[200],
                  child: currentLocation == null
                      ? const Center(child: CircularProgressIndicator())
                      : FlutterMap(
                          options: MapOptions(
                            initialCenter: currentLocation!,
                            initialZoom: 13,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                              subdomains: const ['a', 'b', 'c'],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: currentLocation!,
                                  width: 40,
                                  height: 40,
                                  child: const Icon(
                                    Icons.person_pin_circle,
                                    color: Colors.blue,
                                    size: 40,
                                  ),
                                ),
                                ...hospitals.map(
                                  (h) => Marker(
                                    point: h.location,
                                    width: 36,
                                    height: 36,
                                    child: const Icon(
                                      Icons.local_hospital,
                                      color: Colors.red,
                                      size: 36,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ),
            SizedBox(height: 12),
            // Danh sách bệnh viện
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: hospitals.length,
                itemBuilder: (context, index) {
                  final h = hospitals[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
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
                              // Mở Google Maps chỉ đường
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
          ],
        ),
      ),
    );
  }
}

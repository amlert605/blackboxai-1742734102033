import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../models/parking.dart';
import '../services/auth_service.dart';
import '../services/location_service.dart';
import '../services/mapquest_service.dart';
import '../utils/map_utils.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/parking_detail_dialog.dart';
import 'login_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LocationService _locationService = LocationService();
  final MapController _mapController = MapController();
  Position? _currentPosition;
  List<Marker> _markers = [];
  bool _isLoading = true;
  String _currentAddress = '';

  final List<Parking> _parkingSpots = [
    Parking(
      id: '1',
      name: 'Downtown Parking',
      latitude: 14.5995,
      longitude: 120.9842,
      availableSpots: 25,
      pricePerHour: 50.0,
      isOpen: true,
      address: 'Ermita, Manila',
    ),
    Parking(
      id: '2',
      name: 'City Center Garage',
      latitude: 14.6037,
      longitude: 120.9821,
      availableSpots: 0,
      pricePerHour: 75.0,
      isOpen: true,
      address: 'Binondo, Manila',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    final hasPermission = await _locationService.checkLocationPermission();
    if (!hasPermission) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      _showLocationPermissionDialog();
      return;
    }

    final position = await _locationService.getCurrentLocation();
    if (position != null) {
      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });
      _updateMarkers();
      _updateCurrentAddress();
    }
  }

  Future<void> _updateCurrentAddress() async {
    if (_currentPosition == null) return;
    
    final location = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
    final address = await MapQuestService.reverseGeocode(location);
    
    if (mounted) {
      setState(() {
        _currentAddress = address;
      });
    }
  }

  void _updateMarkers() {
    if (_currentPosition == null) return;

    setState(() {
      _markers = [
        // Current location marker
        Marker(
          point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          width: MapUtils.markerWidth,
          height: MapUtils.markerHeight,
          builder: (context) => const Icon(
            Icons.my_location,
            color: Colors.blue,
            size: 40,
          ),
        ),
        // Parking spot markers
        ..._parkingSpots.map((parking) => Marker(
          point: LatLng(parking.latitude, parking.longitude),
          width: MapUtils.markerWidth,
          height: MapUtils.markerHeight,
          builder: (context) => GestureDetector(
            onTap: () => _showParkingDetails(parking),
            child: Icon(
              Icons.local_parking,
              color: parking.availableSpots > 0 ? Colors.green : Colors.red,
              size: 40,
            ),
          ),
        )),
      ];
    });
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'This app needs access to location to show nearby parking spots. '
          'Please enable location services to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final hasPermission = await _locationService.checkLocationPermission();
              if (hasPermission) {
                _initializeLocation();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showParkingDetails(Parking parking) {
    showDialog(
      context: context,
      builder: (context) => ParkingDetailDialog(parking: parking),
    );
  }

  Future<void> _refreshLocation() async {
    setState(() => _isLoading = true);
    await _initializeLocation();
  }

  void _handleSignOut() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: LoadingIndicator(message: 'Getting your location...'),
      );
    }

    if (_currentPosition == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Parking Finder')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Unable to get your location'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _refreshLocation,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Finder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleSignOut,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_currentAddress.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.blue[50],
              width: double.infinity,
              child: Text(
                'Current Location: $_currentAddress',
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                zoom: MapUtils.defaultZoom,
                maxZoom: MapUtils.maxZoom,
                minZoom: MapUtils.minZoom,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.parking_finder_app',
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshLocation,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

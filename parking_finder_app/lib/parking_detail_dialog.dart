import 'package:flutter/material.dart';
import '../models/parking.dart';

class ParkingDetailDialog extends StatelessWidget {
  final Parking parking;

  const ParkingDetailDialog({
    super.key,
    required this.parking,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              parking.name,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              Icons.local_parking,
              'Available Spots',
              '${parking.availableSpots}',
              parking.availableSpots > 0 ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.attach_money,
              'Price per Hour',
              '\$${parking.pricePerHour.toStringAsFixed(2)}',
              Colors.blue,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.access_time,
              'Status',
              parking.isOpen ? 'Open' : 'Closed',
              parking.isOpen ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.location_on,
              'Address',
              parking.address,
              Colors.grey[700]!,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: parking.isOpen && parking.availableSpots > 0
                      ? () {
                          // TODO: Implement booking functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Booking functionality coming soon!'),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Book Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

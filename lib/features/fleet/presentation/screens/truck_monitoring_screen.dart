import 'package:flutter/material.dart';

class TruckMonitoringScreen extends StatelessWidget {
  const TruckMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color fleetBlue = const Color(0xFF2B5B9A);
    final Color bgBeige = const Color(0xFFFFFCE4);

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: fleetBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('TRUCK MONITORING', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Driver Drowsiness
              _buildSectionTitle('Driver Drowsiness'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBEFDE), // Light greenish beige? Or maybe just light grey-beige. The screenshot has it slightly greenish beige.
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: fleetBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Live Camera Feed', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                              child: Image.network('https://plus.unsplash.com/premium_photo-1661605345717-36e2d93540ce?w=400', fit: BoxFit.cover), // Placeholder for driver illustration
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Alert History', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    _buildAlertItem('Driver showing sign of fatigue', '1 min ago'),
                    _buildAlertItem('Eyes Closed for 2 seconds', '5 min ago'),
                    _buildAlertItem('Drowsiness warning issued', '10 min ago'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Collision Warning
              _buildSectionTitle('Collision Warning'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBEFDE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: fleetBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Live Collision Detection', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                              child: Image.network('https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=400', fit: BoxFit.cover), // placeholder road
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Risk Analysis', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB5C9DF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Front Collision Risk', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              Text('High', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: 0.8,
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(fleetBlue),
                            minHeight: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Cargo Monitoring
              _buildSectionTitle('Cargo Monitoring'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBEFDE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: fleetBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Live Cargo Monitor', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                          child: Image.network('https://images.unsplash.com/photo-1587293852726-70cdb56c2866?w=400', fit: BoxFit.cover), // placeholder crates
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Location Tracking
              _buildSectionTitle('Location Tracking'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBEFDE),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: fleetBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Live Location', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                              child: Image.network('https://images.unsplash.com/photo-1524661135-423995f22d0b?w=400', fit: BoxFit.cover), // placeholder map
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Trip Statistics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _buildStatBox(Icons.access_time_filled, '2h 15m', 'Time left')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildStatBox(Icons.route, '145.5 km', 'Distance')),
                        const SizedBox(width: 8),
                        Expanded(child: _buildStatBox(Icons.speed, '40', 'Avg Speed')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }

  Widget _buildAlertItem(String message, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3D2CC),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: const TextStyle(color: Color(0xFFC72828), fontSize: 11, fontWeight: FontWeight.bold)),
          Text(time, style: const TextStyle(color: Color(0xFFC72828), fontSize: 9)),
        ],
      ),
    );
  }

  Widget _buildStatBox(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFB5C9DF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF88A5C6)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 16, color: Colors.black87),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
          Text(label, style: const TextStyle(fontSize: 9, color: Colors.black54)),
        ],
      ),
    );
  }
}

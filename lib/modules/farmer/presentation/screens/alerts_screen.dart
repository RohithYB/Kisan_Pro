import 'package:flutter/material.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  // Member Monitoring active by default as shown in mockups
  String _selectedFilter = 'Member Monitoring'; 

  // Chips list changes dynamically based on active filter to mirror user screenshots exactly!
  List<String> _getFiltersForCurrentState() {
    if (_selectedFilter == 'All Alerts') {
      return ['All Alerts', 'Cattle Monitoring', 'Weight Monitoring', 'Member Monitoring'];
    } else if (_selectedFilter == 'Cattle Monitoring') {
      return ['Cattle Monitoring', 'Member Monitoring'];
    } else if (_selectedFilter == 'Member Monitoring' || _selectedFilter == 'Cattle Weight Monitoring') {
      return ['Member Monitoring', 'Cattle Weight Monitoring'];
    } else {
      return ['All Alerts', 'Cattle Monitoring', 'Member Monitoring'];
    }
  }

  // App Bar Title dynamically switches based on active filter to mirror screenshots exactly!
  String _getAppBarTitle() {
    if (_selectedFilter == 'All Alerts') {
      return 'Alert Center';
    } else if (_selectedFilter == 'Cattle Monitoring') {
      return 'Cattle Monitoring';
    } else if (_selectedFilter == 'Member Monitoring') {
      return 'Member Monitoring Alerts';
    } else {
      return 'Alert Center';
    }
  }

  // Dynamic layout rendering based on active selection
  @override
  Widget build(BuildContext context) {
    const Color tealHeader = Color(0xFF0C7A70);
    const Color bgBeige = Color(0xFFFFFCE4);

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 19),
        ),
        centerTitle: true,
        backgroundColor: tealHeader,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Horizontal Scrollable Pill Chips matching screenshots
            Container(
              height: 60,
              color: Colors.transparent,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                children: _getFiltersForCurrentState().map((filterName) {
                  final bool isSelected = _selectedFilter == filterName;

                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedFilter = filterName;
                        });
                      },
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        decoration: BoxDecoration(
                          color: isSelected ? tealHeader : const Color(0xFFEFEFD9),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            color: isSelected ? tealHeader : Colors.black.withAlpha((0.05 * 255).round()),
                            width: 0.8,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          filterName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            // 2. Alert Feed Area with Dynamic Styles based on chosen filter
            Expanded(
              child: _buildDynamicAlertList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicAlertList() {
    if (_selectedFilter == 'All Alerts') {
      return _buildAllAlertsView();
    } else if (_selectedFilter == 'Cattle Monitoring') {
      return _buildCattleMonitoringView();
    } else {
      // Default / Member Monitoring image proof cards
      return _buildMemberMonitoringView();
    }
  }

  // ---------------------------------------------------------------------------
  // 1. CATTLE MONITORING VIEW: Circular left icons & colored headers (IMAGE 1)
  // ---------------------------------------------------------------------------
  Widget _buildCattleMonitoringView() {
    final List<Map<String, dynamic>> cattleLogs = [
      {
        'tag': 'HIGH ALERT',
        'tagColor': const Color(0xFFC0392B),
        'bgColor': const Color(0xFFFADBD8),
        'icon': Icons.warning_rounded,
        'iconColor': const Color(0xFFC0392B),
        'time': '1 Min Ago',
        'title': 'Unusual cattle movement detected in Camera 02',
        'desc': 'Zone B-4: Sudden stampede-like behavior identified by AI vision.',
      },
      {
        'tag': 'INVENTORY',
        'tagColor': const Color(0xFF7E5109),
        'bgColor': const Color(0xFFFCF3CF),
        'icon': Icons.analytics_rounded,
        'iconColor': const Color(0xFFB7950B),
        'time': '5 Mins Ago',
        'title': 'Cattle count mismatch detected',
        'desc': 'Main Paddock: Expected 42, AI identified 40. Verification required.',
      },
      {
        'tag': 'HEALTH',
        'tagColor': const Color(0xFF0E6251),
        'bgColor': const Color(0xFFD1F2EB),
        'icon': Icons.favorite_rounded,
        'iconColor': const Color(0xFF16A085),
        'time': '12 Mins Ago',
        'title': 'Low activity detected near feeding area',
        'desc': 'Tag #882: Immobility exceeds threshold (45 mins). Potential health concern.',
      },
      {
        'tag': 'RESOLVED',
        'tagColor': const Color(0xFF5D6D7E),
        'bgColor': const Color(0xFFE5E8E8),
        'icon': Icons.check_circle_rounded,
        'iconColor': const Color(0xFF7F8C8D),
        'time': '1 Hr Ago',
        'title': 'Gate 04 security handshake verified',
        'desc': 'System confirmed automated closure after cattle passage.',
      },
    ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: cattleLogs.length,
      itemBuilder: (context, index) {
        final log = cattleLogs[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF5),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.black.withAlpha((0.04 * 255).round())),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left circular pastel icon exactly matching Image 1
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: log['bgColor'],
                  shape: BoxShape.circle,
                ),
                child: Icon(log['icon'], color: log['iconColor'], size: 22),
              ),
              const SizedBox(width: 14),

              // Title and category fields
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header tag and time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          log['tag'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: log['tagColor'],
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          log['time'],
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Main title text
                    Text(
                      log['title'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Subtitle / Description text
                    Text(
                      log['desc'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        height: 1.35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 2. ALERT CENTER (ALL ALERTS) VIEW: Strip borders & Badge headers (IMAGE 2)
  // ---------------------------------------------------------------------------
  Widget _buildAllAlertsView() {
    final List<Map<String, dynamic>> allLogs = [
      {
        'badgeText': 'CATTLE TRACKING',
        'badgeBg': const Color(0xFFE8F8F5),
        'badgeColor': const Color(0xFF0C7A70),
        'leftBorder': Colors.transparent,
        'time': '2 Minutes Ago',
        'body': 'Cow KP-204 moved outside geo-fencing boundary',
      },
      {
        'badgeText': 'WEIGHT MONITORING',
        'badgeBg': const Color(0xFFFEF9E7),
        'badgeColor': const Color(0xFF7D6608),
        'leftBorder': const Color(0xFFD35400),
        'time': '15 Minutes Ago',
        'body': 'Bulls Group-A showing 5% sudden weight drop across 4 members',
      },
      {
        'badgeText': 'MILK MONITORING',
        'badgeBg': const Color(0xFFE8F8F5),
        'badgeColor': const Color(0xFF0C7A70),
        'leftBorder': Colors.transparent,
        'time': '45 Minutes Ago',
        'body': 'Morning yield complete: 420L collected. 12L under projected target.',
      },
      {
        'badgeText': 'VACCINE MONITORING',
        'badgeBg': const Color(0xFFE8F8F5),
        'badgeColor': const Color(0xFF0C7A70),
        'leftBorder': Colors.transparent,
        'time': '2 Hours Ago',
        'body': 'Scheduled FMD vaccination for Batch-C starting in 1 hour.',
      },
      {
        'badgeText': 'MEMBER MONITORING',
        'badgeBg': const Color(0xFFE8F8F5),
        'badgeColor': const Color(0xFF0C7A70),
        'leftBorder': Colors.transparent,
        'time': '3 Hours Ago',
        'body': 'Handler Rajesh checked in at South Pen 4.',
      },
      {
        'badgeText': 'CATTLE MONITORING',
        'badgeBg': const Color(0xFFFDEDEC),
        'badgeColor': const Color(0xFFC0392B),
        'leftBorder': const Color(0xFFC0392B),
        'time': '5 Hours Ago',
        'body': 'High temperature detected in Cow KP-112. Isolation recommended.',
      },
    ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: allLogs.length,
      itemBuilder: (context, index) {
        final log = allLogs[index];
        final Color leftBorderColor = log['leftBorder'];

        return Container(
          margin: const EdgeInsets.only(bottom: 14.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF5),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.black.withAlpha((0.03 * 255).round())),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Row(
              children: [
                // Optional left color strip
                if (leftBorderColor != Colors.transparent)
                  Container(
                    width: 5,
                    height: 84,
                    color: leftBorderColor,
                  ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Badge Tag and Time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: log['badgeBg'],
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Text(
                                log['badgeText'],
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: log['badgeColor'],
                                ),
                              ),
                            ),
                            Text(
                              log['time'],
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Main notification text in bold
                        Text(
                          log['body'],
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // 3. MEMBER MONITORING VIEW: B&W Image proofs card layout (IMAGE 3)
  // ---------------------------------------------------------------------------
  Widget _buildMemberMonitoringView() {
    final List<Map<String, String>> memberLogs = [
      {
        'image': 'https://images.unsplash.com/photo-1509248961158-e54f6934749c?auto=format&fit=crop&q=80&w=400',
        'title': 'Unauthorized person detected near cattle monitoring zone',
      },
      {
        'image': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&q=80&w=400',
        'title': 'Motion detected in Restricted Sector 4B',
      },
      {
        'image': 'https://images.unsplash.com/photo-1558002038-1055907df827?auto=format&fit=crop&q=80&w=400',
        'title': 'Unrecognized biometric scan attempt at Main Silo',
      },
    ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: memberLogs.length,
      itemBuilder: (context, index) {
        final alert = memberLogs[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF5),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.02 * 255).round()),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Grayscale high-fidelity video thumbnail exactly matching Image 3
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: Container(
                  height: 180,
                  color: Colors.black,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.matrix([
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0.2126, 0.7152, 0.0722, 0, 0,
                      0,      0,      0,      1, 0,
                    ]), // B&W cinematic night feed
                    child: Image.network(
                      alert['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, st) => const Icon(
                        Icons.photo_camera_front_rounded,
                        color: Colors.white24,
                        size: 64,
                      ),
                    ),
                  ),
                ),
              ),

              // Title warning label message matching mockup
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
                child: Text(
                  alert['title']!,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

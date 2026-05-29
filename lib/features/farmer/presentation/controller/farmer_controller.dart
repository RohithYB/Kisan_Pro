import 'package:flutter/material.dart';

import '../../../../data/models/alert_model.dart';
import '../../../../data/models/cattle_model.dart';
import '../../../../data/models/farm_model.dart';
import '../../../../data/models/member_model.dart';
import '../../../../data/models/milk_model.dart';
import '../../../../data/models/vaccine_model.dart';

class FarmerController extends ChangeNotifier {
  static final FarmerController instance = FarmerController._internal();

  FarmerController._internal() {
    _seedData();
  }

  // Initial farms list is empty as requested by the user
  final List<FarmModel> _farms = [];
  String? _selectedFarmId;

  final List<CattleModel> _cattleList = [];
  final List<MilkModel> _milkData = [];
  final List<AlertModel> _alerts = [];
  final List<VaccineModel> _vaccines = [];
  final List<MemberModel> _members = [];

  List<FarmModel> get farms => List.unmodifiable(_farms);
  String? get selectedFarmId => _selectedFarmId;

  FarmModel? get selectedFarm {
    if (_selectedFarmId == null || _farms.isEmpty) return null;
    return _farms.firstWhere(
      (f) => f.id == _selectedFarmId,
      orElse: () => _farms.first,
    );
  }

  List<CattleModel> get cattleList => List.unmodifiable(_cattleList);
  List<MilkModel> get milkData => List.unmodifiable(_milkData);
  List<AlertModel> get alerts => List.unmodifiable(_alerts);
  List<VaccineModel> get vaccines => List.unmodifiable(_vaccines);
  List<MemberModel> get members => List.unmodifiable(_members);

  void addFarm(FarmModel farm) {
    _farms.add(farm);
    notifyListeners();
  }

  void updateFarm(FarmModel updatedFarm) {
    final index = _farms.indexWhere((f) => f.id == updatedFarm.id);
    if (index != -1) {
      _farms[index] = updatedFarm;
      notifyListeners();
    }
  }

  void selectFarm(String farmId) {
    _selectedFarmId = farmId;
    notifyListeners();
  }

  void addCattle(CattleModel cattle) {
    _cattleList.add(cattle);
    notifyListeners();
  }

  void addMilkEntry(MilkModel entry) {
    _milkData.insert(0, entry);
    notifyListeners();
  }

  void addAlert(AlertModel alert) {
    _alerts.insert(0, alert);
    notifyListeners();
  }

  void addVaccine(VaccineModel vaccine) {
    _vaccines.insert(0, vaccine);
    notifyListeners();
  }

  void addMember(MemberModel member) {
    _members.insert(0, member);
    notifyListeners();
  }

  // Seeding support logs (e.g. cattle, alerts, vaccines) for offline demos
  void _seedData() {
    _cattleList.addAll([
      CattleModel(
        id: 'CTL-101',
        name: 'Gauri',
        breed: 'Gir Cow',
        weight: 420.0,
        status: 'Healthy',
      ),
      CattleModel(
        id: 'CTL-102',
        name: 'Ganga',
        breed: 'Sahiwal',
        weight: 395.5,
        status: 'Critical',
      ),
      CattleModel(
        id: 'CTL-103',
        name: 'Kalu',
        breed: 'Murrah Buffalo',
        weight: 510.0,
        status: 'Healthy',
      ),
    ]);

    _milkData.addAll([
      MilkModel(
        cattleId: 'CTL-101',
        quantity: 12.5,
        time: 'Morning',
        date: '2026-05-19',
      ),
      MilkModel(
        cattleId: 'CTL-101',
        quantity: 9.8,
        time: 'Evening',
        date: '2026-05-18',
      ),
      MilkModel(
        cattleId: 'CTL-103',
        quantity: 15.0,
        time: 'Morning',
        date: '2026-05-19',
      ),
    ]);

    _vaccines.addAll([
      VaccineModel(
        id: 'VAC-01',
        name: 'FMD Vaccine',
        date: '2026-05-10',
        isReminderSet: true,
      ),
      VaccineModel(
        id: 'VAC-02',
        name: 'Brucellosis',
        date: '2026-06-15',
        isReminderSet: true,
      ),
    ]);

    _members.addAll([
      MemberModel(
        id: 'MEM-01',
        name: 'Ramesh Singh',
        role: 'Caretaker',
        faceImageUrl: 'assets/images/farmer_icon.png',
      ),
      MemberModel(
        id: 'MEM-02',
        name: 'Dr. Anil Verma',
        role: 'Veterinarian',
        faceImageUrl: 'assets/images/admin_icon.png',
      ),
    ]);

    _alerts.addAll([
      AlertModel(
        id: 'ALT-1',
        title: 'Geofence Breach',
        description: 'Cattle Ganga has crossed the north farm fence boundary!',
        category: 'Tracking',
      ),
      AlertModel(
        id: 'ALT-2',
        title: 'Upcoming Vaccination',
        description: 'Brucellosis vaccine is scheduled for tomorrow morning.',
        category: 'Vaccine',
      ),
      AlertModel(
        id: 'ALT-3',
        title: 'Unauthorized Face Logged',
        description:
            'An unrecognized person was detected near Pen B at 11:30 PM.',
        category: 'Members',
      ),
    ]);
  }
}

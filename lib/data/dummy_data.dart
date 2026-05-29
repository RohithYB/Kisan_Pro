import 'models/customer_model.dart';
import 'models/farmer_model.dart';
import 'models/fleet_owner_model.dart';
import 'models/vehicle_model.dart';

class DummyData {
  static final List<FarmerModel> farmers = [
    FarmerModel(
      id: "FRM-2045",
      name: "Suresh Gowda",
      location: "Kolar, Karnataka",
      joinedDate: "Joined: 12 July 2026",
      avatarUrl:
          "https://images.unsplash.com/photo-1566492031773-4f4e44671857?auto=format&fit=crop&q=80&w=150",
      alertStatus: "CATTLE ALERT",
      totalCattle: 24,
      inventoryItems: 42,
    ),
    FarmerModel(
      id: "FRM-1982",
      name: "Lakshmi Hegde",
      location: "Mandya, Karnataka",
      joinedDate: "Joined: 04 Jan 2026",
      avatarUrl:
          "https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&q=80&w=150",
      alertStatus: "STEADY",
      totalCattle: 15,
      inventoryItems: 120,
    ),
  ];

  static final List<VehicleModel> vehicles = [
    VehicleModel(
      plateNumber: "KA-05-TR-4589",
      driverName: "Suresh",
      type: "Medium Cargo Truck",
      route: "Kolar -> Bengaluru",
      eta: "45 Min ETA",
      cargo: "Vegetables",
      lastActivity: "10 Min Ago",
      alert: "Driver drowsiness detected",
      status: "Active Delivery",
      imageUrl:
          "https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?auto=format&fit=crop&q=80&w=250",
    ),
    VehicleModel(
      plateNumber: "KA-51-MD-9021",
      driverName: "Mahesh",
      type: "Large Reefer Truck",
      route: "Mysore -> Bengaluru",
      eta: "1h 22m ETA",
      cargo: "Fruits (Cold)",
      lastActivity: "3 Min Ago",
      alert: null,
      status: "Active Delivery",
      imageUrl:
          "https://images.unsplash.com/photo-1516576880669-dfcbfd8f6cc7?auto=format&fit=crop&q=80&w=250",
    ),
    VehicleModel(
      plateNumber: "KA-01-EV-2241",
      driverName: "Rajesh",
      type: "Electric Cargo Van",
      route: "Jayanagar -> Whitefield",
      eta: "15 Min ETA",
      cargo: "Grains",
      lastActivity: "Just New",
      alert: null,
      status: "Active Delivery",
      imageUrl:
          "https://images.unsplash.com/photo-1578575437130-527eed3abbec?auto=format&fit=crop&q=80&w=250",
    ),
    VehicleModel(
      plateNumber: "KA-03-TR-7762",
      driverName: "Anand",
      type: "Heavy Cargo Truck",
      route: "Tumkur -> Bengaluru",
      eta: "55 Min ETA",
      cargo: "Fertilizers",
      lastActivity: "8 Min Ago",
      alert: null,
      status: "Active Delivery",
      imageUrl:
          "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&q=80&w=250",
    ),
  ];

  static final List<FleetOwnerModel> fleetOwners = [
    FleetOwnerModel(
      name: "Gowda Logistics",
      id: "FLT-9021",
      alerts: 2,
      vehicles: 18,
      activeDeliveries: 12,
      imageUrl:
          "https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?auto=format&fit=crop&q=80&w=150",
    ),
    FleetOwnerModel(
      name: "Patel Agri-Moves",
      id: "FLT-8842",
      alerts: 0,
      vehicles: 24,
      activeDeliveries: 15,
      imageUrl:
          "https://images.unsplash.com/photo-1516576880669-dfcbfd8f6cc7?auto=format&fit=crop&q=80&w=150",
    ),
    FleetOwnerModel(
      name: "Southern Haulers",
      id: "FLT-4530",
      alerts: 0,
      vehicles: 32,
      activeDeliveries: 28,
      imageUrl:
          "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&q=80&w=150",
    ),
    FleetOwnerModel(
      name: "Bharat Fleet Co",
      id: "FLT-1212",
      alerts: 0,
      vehicles: 11,
      activeDeliveries: 9,
      imageUrl:
          "https://images.unsplash.com/photo-1578575437130-527eed3abbec?auto=format&fit=crop&q=80&w=150",
    ),
  ];

  static final List<CustomerModel> customers = [
    CustomerModel(
      id: "CUST-8821",
      businessName: "Grand Palace Hotel",
      category: "Hospitality",
      location: "Bengaluru Central",
      totalOrders: "142",
      completionRate: "98%",
      activeDeliveries: 3,
      avatarUrl:
          "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&q=80&w=150",
      status: "ACTIVE",
      tier: "HIGH VOLUME",
      desc: "Consistently above average",
    ),
    CustomerModel(
      id: "CUST-8902",
      businessName: "Fresh Mart Supermarket",
      category: "Retail Supermarket",
      location: "Mysore",
      totalOrders: "98",
      completionRate: "100%",
      activeDeliveries: 1,
      avatarUrl:
          "https://images.unsplash.com/photo-1534723452862-4c874018d66d?auto=format&fit=crop&q=80&w=150",
      status: "ACTIVE",
      tier: "STANDARD VOLUME",
      desc: "Regular buying pattern",
    ),
    CustomerModel(
      id: "CUST-7211",
      businessName: "Green Leaf Restaurant",
      category: "Restaurant",
      location: "Indiranagar",
      totalOrders: "24",
      completionRate: "95%",
      activeDeliveries: 0,
      avatarUrl:
          "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&q=80&w=150",
      status: "IDLE",
      tier: "STANDARD VOLUME",
      desc: "Inactive for 14 days",
    ),
    CustomerModel(
      id: "CUST-6610",
      businessName: "Veggie World Wholesale",
      category: "Wholesale",
      location: "K R Market",
      totalOrders: "312",
      completionRate: "99%",
      activeDeliveries: 5,
      avatarUrl:
          "https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&q=80&w=150",
      status: "ACTIVE",
      tier: "HIGH VOLUME",
      desc: "Daily high-frequency buyer",
    ),
    CustomerModel(
      id: "CUST-9104",
      businessName: "Blue Diamond Resorts",
      category: "Hospitality",
      location: "Whitefield",
      totalOrders: "56",
      completionRate: "100%",
      activeDeliveries: 2,
      avatarUrl:
          "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&q=80&w=150",
      status: "ACTIVE",
      tier: "HIGH VOLUME",
      desc: "Premium tier customer",
    ),
    CustomerModel(
      id: "CUST-5529",
      businessName: "Quick Bite Food Chain",
      category: "Restaurant",
      location: "Koramangala",
      totalOrders: "215",
      completionRate: "97%",
      activeDeliveries: 4,
      avatarUrl:
          "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&q=80&w=150",
      status: "ACTIVE",
      tier: "STANDARD VOLUME",
      desc: "Predictable weekly cycles",
    ),
  ];
}

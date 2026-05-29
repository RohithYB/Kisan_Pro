
class StockItem {
  String id;
  String name;
  String imagePath;
  String addedDate;
  double quantity;
  String expiryDate;
  double price;
  String storageLocation;
  String pestResult; // "Healthy Crop" or "Pest Detected"
  String status; // "In Stock" or "Low Stock"
  String unit; // "KG"

  StockItem({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.addedDate,
    required this.quantity,
    required this.expiryDate,
    required this.price,
    required this.storageLocation,
    required this.pestResult,
    required this.status,
    this.unit = "KG",
  });
}

class StockInventoryState {
  // Static lists to act as shared memory across the session
  static final List<StockItem> items = [];

  static final List<Map<String, dynamic>> marketplaceProducts = [
    {
      "title": "Fresh Tomato",
      "farmer": "Suresh Gowda Farms",
      "location": "Cold Storage A",
      "minOrder": "50 KG",
      "stock": "850 KG",
      "price": "18",
      "image": "https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400",
    },
    {
      "title": "Premium Potato (A-)",
      "farmer": "Kisan Aggregators",
      "location": "Pune, MH",
      "minOrder": "100 KG",
      "stock": "2.5 Tons",
      "price": "12",
      "image": "https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=400",
    },
    {
      "title": "Nashik Red Onion",
      "farmer": "Patil Farm Traders",
      "location": "Nashik, MH",
      "minOrder": "200 KG",
      "stock": "1.2 Tons",
      "price": "22",
      "image": "https://images.unsplash.com/photo-1620574387735-3624d75b2dbc?w=400",
    },
    {
      "title": "Washed Carrots",
      "farmer": "Ooty Fresh Veg",
      "location": "Ooty, TN",
      "minOrder": "50 KG",
      "stock": "400 KG",
      "price": "35",
      "image": "https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=400",
    },
  ];

  // List of mock farmer orders for the orders tab
  static final List<Map<String, dynamic>> farmerOrders = [
    {
      "id": "ORD-20458",
      "buyer": "FreshMart Vegetables",
      "time": "10 Min Ago",
      "status": "New Order",
      "stockAvailable": "820 KG Available",
      "item": "Fresh Tomatoes",
      "quantity": "650 KG",
      "value": "18,200",
      "distance": "68 KM",
      "truckType": "Medium Truck",
      "transportRequired": true,
      "vehicleRequested": false,
    }
  ];

  static void addStockItem(StockItem item) {
    items.add(item);
  }

  static void removeStockItem(String id) {
    items.removeWhere((item) => item.id == id);
  }

  static void updateStockItem(StockItem updatedItem) {
    int index = items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      items[index] = updatedItem;
    }
  }

  static void sendToMarketplace(StockItem item) {
    // Add or update in marketplaceProducts
    int index = marketplaceProducts.indexWhere((p) => p['title'] == item.name || p['title'].toString().contains(item.name));
    if (index != -1) {
      marketplaceProducts[index]['stock'] = "${item.quantity} ${item.unit}";
      marketplaceProducts[index]['price'] = item.price.toStringAsFixed(0);
      marketplaceProducts[index]['location'] = item.storageLocation;
    } else {
      marketplaceProducts.add({
        "title": item.name,
        "farmer": "Suresh Gowda Farms",
        "location": item.storageLocation,
        "minOrder": "10 KG",
        "stock": "${item.quantity} ${item.unit}",
        "price": item.price.toStringAsFixed(0),
        "image": item.imagePath.startsWith("http")
            ? item.imagePath
            : "https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=400", // Default
      });
    }
  }
}

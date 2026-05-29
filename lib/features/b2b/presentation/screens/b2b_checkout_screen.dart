import 'package:flutter/material.dart';
import 'b2b_order_confirmation_screen.dart';

class B2BCheckoutScreen extends StatefulWidget {
  const B2BCheckoutScreen({super.key});

  @override
  State<B2BCheckoutScreen> createState() => _B2BCheckoutScreenState();
}

class _B2BCheckoutScreenState extends State<B2BCheckoutScreen> {
  String _selectedPaymentMethod = "Bank Transfer";
  bool _generateGSTInvoice = true;

  @override
  Widget build(BuildContext context) {
    const Color rustBrown = Color(0xFFAD521B);
    const Color bgBeige = Color(0xFFFFFCE4);

    return Scaffold(
      backgroundColor: bgBeige,
      appBar: AppBar(
        backgroundColor: rustBrown,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Delivery Address Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery Address', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)),
                Text('Change Address', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: rustBrown)),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_outlined, color: rustBrown, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Sri Lakshmi Vegetables', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                        SizedBox(height: 4),
                        Text('Ramesh Gowda | +91 9876543210', style: TextStyle(fontSize: 12, color: Colors.black87)),
                        SizedBox(height: 2),
                        Text('12 Market Road, KR Market,\nBengaluru, Karnataka.', style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.4)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Business Details
            const Text('Business Details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Business Type', 'Retail Vegetable Store'),
                  const SizedBox(height: 12),
                  _buildDetailRow('GST Number', '29ABCDE1234F1Z5'),
                  const SizedBox(height: 12),
                  _buildDetailRow('Email', 'orders@srilakshmivegetables.com'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bulk Order Summary
            const Text('Bulk Order Summary', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  _buildSummaryItem('Fresh Tomato', '60 KG × ₹18/KG', '₹1,080', 'assets/images/farmer_card.png'),
                  const Divider(height: 1, color: Colors.black12),
                  _buildSummaryItem('Nasik Red Onion', '120 KG × ₹32/KG', '₹3,840', 'assets/images/logo_illustration.png'),
                  const Divider(height: 1, color: Colors.black12),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1EDE0),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.0)),
                    ),
                    child: Column(
                      children: [
                        _buildTotalRow('Total Weight', '180 KG'),
                        const SizedBox(height: 8),
                        _buildTotalRow('Delivery Charges', '₹120'),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Divider(height: 1, color: Colors.black26),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Grand Total', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text('₹5,420', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: rustBrown, fontFamily: 'serif')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Delivery card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: const Color(0xFFD6ECC1),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: const Color(0xFF3E5C1D).withAlpha(50)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_shipping_outlined, color: Color(0xFF3E5C1D), size: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Delivery in 1-2 Days', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                      SizedBox(height: 2),
                      Text('Wholesale Transport Delivery', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Payment Method
            const Text('Payment Method', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54)),
            const SizedBox(height: 12),
            _buildPaymentOption('UPI', Icons.account_balance_wallet_outlined, rustBrown),
            const SizedBox(height: 12),
            _buildPaymentOption('Bank Transfer', Icons.account_balance_outlined, rustBrown),
            const SizedBox(height: 12),
            _buildPaymentOption('Business Credit Account', Icons.credit_card_outlined, rustBrown),
            const SizedBox(height: 12),
            _buildPaymentOption('Cash on Delivery', Icons.money_outlined, rustBrown),
            const SizedBox(height: 24),

            // GST Toggle
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.receipt_long_outlined, color: rustBrown),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Generate GST Invoice', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                        Text('Invoice will include business GST details.', style: TextStyle(fontSize: 11, color: Colors.black54)),
                      ],
                    ),
                  ),
                  Switch(
                    value: _generateGSTInvoice,
                    activeThumbColor: Colors.white,
                    activeTrackColor: rustBrown,
                    onChanged: (val) {
                      setState(() {
                        _generateGSTInvoice = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 120), // Bottom sheet spacing
          ],
        ),
      ),
      bottomSheet: Container(
        color: bgBeige,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: rustBrown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.0),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const B2BOrderConfirmationScreen()),
                    );
                  },
                  child: const Text('Place Business Order', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFooterBadge(Icons.lock_outline, 'SECURE PAYMENT'),
                  _buildFooterBadge(Icons.verified_outlined, 'VERIFIED SUPPLIERS'),
                  _buildFooterBadge(Icons.receipt_outlined, 'GST BILLING'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500)),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String title, String subtitle, String price, String imageAsset) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(imageAsset, width: 50, height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: 'serif')),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
          Text(price, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: 'serif')),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPaymentOption(String label, IconData icon, Color rustBrown) {
    final bool isSelected = _selectedPaymentMethod == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1EDE0) : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? rustBrown : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? rustBrown : Colors.black54),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? rustBrown : Colors.black38,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterBadge(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 16, color: Colors.black54),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 8, color: Colors.black54, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

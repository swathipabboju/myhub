import 'package:flutter/material.dart';

class MyHubHome extends StatelessWidget {
  const MyHubHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _userBubble("I'm confused between Samsung Galaxy M34 and Redmi Note 13. Compare them."),
              _loaderTile("Searching", "Getting Data..."),
              _assistantBubble("Sure! Here's a quick comparison to help you decide."),

              const SizedBox(height: 12),
              _comparisonCard(),

              _assistantBubble(
                  "If you want better battery and long-term software support, Samsung Galaxy M34 is the better choice.\n\n"
                  "If you prefer a better camera, Redmi Note 13 is good too.\n\n"
                  "Which one would you like to go with?"),
              _userBubble("I'll go with Galaxy M34."),

              _assistantBubble("Great choice! Let me find the nearest stores offering Samsung Galaxy M34 at the best price."),
              _loaderTile("Checking", "Nearby mobile stores..."),

              _storeListCard(),

              _assistantBubble("Would you like to order it from Croma, or should I check more stores for you?"),
              _userBubble("Perfect"),

              _loaderTile("Perfect", "Placing your order..."),
              _billSummaryCard(),

              _assistantBubble(
                "Can I help you with anything else?\n\n"
                "If you want to check the delivery status, I can assist you with that.\n"
                "Or if you're interested, I can show you some mobile accessories for your new phone—cases, chargers, etc."
              ),

              _successTile(),

              const SizedBox(height: 20),
              _trackingHeader(),
              _trackingTimeline(),

              const SizedBox(height: 22),
              _trackingButtons(),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------
  // Chat Components
  // ------------------------------

  Widget _userBubble(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E77C9),
          borderRadius: BorderRadius.circular(14),
        ),
        width: 280,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _assistantBubble(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F5F8),
          borderRadius: BorderRadius.circular(14),
        ),
        width: 300,
        child: Text(text, style: const TextStyle(color: Colors.black87)),
      ),
    );
  }

  Widget _loaderTile(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF1E77C9), size: 32),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.black54)),
            ],
          )
        ],
      ),
    );
  }

  // ------------------------------
  // Comparison Card
  // ------------------------------

  Widget _comparisonCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 6, spreadRadius: 1, color: Colors.black12.withOpacity(0.05)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Device Comparison",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _deviceTile("Galaxy M34"),
              _deviceTile("Redmi Note 13"),
            ],
          ),

          const SizedBox(height: 16),
          _comparisonRow("Display", "6.5\" AMOLED 120Hz", "6.67\" AMOLED 120Hz"),
          _comparisonRow("Battery", "6000 mAh", "5000 mAh"),
          _comparisonRow("Camera", "50MP main", "108MP main"),
          _comparisonRow("Processor", "Exynos 1280", "Dimensity 6080"),
          _comparisonRow("Software", "4 yrs updates", "2 yrs updates"),
          _comparisonRow("Price", "₹16,999", "₹15,999"),
        ],
      ),
    );
  }

  Widget _deviceTile(String title) {
    return Column(
      children: [
        Container(
          height: 90,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _comparisonRow(String feature, String v1, String v2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 90, child: Text(feature, style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(v1)),
          Expanded(child: Text(v2, textAlign: TextAlign.right)),
        ],
      ),
    );
  }

  // ------------------------------
  // Store List
  // ------------------------------

  Widget _storeListCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 6, spreadRadius: 1, color: Colors.black12.withOpacity(0.05)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Nearby store selling products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),

          _storeTile("Croma", "Kukatpally, Hyderabad", "400m Away", "₹16,999"),
          const SizedBox(height: 14),

          _storeTile("Reliance Digital", "Kukatpally, Hyderabad", "1.2 Km Away", "₹16,999"),
          const SizedBox(height: 14),

          _storeTile("Poorvika Mobile", "Madhapur, Hyderabad", "2 Km Away", "₹17,299"),
        ],
      ),
    );
  }

  Widget _storeTile(String name, String loc, String distance, String price) {
    return Row(
      children: [
        Container(
          height: 70,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(loc, style: const TextStyle(color: Colors.black54)),
              Text(distance, style: const TextStyle(color: Colors.black45)),
            ],
          ),
        ),
        Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // ------------------------------
  // Bill Summary
  // ------------------------------

  Widget _billSummaryCard() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 6, spreadRadius: 1, color: Colors.black12.withOpacity(0.05)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Bill summary (1 item)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 14),

          _billRow("MRP", "₹17,999"),
          _billRow("Discount", "- ₹1000"),
          _billRow("MyHub Offer", "- ₹1000"),
          _billRow("Order Total", "₹15,999"),
          _billRow("Delivery Fee", "Free"),
          _billRow("Platform Fee", "₹99"),

          const Divider(height: 26),

          _billRow("Bill Total", "₹16,098", bold: true),
        ],
      ),
    );
  }

  Widget _billRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  // ------------------------------
  // Payment Success
  // ------------------------------

  Widget _successTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF7DF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        "Your payment of ₹16,348 is successful 🎉\nYour order has been confirmed with Croma.",
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  // ------------------------------
  // Tracking Timeline
  // ------------------------------

  Widget _trackingHeader() {
    return const Text(
      "Live Tracking",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _trackingTimeline() {
    return Column(
      children: [
        _trackItem(Icons.check_circle, Colors.green, "Booking Confirmed", "10 sec ago"),
        _trackItem(Icons.delivery_dining, Colors.blue, "Assigning Driver", "Just now"),
        _trackItem(Icons.location_on, Colors.blue, "Driver Arriving", "5 min away"),
        _trackItem(Icons.store, Colors.blue, "Pickup Location", "Madhapur • Sri Sai PG"),
        _trackItem(Icons.navigation, Colors.blue, "Trip Started", ""),
        _trackItem(Icons.check, Colors.blue, "Dropped Off", "Banajara Hills • Some Office"),
      ],
    );
  }

  Widget _trackItem(IconData icon, Color color, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              if (subtitle.isNotEmpty)
                Text(subtitle, style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------------
  // Buttons
  // ------------------------------

  Widget _trackingButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E77C9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text("View Full Tracking",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Text("Cancel Ride",
                style: TextStyle(color: Colors.red, fontSize: 16)),
          ),
        ),
      ],
    );
  }
}

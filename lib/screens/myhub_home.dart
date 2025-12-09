import 'package:flutter/material.dart';

class MyHubHome extends StatelessWidget {
  const MyHubHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("MyHub AI", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),  ),
        leading: IconButton(
          icon: const Icon(Icons.menu,color: Colors.blue,),
          onPressed: () {
            // Handle menu button press
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Menu pressed")),
            );
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          
           UserMessage(text: "I'm confused between Samsung Galaxy M34 and Redmi Note 13. Compare them.",backgroundColor: Colors.blue,textColor: Colors.white,),
          AssistantProgress(title: "Searching", subtitle: "Gathering Data"),
          AssistantMessage(
            text: "Sure! Here's a quick comparison to help you decide.",
            child: DeviceComparisonCard(),
          ),
          UserMessage(text: "I'll go with Galaxy M34.",backgroundColor: Colors.blue,textColor: Colors.white,),
          AssistantMessage(
            text:
                "If you want better battery and long-term software support, Samsung Galaxy M34 is the better choice. If you prefer a better camera, the Redmi Note 13 is good too. Which one would you like to go with?",
          ),
          UserMessage(text: "I'll go with Galaxy M34.",backgroundColor: Colors.blue,textColor: Colors.white,),
          AssistantMessage(
            text:
                "Great choice! Let me find the nearest Samsung stores at the best price.",
          ),
          AssistantProgress(
            title: "Checking",
            subtitle: "Nearby mobile stores..",
          ),
          AssistantMessage(child: StoreCard()),
          AssistantMessage(
            text:
                "list of other stores:\n- Reliance Digital - ₹16,999\n- Poorvika Mobile - ₹17,199\n\nWould you like to order it from Croma, or browse other stores?",
          ),

          AssistantProgress(
            title: "Perfect!",
            subtitle: "Placing your order...",
          ),
          AssistantMessage(child: BillSummaryCard()),
          AssistantMessage(
            child: UserMessage(
              text:
                  "Can I help you with anything else? If you want to check the delivery status, I can assist you with that. Or if you're interested, I can show you some mobile accessories for your new phone, like cases, tempered glass, chargers, etc.",
            ),
          ),
          AssistantMessage(
            text:
                "Your payment of ₹16,548 is successful! 🎉 Your order has been confirmed with Croma.",
          ),
          TrackingCard(),
        ],
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  const UserMessage({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.7, // 70% of screen width
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            text,
            style: TextStyle(color: textColor ?? Colors.black),
          ),
        ),
      ),
    );
  }
}


class AssistantMessage extends StatelessWidget {
  final String? text;
  final Widget? child;

  const AssistantMessage({super.key, this.text, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.support_agent, color: Colors.white),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (text != null)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                       border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(text!, style: TextStyle(color: Colors.black)),
                  ),
                if (child != null) child!,
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up_outlined,
                      size: 16.0,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4.0),
                    Icon(
                      Icons.thumb_down_outlined,
                      size: 16.0,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 4.0),
                    Icon(Icons.copy, size: 16.0, color: Colors.grey),
                    SizedBox(width: 4.0),
                    Icon(Icons.volume_up, size: 16.0, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AssistantProgress extends StatelessWidget {
  final String title;
  final String subtitle;

  const AssistantProgress({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.search, color: Colors.white),
        ),
        SizedBox(height: 8.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8.0),
                Text(subtitle, style: TextStyle(color: Colors.blue)),
                SizedBox(height: 15.0),
                LinearProgressIndicator(
                  backgroundColor: Colors.blue[600],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DeviceComparisonCard extends StatelessWidget {
  const DeviceComparisonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Device Comparison",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                'https://images.samsung.com/is/image/samsung/p6pim/hk_en/sm-m346bdbptgy/gallery/hk-en-galaxy-m34-5g-sm-m346-sm-m346bdbptgy-538449778?\$Q90_1248_936_F_PNG\$',
                width: 100,
                height: 150,
                fit: BoxFit.contain,
              ),
              Image.network(
                'https://media.wired.com/photos/65d8d4734e0562c5198a57e6/master/w_1600%2Cc_limit/Gear-2-Xiaomi_Redmi_Note_13_Pro_Plus_1-SOURCE-Simon-Hill.jpg',
                width: 100,
                height: 150,
                fit: BoxFit.contain,
              ),
            ],
          ),
          Table(
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                children: [
                  Text(
                    "Feature",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Galaxy M34",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Redmi Note 13",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text("Display", style: TextStyle(color: Colors.black)),
                  Text(
                    "6.5\" AMOLED 120Hz",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "6.67\" AMOLED 120Hz",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text("Battery", style: TextStyle(color: Colors.black)),
                  Text("6000 mAh", style: TextStyle(color: Colors.black)),
                  Text("5000 mAh", style: TextStyle(color: Colors.black)),
                ],
              ),
              TableRow(
                children: [
                  Text("Camera", style: TextStyle(color: Colors.black)),
                  Text("50MP main", style: TextStyle(color: Colors.black)),
                  Text("108MP main", style: TextStyle(color: Colors.black)),
                ],
              ),
              TableRow(
                children: [
                  Text("Processor", style: TextStyle(color: Colors.black)),
                  Text("Exynos 1280", style: TextStyle(color: Colors.black)),
                  Text(
                    "MediaTek Dimensity 6080",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text("Software", style: TextStyle(color: Colors.black)),
                  Text("4 yrs updates", style: TextStyle(color: Colors.black)),
                  Text("4 yrs updates", style: TextStyle(color: Colors.black)),
                ],
              ),
              TableRow(
                children: [
                  Text("Price", style: TextStyle(color: Colors.black)),
                  Text("₹16,999", style: TextStyle(color: Colors.black)),
                  Text("₹15,999", style: TextStyle(color: Colors.black)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StoreCard extends StatelessWidget {
  const StoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
         border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Near by store selling products",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Image.network(
                'https://www.shutterstock.com/shutterstock/photos/2538930125/display_1500/stock-photo-nashik-maharashtra-india-march-showroom-hoarding-displaying-the-croma-and-tata-logo-2538930125.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Croma",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Text("400m Away", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  Text(
                    "Kukatpally, Hyderabad...",
                    style: TextStyle(color: Colors.black),
                  ),
                   Text(
                    "Hyderabad...",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://images.samsung.com/is/image/samsung/p6pim/hk_en/sm-m346bdbptgy/gallery/hk-en-galaxy-m34-5g-sm-m346-sm-m346bdbptgy-538449778?\$Q90_1248_936_F_PNG\$',
                width: 100,
                height: 150,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 8.0),
              Text(
                "Galaxy M34",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    "₹16,999",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "₹19,999",
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BillSummaryCard extends StatelessWidget {
  const BillSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
         border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bill Summary (1 Item)",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Table(
            columnWidths: {0: FlexColumnWidth(3), 1: FlexColumnWidth(2)},
            children: [
              TableRow(
                children: [
                  Text("MRP", style: TextStyle(color: Colors.black)),
                  Text("₹17,999", style: TextStyle(color: Colors.black)),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    "Discount on MRP",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text("₹1,000", style: TextStyle(color: Colors.black)),
                ],
              ),
              TableRow(
                children: [
                  Text("My Hub", style: TextStyle(color: Colors.black)),
                  Text("-₹0.00", style: TextStyle(color: Colors.black)),
                ],
              ),
              TableRow(
                children: [
                  Text("Sub Total", style: TextStyle(color: Colors.black)),
                  Text("₹16,999", style: TextStyle(color: Colors.black)),
                ],
              ),
              TableRow(
                children: [
                  Text("GST", style: TextStyle(color: Colors.black)),
                  Text("₹989", style: TextStyle(color: Colors.black)),
                ],
              ),
              TableRow(
                children: [
                  Text("Platform Fee", style: TextStyle(color: Colors.black)),
                  Text("₹0.00", style: TextStyle(color: Colors.black)),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    "Bill Total",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "₹16,989",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TrackingCard extends StatelessWidget {
  const TrackingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header
          Row(
            children: [
              const Text(
                "Live Tracking",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Text(
                "3 minutes",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 2. Booking Confirmed + Arrives in
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Booking Has Been Confirmed",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                   border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Arrives in",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 3. Share OTP
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFF),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFFE3E8F0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Share OTP",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: List.generate(
                    4,
                    (_) => Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0066FF),
                        
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "4",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const SizedBox(height: 20),

          // Timeline
          _buildTimeline(),

          const SizedBox(height: 20),

          // Bottom Actions: SOS + Help + Phone
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.blue, width: 1.5),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.blue,
                      size: 20,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "SOS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                "Help & Support",
                style: TextStyle(color: Colors.black54),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F4FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.phone, color: Colors.blue, size: 24),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // View Full Tracking Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 4,
              ),
              child: const Text(
                "View Full Tracking",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Cancel Ride
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Cancel Ride",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final steps = [
      _TimelineStep("Booking Confirmed", "Just now", Colors.green),
      _TimelineStep("Driver Assigned", "10 sec ago", Colors.green),
      _TimelineStep("Driver Arriving", "3 min away", Colors.green),
      _TimelineStep("Pickup Location", "Madhapur - Sri Sai PG", Colors.green),
      _TimelineStep("Trip Started", "11:47 AM", Colors.green),
      _TimelineStep(
        "Dropped Off",
        "Banjara Hills - Sonic Graphics Ltd office",
        Colors.green,
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      separatorBuilder: (_, i) => _buildConnector(),
      itemBuilder: (_, i) {
        final step = steps[i];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDot(step.color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  if (step.subtitle != null)
                    Text(
                      step.subtitle!,
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: const Icon(Icons.check, color: Colors.white, size: 18),
    );
  }

  Widget _buildConnector() {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 2,
          color: Colors.green,
          margin: const EdgeInsets.only(left: 14),
        ),
      ),
    );
  }
}

class _TimelineStep {
  final String title;
  final String? subtitle;

  final Color color;

  _TimelineStep(this.title, this.subtitle, this.color);
}

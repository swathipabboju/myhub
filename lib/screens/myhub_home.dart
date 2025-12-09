import 'package:flutter/material.dart';
import '../widgets/background_animator.dart';
import '../utils/responsive.dart';

class MyHubHome extends StatelessWidget {
  const MyHubHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: BackgroundAnimator(frameDuration: Duration(milliseconds: 400), expand: true, fit: BoxFit.cover)),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                  child: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                      Expanded(child: Center(child: Text('MyHub AI', style: TextStyle(fontSize: Responsive.scale(context, 18), fontWeight: FontWeight.w600)))),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Searching card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.shade50)),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(color: Colors.blue.shade700, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.blue.shade100, blurRadius: 8, offset: const Offset(0,4))]),
                          child: const Icon(Icons.search, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Searching', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Responsive.scale(context, 16))),
                              const SizedBox(height: 4),
                              Text('Gathering Data', style: TextStyle(fontSize: Responsive.scale(context, 12), color: Colors.blue.shade300)),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(value: 0.6, color: Colors.blue.shade400, backgroundColor: Colors.blue.shade50),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Chat timeline and content cards
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: [
                      const SizedBox(height: 8),

                      // user message bubble (right)
                      Align(alignment: Alignment.centerRight, child: _UserBubble(text: "I'm confused between Samsung Galaxy M34 and Redmi Note 13. Compare them.")),
                      const SizedBox(height: 12),

                      // searching card (assistant)
                      _SearchingCard(),
                      const SizedBox(height: 12),

                      // assistant reply bubble
                      Align(alignment: Alignment.centerLeft, child: _AssistantBubble(text: "Sure! Here's a quick comparison to help you decide.")),
                      const SizedBox(height: 12),

                      // device comparison card (detailed)
                      _DeviceComparisonCard(),
                      const SizedBox(height: 12),

                      // action suggestion (buttons)
                      Align(alignment: Alignment.centerRight, child: _ActionButton(label: "I'll go with Galaxy M34")),
                      const SizedBox(height: 12),

                      // assistant follow-up
                      Align(alignment: Alignment.centerLeft, child: _AssistantBubble(text: "Great choice! Let me find the nearest stores offering Samsung Galaxy M34 at the best price.")),
                      const SizedBox(height: 12),

                      // product/store cards
                      _StoreProductCard(),
                      const SizedBox(height: 12),

                      // list of other stores
                      _OtherStoresList(),
                      const SizedBox(height: 12),

                      // order flow card (placed)
                      _OrderPlacedCard(),
                      const SizedBox(height: 12),

                      // live tracking card
                      _LiveTrackingCard(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// small UI components used in the timeline
class _UserBubble extends StatelessWidget {
  final String text;
  const _UserBubble({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: Responsive.wp(context, 0.78)),
      padding: EdgeInsets.symmetric(horizontal: Responsive.scale(context, 14), vertical: Responsive.scale(context, 12)),
      decoration: BoxDecoration(color: const Color(0xFF0B66C2), borderRadius: BorderRadius.circular(18)),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: Responsive.scale(context, 14))),
    );
  }
}

class _AssistantBubble extends StatelessWidget {
  final String text;
  const _AssistantBubble({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: Responsive.wp(context, 0.78)),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 6)]),
      child: Text(text, style: TextStyle(fontSize: Responsive.scale(context, 14))),
    );
  }
}

class _SearchingCard extends StatelessWidget {
  const _SearchingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 6)]),
      child: Row(children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.blue.shade700, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.search, color: Colors.white)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Searching', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Responsive.scale(context, 14))), const SizedBox(height: 4), Text('Gathering Data', style: TextStyle(color: Colors.blue.shade300, fontSize: Responsive.scale(context, 12))), const SizedBox(height: 8), LinearProgressIndicator(value: 0.65, color: Colors.blue.shade400, backgroundColor: Colors.blue.shade50)])),
      ]),
    );
  }
}

class _DeviceComparisonCard extends StatelessWidget {
  const _DeviceComparisonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 6)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Device Comparison", style: TextStyle(fontWeight: FontWeight.w700, fontSize: Responsive.scale(context, 16))),
        const SizedBox(height: 12),
        Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: Column(children: [
          Row(children: [Expanded(child: Text('Feature', style: TextStyle(fontWeight: FontWeight.w700))), Expanded(child: Center(child: Text('Galaxy M34', style: TextStyle(fontWeight: FontWeight.w700)))), Expanded(child: Center(child: Text('Redmi Note 13', style: TextStyle(fontWeight: FontWeight.w700))))]),
          const Divider(),
          _twoColumnRow('Display', '6.5" AMOLED\n120Hz', '6.67" AMOLED\n120Hz'),
          const SizedBox(height: 8),
          _twoColumnRow('Battery', '6000 mAh', '5000 mAh'),
          const SizedBox(height: 8),
          _twoColumnRow('Camera', '50MP main', '108MP main'),
          const SizedBox(height: 8),
          _twoColumnRow('Processor', 'Exynos 1280', 'MediaTek Dimensity 6080'),
        ]) )
      ]),
    );
  }

  Widget _twoColumnRow(String label, String left, String right) => Row(children: [Expanded(child: Text(label)), Expanded(child: Center(child: Text(left))), Expanded(child: Center(child: Text(right)))]);
}

class _ActionButton extends StatelessWidget {
  final String label;
  const _ActionButton({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: Responsive.wp(context, 0.7)),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E77C9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)), padding: const EdgeInsets.symmetric(vertical: 14)),
        child: Text(label, style: TextStyle(fontSize: Responsive.scale(context, 15))),
      ),
    );
  }
}

class _StoreProductCard extends StatelessWidget {
  const _StoreProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 6)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Near by store selling products', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Responsive.scale(context, 14))),
        const SizedBox(height: 12),
        Row(children: [
          Container(width: 80, height: 80, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade200), child: Center(child: Text('Img'))),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Croma', style: TextStyle(fontWeight: FontWeight.w700)), SizedBox(height: 6), Text('Kukatpally, Hyderabad', style: TextStyle(color: Colors.grey.shade600)), SizedBox(height: 6), Text('₹16,999', style: TextStyle(color: Colors.green.shade700))])),
          ElevatedButton(onPressed: () {}, child: const Text('Buy'))
        ])
      ]),
    );
  }
}

class _OtherStoresList extends StatelessWidget {
  const _OtherStoresList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('List of other stores:', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text('• Reliance Digital — ₹16,999'),
          Text('• Poorvika Mobile — ₹17,199'),
        ],
      ),
    );
  }
}

class _OrderPlacedCard extends StatelessWidget {
  const _OrderPlacedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Perfect!', style: TextStyle(fontWeight: FontWeight.w700, fontSize: Responsive.scale(context, 16))),
          const SizedBox(height: 8),
          Text('Placing your order...'),
        ],
      ),
    );
  }
}

class _LiveTrackingCard extends StatelessWidget {
  const _LiveTrackingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Live Tracking', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Booking Confirmed', style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(height: 6),
                    Text('3 minutes ago', style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                child: Text('3 min', style: TextStyle(color: Colors.blue.shade700)),
              )
            ],
          )
        ],
      ),
    );
  }
}

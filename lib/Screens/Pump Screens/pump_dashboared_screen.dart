import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petrol Pump Station 1'),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 251, 251),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Expanded(
                child: Card(
                  elevation: 15,
                  shadowColor: Colors.teal,
                  child: Image.asset(
                    "assets/pump_station.jpg",
                    fit: BoxFit.fitWidth,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: StaggeredGridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                padding: const EdgeInsets.all(16.0),
                staggeredTiles: const [
                  StaggeredTile.fit(2),
                  StaggeredTile.fit(2),
                  StaggeredTile.fit(4),
                  StaggeredTile.fit(4),
                ],
                children: [
                  AnimatedDashboardCard(
                    title: 'Stocks',
                    value: '100 items',
                    color: Colors.blue.shade400,
                    onTap: () {
                      Navigator.pushNamed(context, '/stock');
                    },
                  ),
                  AnimatedDashboardCard(
                    title: 'Credit/Debit',
                    value: '\$5,000',
                    color: Colors.green.shade400,
                    onTap: () {
                      Navigator.pushNamed(context, '/credit_debit');
                    },
                  ),
                  AnimatedDashboardCard(
                    title: 'Daily Expense',
                    value: '\$500',
                    color: Colors.orange.shade400,
                    onTap: () {
                      Navigator.pushNamed(context, '/daily_expense');
                    },
                  ),
                  AnimatedDashboardCard(
                    title: 'Profit/Sales',
                    value: '\$2,500',
                    color: Colors.purple.shade400,
                    onTap: () {
                      Navigator.pushNamed(context, '/profit_sales');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedDashboardCard extends StatefulWidget {
  final String title;
  final String value;
  final Color color;
  final VoidCallback onTap;

  const AnimatedDashboardCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedDashboardCardState createState() => _AnimatedDashboardCardState();
}

class _AnimatedDashboardCardState extends State<AnimatedDashboardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: widget.color,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  widget.value,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

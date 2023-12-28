import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/sliver.dart';
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive UI logic
          if (constraints.maxWidth < 600) {
            // Mobile layout
            return buildMobileLayout(context);
          } else {
            // Web layout
            return buildWebLayout(context);
          }
        },
      ),
    );
  }

  Widget buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildHeader(),
          const SizedBox(height: 30),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 290,
            ),
            child: buildStaggeredGridView(context),
          ),
        ],
      ),
    );
  }

  Widget buildWebLayout(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Website header
        const SliverAppBar(
          backgroundColor: Colors.blue, // Set your header background color
          expandedHeight: 100.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Petrol Pump Station 1',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
        ),
        // Main content area
        SliverPadding(
          padding: const EdgeInsets.only(
              top: 50, left: 25, right: 25), // Add padding to create space
          sliver: SliverStaggeredGrid.countBuilder(
            crossAxisCount: 4,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            staggeredTileBuilder: (int index) => const StaggeredTile.fit(2),
            itemCount: 4, // Replace with your actual item count
            itemBuilder: (BuildContext context, int index) {
              // Define titles and values for each card
              List<String> titles = [
                'Stocks',
                'Credit/Debit',
                'Daily Expense',
                'Daily Overview'
              ];
              List<String> values = [
                '100 items',
                '\$5,000',
                '\$500',
                '\$2,500'
              ];

              return WebCard(
                title: titles[index], // Use the corresponding title
                value: values[index], // Use the corresponding value
                color: Colors.blue, // Replace with your color
                onTap: () {
                  // Replace with your navigation logic
                  switch (index) {
                    case 0:
                      Navigator.pushNamed(context, '/stock');
                      break;
                    case 1:
                      // Navigator.pushNamed(context, '/credit_debit');
                      Navigator.pushNamed(context, '/userscreen');
                      break;
                    case 2:
                      Navigator.pushNamed(context, '/daily_expense');
                      break;
                    case 3:
                      Navigator.pushNamed(context, '/daily_overview');
                      break;
                  }
                },
              );
            },
          ),
        ),
        // Website footer
        const SliverPadding(
          padding: EdgeInsets.only(
            top: 100,
          ), // Add padding to create space
          sliver: SliverAppBar(
            backgroundColor: Colors.blue, // Set your footer background color
            expandedHeight: 50.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '© 2023 Petrol Pump Station. All rights reserved.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHeader() {
    return Align(
      alignment: Alignment.topLeft,
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
    );
  }

  Widget buildStaggeredGridView(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 500.0, // Adjust the maximum height as needed
        ),
        child: StaggeredGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          padding: const EdgeInsets.all(16.0),
          staggeredTiles: const [
            StaggeredTile.fit(1),
            StaggeredTile.fit(1),
            StaggeredTile.fit(2),
            StaggeredTile.fit(2),
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
                Navigator.pushNamed(context, '/userscreen');
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
              title: 'Daily Overview',
              value: '\$2,500',
              color: Colors.purple.shade400,
              onTap: () {
                Navigator.pushNamed(context, '/daily_overview');
              },
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

class WebCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final VoidCallback onTap;

  const WebCard({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

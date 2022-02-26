import 'package:flutter/material.dart';

class AdvancedTabDemoState extends State with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: CustomTabIndicator(
            tabController: tabController,
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: BouncingScrollPhysics(),
        children: [
          Center(child: Text('tab 1')),
          Center(child: Text('tab 2')),
          Center(child: Text('tab 3')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabController.index,
        onTap: (value) {
          tabController.animateTo(value);
          tabController.addListener(() {
            setState(() {});
          });
        },
        unselectedItemColor: Colors.black26,
        selectedItemColor: Colors.orange,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        ],
      ),
    );
  }
}

class CustomTabIndicator extends StatelessWidget {
  final TabController tabController;

  CustomTabIndicator({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('updated');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < tabController.length; i += 1)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: tabController.index == i ? Colors.orange : Colors.grey,
              ),
              width: 15,
              height: 15,
            ),
          ),
      ],
    );
  }
}

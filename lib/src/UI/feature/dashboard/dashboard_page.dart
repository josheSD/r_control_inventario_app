import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard_provider.dart';

class DashboardPage extends StatefulWidget {

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    // TODO: implement initState
    print('INIT DASHBOARD');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('DISPOSE DASHBOARD');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    return SafeArea(child: Container(child: Text('Dashboard'),));
  }
}
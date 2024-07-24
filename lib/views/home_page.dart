import 'package:flutter/material.dart';
import 'package:sync_package/constants/custom_colors.dart';
import 'package:sync_package/constants/custom_icons.dart';
import 'package:sync_package/routes/routes.dart';
import 'package:sync_package/views/view_data.dart';
import 'package:sync_package/widgets/buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Key _viewDataKey = UniqueKey();

  void _addData() async {
    final result = await Navigator.pushNamed(context, Routes.addDataForm);
    if (result == true) {
      _refreshData();
    }
  }

  void _refreshData() {
    setState(() {
      _viewDataKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      floatingActionButton: CustomButtons.addButton(onPressed: _addData),
      appBar: AppBar(
        backgroundColor: CustomColors.appBarColor,
        foregroundColor: CustomColors.appBarFontColor,
        title: const Row(
          children: [
            CustomIcons.employee,
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshData();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ViewData(key: _viewDataKey),
          ),
        ),
      ),
    );
  }
}

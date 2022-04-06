import 'package:flutter/material.dart';
import 'package:portaventory/pages/add_item/add_item_view_binding.dart';
import 'package:portaventory/pages/home/home_view_controller.dart';
import 'package:portaventory/pages/routes/app_pages.dart';
import '../../helpers/exported_packages.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Portaventory',
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.addItem,
                arguments: AddItemArguments(database: controller.database)),
            icon: const Icon(Icons.add),
            tooltip: 'Add Item',
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // QrImage(
          //   data: 'This is a simple QR code',
          //   version: QrVersions.auto,
          //   size: 320,
          //   gapless: false,
          // ),
          Expanded(
            child: Obx(() {
              return ListView.separated(
                  itemBuilder: (cntx, index) {
                    return ListTile(
                      title: Text(controller.items[index].name ?? 'N/A'),
                      trailing: const Icon(Icons.more_vert),
                    );
                  },
                  separatorBuilder: (a, b) {
                    return const Divider();
                  },
                  itemCount: controller.items.length);
            }),
          ),
          TextButton(
            onPressed: () {
              Get.toNamed(
                Routes.scanner,
              );
            },
            child: Text('SCAN QR CODE'),
          ),
        ],
      ),
    );
  }
}

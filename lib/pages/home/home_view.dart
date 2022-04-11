import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:portaventory/entity/item/item.dart';
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
            onPressed: () async {
              final result = await Get.toNamed(Routes.addItem,
                  arguments: AddItemArguments(database: controller.database));

              print('++++>  $result');
              if (result == 'success') {
                MotionToast.success(
                        description: const Text("Item Added!"), width: 300)
                    .show(context);
              }
            },
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
              return Scrollbar(
                child: ListView.separated(
                    itemBuilder: (cntx, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        child: ListTile(
                          title: Text(controller.items[index].name ?? 'N/A'),
                          subtitle: Text(
                              controller.items[index].description ?? 'N/A'),
                          trailing:
                              controller.items[index].type == ItemType.storage
                                  ? const Icon(Icons.inventory_2)
                                  : const SizedBox(),
                        ),
                        onDismissed: (_) async {
                          await controller.removeItem(controller.items[index]);
                        },
                        background: Container(
                          color: Colors.red,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (a, b) {
                      return const Divider();
                    },
                    itemCount: controller.items.length),
              );
            }),
          ),
          TextButton(
            onPressed: () async {
              Get.toNamed(
                Routes.scanner,
              );
            },
            child: const Text('SCAN QR CODE'),
          ),
        ],
      ),
    );
  }
}

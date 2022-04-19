import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:portaventory/components/form_fields/textfield.dart';
import 'package:portaventory/entity/item/item.dart';
import 'package:portaventory/pages/add_item/add_item_view_controller.dart';
import '../../helpers/exported_packages.dart';

class AddItemView extends GetView<AddItemViewController> {
  const AddItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Add Item',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => DropdownButton<String>(
                  isExpanded: true,
                  value: controller.type.value,
                  icon: const Icon(Icons.arrow_downward),
                  hint: const Text('Type'),
                  onChanged: (String? newValue) {
                    controller.type.value = newValue!;
                  },
                  items: ItemType.values
                      .map((e) => e.name)
                      .toList()
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value.capitalizeFirst!),
                    );
                  }).toList(),
                ),
              ),
              TextfieldWidget(
                controller: controller.name,
                placeholder: 'Name',
                helperText: 'Input name of item/storage',
                validator: MultiValidator([
                  RequiredValidator(errorText: '* Required'),
                ]),
              ),
              TextfieldWidget(
                controller: controller.description,
                placeholder: 'Description',
                helperText: 'Input description of item/storage',
                validator: MultiValidator([
                  RequiredValidator(errorText: '* Required'),
                ]),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    try {
                      await controller.saveItem();
                      Get.back(result: 'success');
                    } catch (error) {
                      printError(info: error.toString());
                      MotionToast.error(description: Text(error.toString()))
                          .show(context);
                    }
                  }
                },
                icon: const Icon(Icons.save, size: 18),
                label: const Text("SAVE"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

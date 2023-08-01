
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_project/expenses_module/controller/add_expense_controller.dart';
import 'package:test_project/expenses_module/model/expense_model.dart';

class AddExpensesScreen extends GetView<AddExpenseController> {
  final categoryFormKey = new GlobalKey<FormState>();

  AddExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddExpenseController>(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: controller.formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _titleTextField(),
                    _amountTextField(),
                    _categoryDropDown(),
                    _submitButton(),
                  ]),
            ),
          ),
        );
      }
    );
  }

  _titleTextField() =>  TextFormField(
    controller: controller.titleController,
    textInputAction: TextInputAction.next,
    focusNode: controller.titleNode,
    keyboardType: TextInputType.text,
    decoration: const InputDecoration(
      hintText: "Enter title",
      label: Text("Title"),
    ),
    validator: (input) => (controller.title.isEmpty)
        ? 'Please enter something'
        : null,
    onChanged: (input) => controller.title = input!,
  );

  _amountTextField() => TextFormField(
    controller: controller.amountController,
    textInputAction: TextInputAction.next,
    focusNode: controller.amountNode,
    keyboardType: TextInputType.number,
    maxLength: 6,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    decoration: const InputDecoration(
      hintText: "Enter Amount",
      counterText: "",
      label: Text("Amount"),
    ),
    validator: (input) => (controller.amount.isEmpty)
        ? 'Please enter something'
        : null,
    onChanged: (input) => controller.amount = input!,
  );

  _categoryDropDown() => Container(
    child: Column(children: [
      Container(
        padding: const EdgeInsets.only(
            left: 12, right: 12, top: 17, bottom: 10),
        child: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            controller.isShow = !controller.isShow;
            controller.runExpandCheck();
            controller.update();
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.optionItemSelected.title,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Icon(
                controller.isShow
                    ? Icons.arrow_drop_down
                    : Icons.arrow_right,
                // size: 25,
              ),
            ],
          ),
        ),
      ),
      Divider(color: Colors.grey.shade400, height: 1),
      const SizedBox(
        height: 5,
      ),
      SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: controller.animation,
          child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 10),
              height: dropListModel.listOptionItems.length < 5 ? dropListModel.listOptionItems.length*30: 5*30,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Theme.of(Get.context!).dialogBackgroundColor,
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 4,
                      color: Colors.black26,
                      offset: Offset(0, 4))
                ],
              ),
              child: Scrollbar(
                  child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus
                              ?.unfocus();
                          controller.optionItemSelected =
                          dropListModel
                              .listOptionItems[index];
                          controller.isShow = false;
                          controller.expandController
                              .reverse();
                          controller.category =
                              controller.optionItemSelected.id;
                          debugPrint(controller.category.toString());
                          controller.update();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          child: Text(
                            dropListModel
                                .listOptionItems[index].title,
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const Divider(),
                      itemCount:
                      dropListModel.listOptionItems.length))))
    ]),
  );

  _submitButton() => InkWell(
    onTap: () {
      controller.submit();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "Submit",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    ),
  ).paddingSymmetric(vertical: 30);
}

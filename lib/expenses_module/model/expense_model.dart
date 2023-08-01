class ExpenseModel{

  String title;
  String category;
  double amount;

  ExpenseModel({required this.title,required this.category, required this.amount});
}

DropListModel dropListModel = DropListModel([
  OptionItem(id: 1, title: "Food"),
  OptionItem(id: 2, title: "Transportation"),
  OptionItem(id: 3, title: "Utilities"),
  OptionItem(id: 4, title: "Shopping"),
  OptionItem(id: 5, title: "Grocery"),
  OptionItem(id: 6, title: "Entertainment"),
  OptionItem(id: 7, title: "Vacation"),
  OptionItem(id: 8, title: "Housing"),
  OptionItem(id: 9, title: "Laundry"),
  OptionItem(id: 10, title: "Others"),
]);


class DropListModel {
  DropListModel(this.listOptionItems);

  final List<OptionItem> listOptionItems;
}

class OptionItem {
  final int id;
  final String title;

  OptionItem({required this.id, required this.title});
}


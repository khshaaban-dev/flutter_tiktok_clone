import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'custom_message_feild.dart';

searchToFindUser({
  required BuildContext context,
  required String title,
}) {
  showMaterialModalBottomSheet(
      animationCurve: Curves.linear,
      duration: const Duration(milliseconds: 600),
      context: context,
      builder: (context) {
        return SearchWidget(
          title: title,
        );
      });
}

typedef ShowBottom = void Function(int index);

class SearchWidget extends StatefulWidget {
  final String title;
  const SearchWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final List _elements = [
    {'name': 'John', 'group': 'A', 'isSelected': false},
    {'name': 'Will', 'group': 'B', 'isSelected': false},
    {'name': 'Beth', 'group': 'A', 'isSelected': false},
    {'name': 'Miranda', 'group': 'B', 'isSelected': false},
    {'name': 'Mike', 'group': 'C', 'isSelected': false},
    {'name': 'Danny', 'group': 'C', 'isSelected': false},
    {'name': 'Will', 'group': 'B', 'isSelected': false},
    {'name': 'Beth', 'group': 'A', 'isSelected': false},
    {'name': 'Miranda', 'group': 'B', 'isSelected': false},
    {'name': 'Mike', 'group': 'C', 'isSelected': false},
    {'name': 'Danny', 'group': 'C', 'isSelected': false},
    {'name': 'Will', 'group': 'B', 'isSelected': false},
    {'name': 'Beth', 'group': 'A', 'isSelected': false},
    {'name': 'Miranda', 'group': 'B', 'isSelected': false},
    {'name': 'Mike', 'group': 'C', 'isSelected': false},
    {'name': 'Danny', 'group': 'C', 'isSelected': false},
    {'name': 'Will', 'group': 'B', 'isSelected': false},
    {'name': 'Beth', 'group': 'A', 'isSelected': false},
    {'name': 'Miranda', 'group': 'B', 'isSelected': false},
    {'name': 'Mike', 'group': 'C', 'isSelected': false},
    {'name': 'Danny', 'group': 'C', 'isSelected': false},
    {'name': 'Will', 'group': 'B', 'isSelected': false},
    {'name': 'Beth', 'group': 'A', 'isSelected': false},
    {'name': 'Miranda', 'group': 'B', 'isSelected': false},
    {'name': 'Mike', 'group': 'C', 'isSelected': false},
    {'name': 'Danny', 'group': 'C', 'isSelected': false},
    {'name': 'Will', 'group': 'B', 'isSelected': false},
    {'name': 'Beth', 'group': 'A', 'isSelected': false},
    {'name': 'Miranda', 'group': 'B', 'isSelected': false},
    {'name': 'Mike', 'group': 'C', 'isSelected': false},
    {'name': 'Danny', 'group': 'C', 'isSelected': false},
  ];
  bool showBottomMessageErea = false;
  List<int> users = [];

  void showBottom(int index) {
    if (!showBottomMessageErea) {
      setState(() {
        showBottomMessageErea = true;
      });
      users.add(index);
    } else {
      if (users.contains(index)) {
        users.remove(index);
      } else {
        users.add(index);
      }
      if (users.isEmpty) {
        setState(() {
          showBottomMessageErea = false;
        });
      }
    }
  }

  void toggleSelectedItem(int index) {
    setState(() {
      _elements[index]['isSelected'] = !_elements[index]['isSelected'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(20),
          topEnd: Radius.circular(20),
        ),
      ),
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top,
      width: 200,
      child: bottomSheet(
        context: context,
        title: widget.title,
        showBottom: showBottom,
        toggleSelectedItem: toggleSelectedItem,
      ),
    );
  }

  Widget bottomSheet({
    required BuildContext context,
    required String title,
    required ShowBottom showBottom,
    required ShowBottom toggleSelectedItem,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const SizedBox(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
              ))
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 2,
          ),
          child: TextField(
            decoration: InputDecoration(
              // contentPadding: EdgeInsets.zero,
              hintText: 'Search',
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              fillColor: Colors.grey[200],
              filled: true,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: GroupedListView<dynamic, String>(
            key: const PageStorageKey('seatch list'),
            physics: const BouncingScrollPhysics(),
            elements: _elements,
            padding: EdgeInsets.zero,
            groupBy: (element) => element['group'],
            groupSeparatorBuilder: (String groupByValue) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    top: 12,
                    bottom: 4,
                  ),
                  child: Text(
                    'groupBy group name',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    groupByValue,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            itemBuilder: (context, dynamic element) => title == 'Send to'
                ? SearchUserItem(
                    index: _elements.indexOf(element),
                    title: element['name'],
                    showBottom: showBottom,
                    toggleSelectedItem: toggleSelectedItem,
                    isSelected: element['isSelected'])
                : ListTile(
                    onTap: () {
                      // Navigator.pop(context);
                      // Navigator.pushNamed(context, ChatMessages.route);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[400],
                    ),
                    title: Text(
                      element['name'],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
            itemComparator: (item1, item2) =>
                item1['name'].compareTo(item2['name']), // optional
            // useStickyGroupSeparators: true, // optional
            floatingHeader: true, // optional
            order: GroupedListOrder.ASC, // optional
          ),
        ),
        customMessageFeild(
          context: context,
          showBottomMessageErea: showBottomMessageErea,
        ),
      ],
    );
  }
}

class SearchUserItem extends StatelessWidget {
  final String title;
  final ShowBottom showBottom;
  final ShowBottom toggleSelectedItem;
  final int index;
  final bool isSelected;

  const SearchUserItem({
    Key? key,
    required this.title,
    required this.showBottom,
    required this.toggleSelectedItem,
    required this.index,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(title),
      selectedColor: Colors.grey,
      onTap: () {
        // setState(() {
        //   isSelected = !isSelected;
        // });
        showBottom(index);
        toggleSelectedItem(index);
        // Navigator.pop(context);
        // Navigator.pushNamed(context, ChatMessages.route);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.grey[400],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: customRadioButoon(
        value: isSelected,
      ),
    );
  }
}

Widget customRadioButoon({
  required bool value,
}) {
  return Container(
    decoration: BoxDecoration(
      color: value ? Colors.red : null,
      shape: BoxShape.circle,
      border: Border.all(
        width: 1,
        color: value ? Colors.transparent : Colors.grey,
      ),
    ),
    height: 20.w,
    width: 20.w,
    child: value
        // ignore: prefer_const_constructors
        ? Icon(Icons.done, color: Colors.white, size: 18.sp)
        : null,
  );
}

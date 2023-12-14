import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:newadbee/core/colors/colors.dart';
import 'package:newadbee/core/constants/constants.dart';
import 'package:newadbee/core/fonts/fonts.dart';

customSearchDropDown(
    {required String title,
    required dynamic icon,
    required BuildContext context,
    required List<String> items,
    required TextEditingController textEditingController,
    required String? selectedValue,
    bool? prefix,
    bool? isDistrict,
    String? errorText,
    required void Function(String?)? onChanged}) {
  return Padding(
    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
    child: SizedBox(
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<String>(
          isDense: true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              hintStyle: KFont().hintTextStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: kGreyBlackColor)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: kGreyBlackColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(color: kGreyBlackColor),
              )),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return errorText;
            }
            return null;
          },
          alignment: prefix != true
              ? Alignment(-0.71, 0)
              : AlignmentDirectional.centerStart,
          iconStyleData: IconStyleData(
            iconSize: 30,
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 23,
                color: kGrey,
              ),
            ),
          ),
          isExpanded: true,
          hint: Row(
            children: [
              prefix == true
                  ? icon
                  : SizedBox(),
              prefix == true ? kWidth10 : kWidth20,
              Text(
                title,
                style: KFont().hintTextStyle,
              ),
            ],
          ),
          items: items
              .toSet()
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: onChanged,
          buttonStyleData: ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: 200,
          ),
          dropdownStyleData: const DropdownStyleData(maxHeight: 200),
          menuItemStyleData: const MenuItemStyleData(height: 40),
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              final searchLower = searchValue.toLowerCase();
              final itemlLower = item.value.toString().toLowerCase();
              return itemlLower.contains(searchLower);
            },
          ),
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
        ),
      ),
    ),
  );
}

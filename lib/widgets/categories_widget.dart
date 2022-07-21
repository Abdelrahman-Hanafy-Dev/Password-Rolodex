import 'package:flutter/material.dart';
import 'package:password_manager_app/constants.dart';
import 'package:password_manager_app/engines/engines.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  final VoidCallback allCategoriesAction;
  final void Function(int) singleCategoriesAction;

  const CategoriesList(
      {Key? key,
      required this.allCategoriesAction,
      required this.singleCategoriesAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoriesEngine>(context);
    return SizedBox(
      height: 70.0,
      child: ListView.builder(
        itemCount: kPasswordCategories.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                children: [
                  _CategoryButton(
                    buttonText: 'All Categories',
                    buttonColor: (provider.currentCategory == -1)
                        ? const Color(0xFFFECBB1)
                        : Colors.white,
                    buttonTextColor: (provider.currentCategory == -1)
                        ? const Color(0xFFA27E83)
                        : const Color(0xFF707070),
                    onPressedAction: () {
                      provider.currentCategory = -1;
                      allCategoriesAction();
                    },
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  _CategoryButton(
                    buttonText: kPasswordCategories[index],
                    buttonColor: (provider.currentCategory == index)
                        ? const Color(0xFFFECBB1)
                        : Colors.white,
                    buttonTextColor: (provider.currentCategory == index)
                        ? const Color(0xFFA27E83)
                        : const Color(0xFF707070),
                    onPressedAction: () {
                      provider.currentCategory = index;
                      singleCategoriesAction(index);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: _CategoryButton(
                buttonText: kPasswordCategories[index],
                buttonColor: (provider.currentCategory == index)
                    ? const Color(0xFFFECBB1)
                    : Colors.white,
                buttonTextColor: (provider.currentCategory == index)
                    ? const Color(0xFFA27E83)
                    : const Color(0xFF707070),
                onPressedAction: () {
                  provider.currentCategory = index;
                  singleCategoriesAction(index);
                },
              ),
            );
          }
        },
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onPressedAction;

  const _CategoryButton(
      {Key? key,
      required this.buttonText,
      required this.buttonColor,
      required this.buttonTextColor,
      required this.onPressedAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 7.0),
      child: TextButton(
        child: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: 17.0,
          ),
        ),
        onPressed: onPressedAction,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: buttonColor,
      ),
    );
  }
}

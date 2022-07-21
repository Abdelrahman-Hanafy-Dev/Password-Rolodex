import 'package:flutter/material.dart';
import 'package:password_manager_app/constants.dart';

class MainButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final Color buttonTextColor;
  final Color splashHighlightColor;
  final VoidCallback onPressed;

  const MainButton({
    Key? key,
    required this.buttonColor,
    required this.buttonText,
    required this.onPressed,
    required this.buttonTextColor,
    required this.splashHighlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: Material(
          child: InkWell(
            highlightColor: splashHighlightColor,
            splashColor: splashHighlightColor.withOpacity(0.5),
            onTap: onPressed,
            child: Ink(
              width: double.infinity,
              height: 50.0,
              color: buttonColor,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: buttonTextColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDropDownButton extends StatefulWidget {
  final List<String> items;
  final void Function(String?) onChangedAction;

  const CustomDropDownButton({
    Key? key,
    required this.items,
    required this.onChangedAction,
  }) : super(key: key);

  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF5f72be),
              Color(0xFF9921e8),
            ],
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue;
                    });
                    widget.onChangedAction(newValue);
                  },
                  items: widget.items.map(buildMenuItem).toList(),
                  isExpanded: true,
                  iconSize: 40.0,
                  hint: const Text(
                    "Choose category",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB2AEBA),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem<String>(
    value: item,
    child: Text(
      item,
      style: const TextStyle(
        color: kSecondaryTextColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class IosBackButton extends StatelessWidget {
  final VoidCallback onBackButtonPressed;

  const IosBackButton({Key? key, required this.onBackButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
          onPressed: onBackButtonPressed,
          child: const Icon(
            Icons.arrow_back,
            size: 30.0,
            color: Colors.white,
          ),
          style: TextButton.styleFrom(
            primary: Colors.grey,
            backgroundColor: Colors.transparent,
          ),
        ),
        alignment: Alignment.center,
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          border: Border.all(
            color: const Color(0xFF848484),
            width: 1.0,
          ),
        ));
  }
}

class RoundedSquareButton extends StatelessWidget {
  final IconData buttonIcon;
  final Color buttonColor;
  final VoidCallback onPressedAction;

  const RoundedSquareButton({
    Key? key,
    required this.buttonIcon,
    required this.buttonColor,
    required this.onPressedAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Material(
          child: InkWell(
            onTap: onPressedAction,
            child: Ink(
              height: 65.0,
              width: 65.0,
              color: buttonColor,
              child: Icon(
                buttonIcon,
                color: kMainColor,
                size: 30.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

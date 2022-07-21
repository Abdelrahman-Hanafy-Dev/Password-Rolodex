import 'package:flutter/material.dart';
import 'package:password_manager_app/engines/categories_section_engine.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChangedAction;
  final TextEditingController controller;

  const EmailInput({
    Key? key,
    required this.hintText,
    required this.onChangedAction,
    required this.controller,
  }) : super(key: key);

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
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            cursorColor: const Color(0xFF4E3974),
            style: const TextStyle(
              color: Color(0xFF4E3974),
              fontSize: 20.0,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Color(0xFF4E3974),
                size: 30.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.0),
              ),
              fillColor: const Color(0xFFFDFAFF),
              filled: true,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFB2AEBA),
              ),
            ),
            onChanged: (newValue) {
              onChangedAction(newValue);
            },
          ),
        ),
      ),
    );
  }
}

class PasswordInput extends StatefulWidget {
  final String hintText;
  final Function(String) onChangedAction;
  final TextEditingController controller;

  const PasswordInput({
    Key? key,
    required this.hintText,
    required this.onChangedAction,
    required this.controller,
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool shouldObscure = true;

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
          child: TextField(
            controller: widget.controller,
            obscureText: shouldObscure,
            cursorColor: const Color(0xFF4E3974),
            style: const TextStyle(
              color: Color(0xFF4E3974),
              fontSize: 20.0,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF4E3974),
                size: 30.0,
              ),
              suffixIcon: InkWell(
                child: Icon(
                  Icons.visibility,
                  color: shouldObscure
                      ? const Color(0xFFB2AEBA)
                      : const Color(0xFF4E3974),
                  size: 30.0,
                ),
                onTap: () {
                  setState(() {
                    if (shouldObscure == true) {
                      shouldObscure = false;
                    } else {
                      shouldObscure = true;
                    }
                  });
                },
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.0),
              ),
              fillColor: const Color(0xFFFDFAFF),
              filled: true,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFB2AEBA),
              ),
            ),
            onChanged: (newValue) {
              widget.onChangedAction(newValue);
            },
          ),
        ),
      ),
    );
  }
}

class StringInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChangedAction;
  final IconData icon;
  final TextEditingController controller;

  const StringInput(
      {Key? key,
      required this.hintText,
      required this.onChangedAction,
      required this.icon,
      required this.controller})
      : super(key: key);

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
          child: TextField(
            controller: controller,
            cursorColor: const Color(0xFF4E3974),
            style: const TextStyle(
              color: Color(0xFF4E3974),
              fontSize: 20.0,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: const Color(0xFF4E3974),
                size: 30.0,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15.0),
              ),
              fillColor: const Color(0xFFFDFAFF),
              filled: true,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFB2AEBA),
              ),
            ),
            onChanged: (newValue) {
              onChangedAction(newValue);
            },
          ),
        ),
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  final void Function(String) onChangeAction;

  const SearchField({Key? key, required this.onChangeAction}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    CategoriesEngine provider = Provider.of<CategoriesEngine>(context);
    return TextField(
      cursorColor: const Color(0xFF4E3974),
      style: const TextStyle(
        color: Color(0xFF4E3974),
        fontSize: 20.0,
      ),
      decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.search,
          color: Color(0xFFBBBBBB),
          size: 30.0,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
        fillColor: const Color(0xFFFDFAFF),
        filled: true,
        hintText: 'Search "Passwords"',
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFFB2AEBA),
        ),
      ),
      onChanged: (newValue) {
        provider.currentCategory = -1;
        widget.onChangeAction(newValue);
      },
    );
  }
}

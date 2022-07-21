import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_manager_app/constants.dart';
import 'package:password_manager_app/engines/engines.dart';
import 'package:provider/provider.dart';

class CredentialCard extends StatelessWidget {
  final String title;
  final String username;
  final VoidCallback onCopyPressed;
  final VoidCallback onDeletePressed;

  const CredentialCard(
      {Key? key,
      required this.title,
      required this.username,
      required this.onCopyPressed,
      required this.onDeletePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardEngine>(context);

    return GestureDetector(
      onLongPress: () {
        provider.toggleFlag();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        height: 75.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              const _IconContainer(),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: kMainColor,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        username,
                        style: const TextStyle(
                          color: Color(0xFF484848),
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              !provider.shouldDelete
                  ? _CopyIcon(onCopyPressed: onCopyPressed)
                  : _DeleteIcon(onDeletePressed: () {
                      onDeletePressed();
                      provider.toggleFlag();
                    }),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconContainer extends StatelessWidget {
  const _IconContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        color: kDarkMainColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: const Icon(
        Icons.lock,
        color: kButtonColor,
        size: 40.0,
      ),
    );
  }
}

class _CopyIcon extends StatelessWidget {
  final VoidCallback onCopyPressed;

  const _CopyIcon({Key? key, required this.onCopyPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCopyPressed,
      child: Ink(
        color: Colors.transparent,
        child: const Icon(
          Icons.copy,
          color: kMainColor,
          size: 40.0,
        ),
      ),
    );
  }
}

class _DeleteIcon extends StatelessWidget {
  final VoidCallback onDeletePressed;

  const _DeleteIcon({Key? key, required this.onDeletePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDeletePressed,
      child: Ink(
        color: Colors.transparent,
        child: const Icon(
          Icons.delete_outline,
          color: Colors.red,
          size: 40.0,
        ),
      ),
    );
  }
}

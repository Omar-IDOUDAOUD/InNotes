import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:innotes/model/pagination.dart';

class ErrorCard extends StatefulWidget {
  const ErrorCard(
      {super.key,
      required this.type,
      required this.error,
      required this.onRety});
  final PaginationErrorTypes type;
  final String? error;
  final VoidCallback onRety;

  @override
  State<ErrorCard> createState() => _ErrorCardState();
}

class _ErrorCardState extends State<ErrorCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.redAccent.withOpacity(.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              widget.type == PaginationErrorTypes.connectionError
                  ? FluentIcons.wifi_off_24_regular
                  : FluentIcons.error_circle_24_regular,
              color: Colors.redAccent,
            ),
            // if (widget.type == PaginationErrorTypes.unknownError)
            //   Text(
            //     widget.error!,
            //     style: Theme.of(context)
            //         .textTheme
            //         .bodySmall!
            //         .copyWith(color: Colors.redAccent),
            //   ),
            TextButton(
              onPressed: widget.onRety,
              child: Text('Rety'),
            ),
          ],
        ),
      ),
    );
  }
}

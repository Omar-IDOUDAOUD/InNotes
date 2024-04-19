// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:innotes/constants/animation.dart';
import 'package:innotes/constants/colors.dart';
import 'package:innotes/constants/spaces.dart';
import 'package:innotes/model/flag.dart';
import 'package:flutter/material.dart';
import 'package:innotes/view/shared/bottomsheet_bar_handler.dart';

Future<Flag?> showAddFlagBottomsheet(
    BuildContext context, AnimationController animation) async {
  final result = await showModalBottomSheet<Flag?>(
    isScrollControlled: true,
    context: context,
    transitionAnimationController: animation,
    builder: (_) {
      return _Content();
    },
  );
  return result;
}

class _Content extends StatefulWidget {
  _Content({
    super.key,
  });

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  Color color = ColorsConsts.flagsColors.first;

  // final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();

  String? text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: SpacesConsts.screenPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          const BottomSheetDragHandlerBar(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New flag',
                style: Theme.of(context).textTheme.bodyLarge!,
              ),
              GestureDetector(
                onTap: () {
                  if (text == null) text = '';
                  setState(() {});
                  final valid = text?.isNotEmpty ?? true;
                  if (valid) {
                    Navigator.pop<Flag>(
                        context, Flag(name: text ?? '', color: color));
                  }
                },
                child: Icon(
                  FluentIcons.checkmark_24_regular,
                  size: 30,
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Flag name',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.name,
            key: _fieldKey,
            style: Theme.of(context).textTheme.bodySmall,
            onChanged: (str) {
              if ((text?.isEmpty ?? false) && str.isNotEmpty)
                setState(() {
                  text = str;
                });
              text = str;
            },
            decoration: InputDecoration(
              errorText: (text?.isEmpty ?? false) ? 'No name found' : null,
              hintText: 'Dialies',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Flag color',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 8,
          ),
          _ColorsList(onChange: (newColor) {
            color = newColor;
          }),
          SizedBox(
            height: SpacesConsts.screenPadding,
          ),
        ],
      ),
    );
  }
}

class _ColorsList extends StatefulWidget {
  const _ColorsList({super.key, required this.onChange});
  final Function(Color newColor) onChange;

  @override
  State<_ColorsList> createState() => __ColorsListState();
}

class __ColorsListState extends State<_ColorsList> {
  Color _color = ColorsConsts.flagsColors.first;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ColorsConsts.flagsColors.length,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final color = ColorsConsts.flagsColors[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _color = color;
              });

              widget.onChange(_color);
            },
            child: CircleAvatar(
              backgroundColor: color.withOpacity(.3),
              radius: 15,
              child: CircleAvatar(
                backgroundColor: color,
                radius: color == _color ? 12 : 8,
                child: AnimatedScale(
                  duration: AnimationConsts.defaultDuration,
                  curve: AnimationConsts.curve,
                  scale: color == _color ? 1 : 0,
                  child: const Icon(
                    FluentIcons.checkmark_12_regular,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

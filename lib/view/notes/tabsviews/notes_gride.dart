import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:innotes/constants/spaces.dart';

class NotesGrideTabView extends StatelessWidget {
  const NotesGrideTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return const NoteCard();
      },
      padding:
          const EdgeInsets.symmetric(horizontal: SpacesConsts.screenPadding),
      itemCount: 6,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 219, 255, 251),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(
                    'To Do',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 8,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '08 june, 2024',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 8,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal.shade300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Get the book from the library',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              height: 1.3,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Get the book from the library',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              height: 1.3,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                FluentIcons.folder_32_regular,
                color: Colors.teal.shade300,
                size: 13,
              ),
              const SizedBox(width: 5),
              Text(
                'Important > urgent',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal.shade300,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

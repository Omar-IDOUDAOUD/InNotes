// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:innotes/model/pagination.dart';

typedef WidgetBuilder = Widget Function(int index);

// ignore: non_constant_identifier_names
Widget paginationListItemBuilder(
  int index,
  Pagination pagination, {
  required WidgetBuilder itemBuilder,
  required WidgetBuilder loadingBuilder,
  WidgetBuilder? errorBuilder,
}) {
  if (index >= pagination.payload.length) {
    if (pagination.errorType != null) {
      assert(errorBuilder != null,
          "errorBuilder cannot be null because it will be used to return the error widget in the PaginationListItemBuilder");
      return errorBuilder!(index);
    } else
      return loadingBuilder(index - pagination.payload.length);
  } else {
    return itemBuilder(index);
  }
}

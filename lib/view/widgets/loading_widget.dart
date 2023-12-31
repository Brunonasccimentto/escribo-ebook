

import 'package:escribo_ebook/shared/enums/loading.dart';
import 'package:escribo_ebook/view-model/book_viewmodel.dart';
import 'package:escribo_ebook/view/widgets/positioned_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingIndicator extends StatelessWidget {
  final String? text;

  const LoadingIndicator({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    LoadingStatus loading = Provider.of<BookViewModel>(context).loading;

    return loading == LoadingStatus.loading ?
      const PositionedCircularIndicator(text: 'Baixando.... E-pub')

    : loading == LoadingStatus.alreadyDownloaded ?
      const PositionedCircularIndicator(text: 'Abrindo.... E-pub')

    : Container();
  }
}

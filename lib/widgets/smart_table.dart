import 'package:flutter/material.dart';
import 'package:flutter_5_wd/providers/model_provider.dart';
import 'package:flutter_5_wd/services/api_service.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class SmartTable<T extends ModelProvider> extends StatefulWidget {
  const SmartTable({
    required this.provider,
    required this.title,
    required this.getTitle,
    super.key,
  });

  final T provider;
  final String title;
  final String Function(dynamic) getTitle;

  @override
  State<SmartTable> createState() => _SmartTableState();
}

class _SmartTableState extends State<SmartTable> {
  final ScrollController _scrollController = ScrollController();
  List _items = [];
  bool _isLoading = true;
  int _maxItems = 0;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(() {
      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      double pixels = _scrollController.position.pixels;

      if (!_isLoading && maxScrollExtent == pixels) {
        _loadData(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.title),
          ),
          Divider(height: 1),
          if (_isLoading) LinearProgressIndicator(),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(index.toString()),
                  onTap: () {
                    goTo(context);
                  },
                  title: Text(widget.getTitle(_items[index])),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _loadData({loadMore = false}) async {
    if (_items.isNotEmpty && _maxItems == _items.length) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final DataList response = await widget.provider.getAll(
        queryParams: {
          'page': (loadMore ? _page + 1 : 1).toString(),
        },
      );

      setState(() {
        _maxItems = response.count;
        if (loadMore) {
          _items.addAll(response.rows);
          _page = _page + 1;
        } else {
          _items = response.rows;
        }
        _isLoading = false;
      });
    } on ApiException catch (e) {
      toastification.show(
        title: Text(
          e.message,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }
}

void goTo(BuildContext context) {
  context.go('/');
}

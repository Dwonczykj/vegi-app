import 'package:flutter/material.dart';

class JsonViewer extends StatefulWidget {
  const JsonViewer({required this.json, Key? key}) : super(key: key);

  final dynamic json;

  @override
  _JsonViewerState createState() => _JsonViewerState();
}

// class _JsonViewerState extends State<JsonViewer> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: _renderJson(widget.json),
//     );
//   }

//   Widget _renderJson(dynamic json) {
//     if (json is Map) {
//       return JsonMap(map: json);
//     } else if (json is List) {
//       return JsonList(list: json);
//     } else {
//       return Text(json.toString());
//     }
//   }
// }

class _JsonViewerState extends State<JsonViewer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _renderJson(widget.json),
          ),
        ],
      ),
    );
  }

  Widget _renderJson(dynamic json) {
    if (json is Map) {
      return JsonMap(map: json);
    } else if (json is List) {
      return JsonList(list: json);
    } else {
      return Text(json.toString());
    }
  }
}

class JsonMap extends StatefulWidget {
  const JsonMap({required this.map, Key? key}) : super(key: key);

  final Map map;

  @override
  _JsonMapState createState() => _JsonMapState();
}

class _JsonMapState extends State<JsonMap> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    widget.map.forEach((key, value) {
      children.add(Row(
        children: [
          Expanded(child: Text('$key:')),
          Expanded(child: JsonViewer(json: value)),
        ],
      ));
    });

    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() {
            _isExpanded = !_isExpanded;
          }),
          child: Row(
            children: [
              Icon(_isExpanded ? Icons.arrow_drop_down : Icons.arrow_right),
              Text('Object (${widget.map.length})'),
            ],
          ),
        ),
        if (_isExpanded) ...children
      ],
    );
  }
}

class JsonList extends StatefulWidget {
  const JsonList({required this.list, Key? key}) : super(key: key);

  final List list;

  @override
  _JsonListState createState() => _JsonListState();
}

class _JsonListState extends State<JsonList> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() {
            _isExpanded = !_isExpanded;
          }),
          child: Row(
            children: [
              Icon(_isExpanded ? Icons.arrow_drop_down : Icons.arrow_right),
              Text('Array (${widget.list.length})'),
            ],
          ),
        ),
        if (_isExpanded)
          for (var item in widget.list) ...[
            JsonViewer(json: item),
          ]
      ],
    );
  }
}

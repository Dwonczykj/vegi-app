import 'package:flutter/material.dart';
import 'dart:math' as Math;

class JsonViewer extends StatefulWidget {
  const JsonViewer(
      {required this.json, required this.level, Key? key, this.padding = 8.0})
      : super(key: key);

  final dynamic json;
  final double padding;
  final int level;

  @override
  _JsonViewerState createState() => _JsonViewerState();
}

class _JsonViewerState extends State<JsonViewer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(widget.padding),
        child: _renderJson(widget.json),
      ),
    );
  }

  Widget _renderJson(dynamic json) {
    if (json is Map) {
      return JsonMap(
        map: json,
        level: widget.level,
      );
    } else if (json is List) {
      return JsonList(
        list: json,
        level: widget.level,
      );
    } else {
      return ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width - (widget.padding * 2.0)),
        child: Text(json.toString()),
      );
    }
  }
}

class JsonMap extends StatefulWidget {
  const JsonMap({required this.map, required this.level, Key? key})
      : super(key: key);

  final Map map;
  final int level;

  @override
  _JsonMapState createState() => _JsonMapState();
}

class _JsonMapState extends State<JsonMap> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    const keyWidth = 0.45;
    const spaceWidth = 0.1;
    widget.map.forEach((key, value) {
      children.add(
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width *
                      keyWidth, // 30% of screen width
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: value is Map
                          ? 3.0
                          : value is List
                              ? 3.0
                              : 0.0),
                  child: Text(
                    "$key:",
                    // style: TextStyle(),
                  ),
                ),
              ),
              SizedBox(
                  width: Math.min(
                MediaQuery.of(context).size.width * spaceWidth,
                10,
              )), // You can adjust this value for spacing
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      MediaQuery.of(context).size.width, // 60% of screen width
                ),
                child: JsonViewer(
                  json: value,
                  padding: 0.0,
                  level: widget.level + 1,
                ),
              ),
            ],
          ),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            children: [
              Icon(_isExpanded ? Icons.arrow_drop_down : Icons.arrow_right),
              Text("Object (${widget.map.length})"),
            ],
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: EdgeInsets.only(left: 8.0 * (widget.level + 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width *
                        keyWidth, // 30% of screen width
                  ),
                  child: Text(
                    _isExpanded ? '{' : '',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
                // ...children,
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width *
                        keyWidth, // 30% of screen width
                  ),
                  child: Text(
                    _isExpanded ? '}' : '',
                  ),
                ),
              ],
            ),
          )
        // if (_isExpanded) ...children
      ],
    );
  }
}

class JsonList extends StatefulWidget {
  const JsonList({required this.list, required this.level, Key? key})
      : super(key: key);

  final List list;
  final int level;

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
          Padding(
            padding: EdgeInsets.only(left: 8.0 * (widget.level + 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in widget.list)
                  JsonViewer(
                    json: item,
                    level: widget.level + 1,
                  ),
              ],
            ),
          )
      ],
    );
  }
}

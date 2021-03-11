import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function search;
  final Function onChanged;
  final Color primaryColor;
  final Color secondColor;

  SearchBarWidget(
      {Key key,
      @required this.controller,
      @required this.search,
      @required this.onChanged,
      @required this.primaryColor,
      @required this.secondColor})
      : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  double height;
  OutlineInputBorder border;

  @override
  void initState() {
    super.initState();
    height = 35.0;
    border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(height),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(height),
              child: TextFormField(
                onChanged: (value) => widget.onChanged(value),
                controller: widget.controller,
                decoration: InputDecoration(
                    hintText: 'Rechercher...',
                    hintStyle: TextStyle(color: widget.secondColor),
                    filled: true,
                    fillColor: widget.primaryColor,
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    errorBorder: border,
                    disabledBorder: border,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    prefixIcon: Icon(
                      Icons.search,
                      color: widget.secondColor,
                      size: 25.0,
                    )),
              ),
            ),
          ),
          InkWell(
              onTap: widget.search,
              child: Icon(
                Icons.search,
                color: widget.secondColor,
                size: 25.0,
              )),
        ],
      ),
    );
  }
}

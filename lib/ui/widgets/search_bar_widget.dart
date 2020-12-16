import 'package:flutter/material.dart';
import 'package:match_work/ui/shared/app_colors.dart';

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      height: 35.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                hintStyle: TextStyle(color: PRIMARY_COLOR),
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              ),
            ),
          ),
          Icon(
            Icons.search,
            color: PRIMARY_COLOR,
            size: 25.0,
          )
        ],
      ),
    );
  }
}

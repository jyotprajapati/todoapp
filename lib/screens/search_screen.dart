import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_listapp/models/todo_item.dart';
import 'package:todo_listapp/provider/provider.dart';

class SearchScreen extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<ListProvider>(builder: (context, model, _) {
      return ListView.builder(
          itemCount: model.searchItem(query).length,
          itemBuilder: (context, index) {
            final List<TodoItem> searchList =
                Provider.of<ListProvider>(context).searchItem(query);
            return ListTile(
              title: Text(searchList[index].title),
            );
          });
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    throw UnimplementedError();
  }
}


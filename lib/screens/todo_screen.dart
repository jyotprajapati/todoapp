import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_item.dart';
import 'package:todo/provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var tasks;
  bool searchButton = false;

  late GlobalKey<FormState> _formkey;
  late TextEditingController _controller;

  // TodoItem.length;

  @override
  void initState() {
    super.initState();
    _formkey = GlobalKey();
    _controller = TextEditingController();
    tasks = Provider.of<ListProvider>(context, listen: false);
  }

  void _showDialog(model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _formkey,
          child: AlertDialog(
            title: Text(
              'Add Task',
              style: TextStyle(color: Colors.lightBlue),
            ),
            content: TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter task',
                fillColor: Colors.lightBlue,
              ),
              controller: _controller,
              validator: (String? val) {
                if (val!.length > 0) {
                  return null;
                } else {
                  return 'Add Something';
                }
              },
              onSaved: (val) =>
                  Provider.of<ListProvider>(context).addToDoItem(val!, false),
            ),
            actions: [
              TextButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      model.addToDoItem(_controller.text, false);
                      Navigator.of(context).pop();
                    }
                    _controller.clear();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.lightBlue),
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ListProvider>(
        builder: (context, model, _) {
          // return searchButton
          //     ? _searchBar(model)
          //     :
          return ListView.builder(
              itemCount: model.todoList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
                      child: Row(children: [
                        IconButton(
                            onPressed: () {
                              model.todoList.elementAt(index).isDone = true;
                              setState(() {});
                            },
                            icon: model.todoList.elementAt(index).isDone
                                ? Icon(
                                    Icons.check,
                                    color: Theme.of(context).primaryColor,
                                  )
                                : Icon(
                                    Icons.check_box_outline_blank,
                                    color: Colors.greenAccent,
                                  )),
                        SizedBox(
                          width: 10,
                        ),
                        model.todoList.elementAt(index).isDone
                            ? Text(
                                model.todoList[index].title,
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough),
                              )
                            : Text(
                                model.todoList[index].title,
                                style: TextStyle(fontSize: 16),
                              ),
                      ]),
                    ),
                  ),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.red,
                    child: Text(
                      "Deleting",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  key: ValueKey<TodoItem>(model.todoList[index]),
                  onDismissed: (DismissDirection direction) {
                    // setState(() {
                    model.todoList.removeAt(index);
                    // });
                  },
                );
              });
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton:
          Consumer<ListProvider>(builder: (context, model, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: FloatingActionButton(
            onPressed: () {
              _showDialog(model);
            },
            // elevation: 1,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Theme.of(context).primaryColor,
              size: 35,
            ),
          ),
        );
      }),
      bottomNavigationBar: Container(
        height: 57,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 0.4,
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.dehaze,
                  color: Theme.of(context).primaryColor,
                  size: 27,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Todo",
                  style: TextStyle(
                    // color: Theme.of(context).primaryColor,
                    fontSize: 18, fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Consumer<ListProvider>(builder: (context, model, _) {
              return IconButton(
                icon: Icon(Icons.search),
                color: Theme.of(context).primaryColor,
                // size: 27,
                iconSize: 27,
                onPressed: () async {
                  searchButton = true;
                  // _searchBar(model);
                  //  final finalResult = await showSearch(context: context, delegate: model.searchItem());
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

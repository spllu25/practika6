import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Главная',
      home: ListScreens(),
      routes: {
        '/contacts': (context) => ListViewScreen(),
      },
    );
  }
}

class ListScreens extends StatefulWidget {
  @override
  _ListScreensState createState() => _ListScreensState();
}

class _ListScreensState extends State<ListScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Контактная информация'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
              ),
              child: Text('Заметки'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ColumnListScreen()));
              },
            ),
            const SizedBox(width: 100.0, height: 50.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
              ),
              child: Text('Контакты'),
              onPressed: () {
                Navigator.of(context).pushNamed('/contacts');
              },
            ),
            const SizedBox(width: 100.0, height: 50.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
              ),
              child: Text('Напоминания'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ListViewSeparatedScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ColumnListScreen extends StatefulWidget {
  @override
  _ColumnListScreenState createState() => _ColumnListScreenState();
}

class _ColumnListScreenState extends State<ColumnListScreen> {
  List<String> items = [];

  void addItem(String item, List<String> list) {
    setState(() {
      list.add(item);
    });
  }

  void removeItem(int index, List<String> list) {
    setState(() {
      list.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purpleAccent,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Заметки'),
        ),
        body: Column(
            children: <Widget>[
        const SizedBox(width: 100.0, height: 50.0),
        ElevatedButton(
        style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
    ),
    onPressed: () {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    String newItem = '';
    return AlertDialog(
    backgroundColor: Colors.blueAccent,
    title: Text('Новая заметка'),
    content: TextField(
    onChanged: (value) {
    newItem = value;
    },
    ),
    actions: <Widget>[
    TextButton(
    child: Text('OK'),
    onPressed: () {
    addItem(newItem, items);
    Navigator.of(context).pop();
    },
    ),
    ],
    );
    },
    );
    },
          child: Text('Добавить заметку'),
        ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          removeItem(index, items);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
        ),
    );
  }
}

class ListViewScreen extends StatefulWidget {
  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  List<String> items = [];

  void addItem(String item1,String item2, List<String> list) {
    setState(() {
      list.add('$item1 - $item2');
    });
  }

  void removeItem(int index, List<String> list) {
    setState(() {
      list.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Контакты'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeItem(index, items);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newItem1 = '';
              String newItem2 = '';
              return AlertDialog(
                backgroundColor:Colors.blueAccent,
                title: const Text('Новый контакт'),
                content: Column(
                  children: <Widget>[
                    const Text('Имя'),
                    TextField(
                      onChanged: (value)
                      {
                        newItem1 = value;
                      },
                    ),
                    const Text('Номер'),
                    TextField(
                      onChanged: (value) {
                        newItem2 = value;
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      addItem(newItem1,newItem2, items);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


class ListViewSeparatedScreen extends StatefulWidget {
  @override
  _ListViewSeparatedScreenState createState() => _ListViewSeparatedScreenState();
}

class _ListViewSeparatedScreenState extends State<ListViewSeparatedScreen> {
  List<String> items = [];

  void addItem() {
    setState(() {
      items.add('Напоминание ${items.length + 1}');
    });
  }

  void removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent ,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Напоминания'),
      ),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeItem(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}

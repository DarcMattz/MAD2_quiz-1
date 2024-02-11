import 'package:flutter/material.dart';
import 'package:lab_quiz1/model.dart';
import 'package:lab_quiz1/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var first = TextEditingController();
    var last = TextEditingController();

    return ChangeNotifierProvider(
      create: (_) => Names(),
      child: MaterialApp(
        home: HomeScreen(first: first, last: last),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.first,
    required this.last,
  });

  final TextEditingController first;
  final TextEditingController last;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextField(
            controller: first,
          ),
          TextField(
            controller: last,
          ),
          ElevatedButton(
            onPressed: () {
              Name fullName = Name(first.text, last.text);
              Provider.of<Names>(context, listen: false).add(fullName);
            },
            child: Text("Add"),
          ),
          Expanded(
            child: Consumer<Names>(
              builder: (_, item, child) {
                return ListView.builder(
                  itemCount: item.names.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                            "${item.names[index].firstName} ${item.names[index].lastName}"),
                        trailing: IconButton(
                            onPressed: () {
                              Provider.of<Names>(context, listen: false)
                                  .isFav(item.names[index]);
                            },
                            icon: Icon(item.names[index].isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border)),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> todos = [];

  final TextEditingController _todoController = TextEditingController();

  void addTodo() {
    if (_todoController.text.length > 4) {
      setState(() {
        todos.add(_todoController.text);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          closeIconColor: Colors.black,
          elevation: 1.0,
          backgroundColor: Colors.yellow,
          content: Text(
            "Hey Bruh !!! Comon you should be typing more ",
            style: GoogleFonts.jost(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      );
    }
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void updateTodo(int index) {
    setState(() {
      todos[index] = _todoController.text;
    });
  }

  void _showUpdationDialog(int index) {
    _todoController.text = todos[index];

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: const RoundedRectangleBorder(),
              content: SizedBox(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          labelText: "Update your ToDo here ",
                          labelStyle: GoogleFonts.jost(fontSize: 12)),
                    ),
                    const Gap(30),
                    ElevatedButton.icon(
                      onPressed: () {
                        updateTodo(index);
                        _todoController.clear();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.edit),
                      label: Text(
                        "Edit Todo",
                        style: GoogleFonts.jost(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.notes),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.black87,
                  shape: const RoundedRectangleBorder(),
                  contentPadding: const EdgeInsets.all(0),
                  content: Container(
                    decoration: const BoxDecoration(shape: BoxShape.rectangle),
                    width: 400,
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextField(
                            style: GoogleFonts.jost(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            controller: _todoController,
                            decoration: InputDecoration(
                              labelText: "Enter your todo",
                              labelStyle: GoogleFonts.jost(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Gap(50),
                        ElevatedButton.icon(
                            onPressed: () {
                              addTodo();
                              _todoController.clear();
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.add),
                            label: Text(
                              "Add Todo",
                              style: GoogleFonts.jost(fontSize: 16),
                            ))
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(Colors.yellow.value),
        title: Text(
          "NOTES APP",
          style: GoogleFonts.jost(
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Hey there!, Get your plans done accordingly !!",
              style:
                  GoogleFonts.jost(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          todos.isEmpty
              ? Expanded(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Lottie.network(
                              "https://lottie.host/3af06d5e-88b1-47d0-9501-a75464d5278b/JGIhlj7KaX.json")),
                    ),
                  ],
                ))
              : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            10.0,
                          ),
                          child: Card(
                            elevation: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    todos[index],
                                    style: GoogleFonts.jost(fontSize: 18),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () =>
                                            _showUpdationDialog(index),
                                      ),
                                      const Gap(
                                        10,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => deleteTodo(index),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}

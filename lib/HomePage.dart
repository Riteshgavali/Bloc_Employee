import 'package:flutter/material.dart';
import 'EmpBlock.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    super.dispose();
    _employeeBloc.dipose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee App"),
      ),
      body: Container(
        child: StreamBuilder<List>(
          stream: _employeeBloc.employeeListStram,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "${snapshot.data?[index].id}.",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${snapshot.data?[index].name}.",
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              "₹ ${snapshot.data?[index].salary}",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            _employeeBloc.employeeSalaryIncrement
                                .add(snapshot.data?[index]);
                          },
                          icon: Icon(Icons.thumb_up),
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        child: IconButton(
                          onPressed: () {
                            _employeeBloc.employeeSalarydecrement
                                .add(snapshot.data![index]);
                          },
                          icon: Icon(Icons.thumb_down),
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// IMPORTS

//LIST OF EMP

//STREAM CONTROLLERS

//STREAM SINK GETTER

//CONSTRUCTOR - ADD DATA; LISTEN TO CHANGES

//CORE FUNCTIONS

//DISPOSE

// IMPORTS

import 'dart:async';
import 'Employee.dart';

//LIST OF EMP

class EmployeeBloc {
// sink to add in pipe
// stream to get data from pipe
//by pipe means data flow

  List<Employee> _employeeList = [
    Employee(1, "Employee One", 10000.0),
    Employee(2, "Employee Two", 20000.0),
    Employee(3, "Employee Three", 30000.0),
    Employee(4, "Employee Four", 40000.0),
    Employee(5, "Employee Five", 50000.0),
  ];

//STREAM CONTROLLERS

  final _employeeListStreamController = StreamController<List<Employee>>();

  //for Increment and Decrement

  final _employeeSalaryIncrementStremController = StreamController<Employee>();
  final _employeeSalaryDecrementStremController = StreamController<Employee>();

//STREAM SINK GETTER

  Stream<List<Employee>> get employeeListStram =>
      _employeeListStreamController.stream;

  StreamSink<Employee> get employeeListSink =>
      _employeeSalaryIncrementStremController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStremController.sink;

  StreamSink<Employee> get employeeSalarydecrement =>
      _employeeSalaryDecrementStremController.sink;

//CONSTRUCTOR - ADD DATA; LISTEN TO CHANGES

  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStremController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStremController.stream.listen(_decrementSalary);
  }

//CORE FUNCTIONS

  _incrementSalary(Employee employee) {
    double salary = employee.salary;

    double incrementedSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary = salary + incrementedSalary;

    employeeListSink.add(_employeeList as Employee);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;

    double decrementedSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary = salary - decrementedSalary;

    employeeListSink.add(_employeeList as Employee);
  }

//DISPOSE

  void dipose() {
    _employeeSalaryIncrementStremController.close();
    _employeeSalaryDecrementStremController.close();
    _employeeListStreamController.close();
  }
}

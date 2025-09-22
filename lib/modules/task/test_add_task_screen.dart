// file: screens/add_task_screen.dart

import 'package:flutter/material.dart';

class TestAddTaskScreen extends StatefulWidget {
  final String jobOwnerId;

  const TestAddTaskScreen({super.key, required this.jobOwnerId});

  @override
  _TestAddTaskScreenState createState() => _TestAddTaskScreenState();
}

class _TestAddTaskScreenState extends State<TestAddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));
  // Function to create and send the task
  // void _createTask() {
  //   if (_formKey.currentState!.validate()) {
  //     // Logic to send data to your backend API
  //     // Example:
  //     // final newTask = Task(
  //     //   taskId: 'unique-id-from-backend',
  //     //   jobId: widget.jobId,
  //     //   jobOwnerId: widget.jobOwnerId,
  //     //   jobOwnerName: 'Your Name', // Fetch from current user data
  //     //   taskTitle: _titleController.text,
  //     //   taskDescription: _descriptionController.text,
  //     //   startDate: _startDate,
  //     //   endDate: _endDate,
  //     //   mentionedFreelancers: _selectedFreelancers,
  //     //   createdAt: DateTime.now(),
  //     //   updatedAt: DateTime.now(),
  //     // );
  //     // print('Task created: ${newTask.toJson()}');
  //     Navigator.of(context).pop();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Task')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Task Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter a task title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Task Description'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please, enter a task description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Dates section
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _startDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (pickedDate != null) {
                          setState(() => _startDate = pickedDate);
                        }
                      },
                      child: Text(
                        'Starting Date: ${_startDate.toLocal().toString().split(' ')[0]}',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _endDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                        if (pickedDate != null) {
                          setState(() => _endDate = pickedDate);
                        }
                      },
                      child: Text(
                        'Ending Date: ${_endDate.toLocal().toString().split(' ')[0]}',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              // // Freelancers selection section
              // Text('Select Freelancer', style: Theme.of(context).textTheme.titleLarge),
              // SizedBox(height: 8),
              // Wrap(
              //   spacing: 8.0,
              //   children: jobAcceptedFreelancers.map((freelancer) {
              //     final isSelected = _selectedFreelancers.contains(freelancer);
              //     return FilterChip(
              //       avatar: CircleAvatar(
              //         backgroundImage: NetworkImage(freelancer.freelancerImageUrl ?? ''),
              //       ),
              //       label: Text(freelancer.freelancerName),
              //       selected: isSelected,
              //       onSelected: (selected) {
              //         setState(() {
              //           if (selected) {
              //             _selectedFreelancers.add(freelancer);
              //           } else {
              //             _selectedFreelancers.remove(freelancer);
              //           }
              //         });
              //       },
              //     );
              //   }).toList(),
              // ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: /*_selectedFreelancers.isNotEmpty ? _createTask : null*/
                    () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: /*_selectedFreelancers.isNotEmpty ? Colors.blue : Colors.grey*/
                      Colors.blue,
                ),
                child: Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

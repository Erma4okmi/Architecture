import 'package:flutter/material.dart';
import 'package:testtest/data/api_client.dart';
import 'package:testtest/data/user_repository_impl.dart';
import 'package:testtest/domain/user_repository.dart';

import '../domain/user.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {


  final UserRepository userRepository = UserRepositoryImpl(apiClient: ApiClient());

  late List<User> users;

  // Получем одного пользователя.
  Future<User> getUser(int id) async {
    return await userRepository.getUser(id);
  }

  // Получем всех пользователей.
  Future<void> fetchUsers() async {
    users = await userRepository.getUsers();
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
    users = [];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Data Users"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FutureBuilder(future: getUser(5), builder: (BuildContext context, AsyncSnapshot<User> snapshot) {

              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if(snapshot.hasError) {
                return const Center(
                  child: Text('Error'),
                );
              } else {
                User user = snapshot.data!;
                return Column(
                  children: [
                    Text('ID: ${user.id}'),
                    Text('Name: ${user.name}'),
                    Text('Email: ${user.email}'),
                  ],
                );
              }
            }),
            ListView.builder(scrollDirection: Axis.vertical,
                shrinkWrap: true,itemCount: users.length, itemBuilder: (BuildContext context, int index){
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.email),
              );
            })
          ],
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_refer/models/user.dart';
import 'package:flutter_refer/repositories/user_repository.dart';
import 'package:go_router/go_router.dart';

class UserListScreen extends StatelessWidget {
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users'),
      ),
      body: FutureBuilder<List<User>>(
        future: _userRepository.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Text('Loading....');
            default:
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  User? user = snapshot.data?[index];
                  return Card(
                    child: ListTile(
                      title: Text(user!.fName),
                      subtitle: Text(user!.username),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => context.go('/update', extra: user.id),
                            icon: const Icon(Icons.settings),
                          ),
                          IconButton(
                            onPressed: () => _userRepository.deleteUser(user.id),
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
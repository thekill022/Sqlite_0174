import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet8/bloc/user_bloc.dart';
import 'package:meet8/bloc/user_event.dart';
import 'package:meet8/bloc/user_state.dart';
import 'package:meet8/pages/user_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar User")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading)
            return Center(child: CircularProgressIndicator());
          if (state is UserLoaded && state.Users.isNotEmpty) {
            return ListView.builder(
              itemCount: state.Users.length,
              itemBuilder: (context, index) {
                final user = state.Users[index];
                return ListTile(
                  title: Row(
                    children: [
                    Text(user.name.length > 8 ? "${user.name.substring(0,7)}..." : user.name),
                    Text(" | "),
                    Text("+62 ${user.NoTelepon}"),
                  ],),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.email)  ,
                      Text(user.alamat)
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UserFormPage(user: user),
                              ),
                            ),
                        icon: Icon(Icons.edit, color: Colors.blue),
                      ),
                      IconButton(
                        onPressed:
                            () => context.read<UserBloc>().add(
                              DeleteUserEvent(user.id),
                            ),
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(
            child: Text("Belum ada data user. Klik + untuk tambah"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => UserFormPage()),
            ),
        child: Icon(Icons.add),
      ),
    );
  }
}

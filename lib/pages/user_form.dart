import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:meet8/bloc/user_bloc.dart';
import 'package:meet8/bloc/user_event.dart';
import 'package:meet8/domain/entities/user_entity.dart';

class UserFormPage extends StatefulWidget {
  final UserEntity? user;

  const UserFormPage({super.key, this.user});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _teleponController = TextEditingController();
  final _alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
      _teleponController.text = widget.user!.NoTelepon;
      _alamatController.text = widget.user!.alamat;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.user != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit User" : "Tambah User")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nama Lengkap",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: " Alamat Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _teleponController,
              decoration: InputDecoration(
                labelText: "Nomor Telepon",
                border: OutlineInputBorder(),
                prefixText: "+62"
              ),
              inputFormatters: [LibPhonenumberTextFormatter(
                country: CountryWithPhoneCode(
                  phoneCode: '62',
                  countryCode: 'ID',
                  phoneMaskMobileNational: '0000-0000-0000-0000',
                  exampleNumberMobileNational: '0812345678901234',
                  exampleNumberFixedLineNational: '02112345678',
                  phoneMaskFixedLineNational: '00-000-0000',
                  exampleNumberMobileInternational: '+628123456789',
                  exampleNumberFixedLineInternational: '+622112345678',
                  phoneMaskMobileInternational: '+00 000-0000-0000',
                  phoneMaskFixedLineInternational: '+00 00-000-0000',
                  countryName: 'Indonesia',
            ),
            )],
            ),
            SizedBox(height: 15),
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(
                labelText: " Alamat Tinggal",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final newUser = UserEntity(
                    id:
                        isEdit
                            ? widget.user!.id
                            : DateTime.now().microsecondsSinceEpoch.toString(),
                    name: _nameController.text,
                    email: _emailController.text,
                    NoTelepon: _teleponController.text,
                    alamat: _alamatController.text
                  );

                  if (isEdit) {
                    context.read<UserBloc>().add(UpdateUserEvent(newUser));
                  } else {
                    context.read<UserBloc>().add(AddUserEvent(newUser));
                  }
                  Navigator.pop(context);
                },
                child: Text(isEdit ? "Simpan Perubahan" : "Simpan User Baru"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

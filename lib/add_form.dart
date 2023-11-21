import 'package:flutter/material.dart';
import 'package:flutter_contact_app/contact_service.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});
  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  //inisialisasi variabel
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController hobby = TextEditingController();

  //inisialisasi class
  ContactService contactService = ContactService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Tambah Data',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      // appBar: AppBar(
      //   title: Text('Form Tambah Data'),
      // ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                controller: name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan Nama';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                items: ['Laki-Laki', 'Perempuan'].map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    gender.text = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                controller: email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan Email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nomor Handphone',
                  border: OutlineInputBorder(),
                ),
                controller: phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan Nomor Handphone';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
                controller: address,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan Alamat';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Hobi',
                  border: OutlineInputBorder(),
                ),
                controller: hobby,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Masukkan Hobi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150, 50),
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(26), // Mengatur border radius
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Menyimpan data jika validasi berhasil
                    contactService.saveData(
                      name.text,
                      gender.text,
                      email.text,
                      phone.text,
                      address.text,
                      hobby.text,
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                child: Text('Tambah Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

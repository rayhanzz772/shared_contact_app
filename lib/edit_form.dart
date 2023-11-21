import 'package:flutter/material.dart';
import 'package:flutter_contact_app/contact_service.dart';

class EditForm extends StatefulWidget {
  final Map<dynamic, dynamic> data;

  //constructor berfungsi untuk menerima data
  //yang dikirim dari file yang menggunakannya
  EditForm({required this.data});

  @override
  State<EditForm> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  //inisialisasi variabel untuk form
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController hobby = TextEditingController();

  //kita akan menggunakan method dari class Transaction, jadi harus inisialisasi dulu
  ContactService contactService = ContactService();

  @override
  void initState() {
    super.initState();

    //letakkan fungsi atau method yang ingin dijalankan pertama kali
    //saat file ini dilload/dijalankan
    initializeControllers();
    // Memanggil fungsi initializeControllers saat initState dipanggil
  }

  //isi/set form dengan data yang dikirim dari file sebelumnya
  void initializeControllers() {
    name.text = widget.data['name']!;
    gender.text = widget.data['gender']!;
    email.text = widget.data['email']!;
    phone.text = widget.data['phone']!;
    address.text = widget.data['address']!;
    hobby.text = widget.data['hobby']!;
    // Menetapkan nilai awal pada TextEditingController berdasarkan data yang diberikan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Form Update Data',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
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
                value: gender.text.isNotEmpty ? gender.text : null,
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
                    contactService.updateData(
                      name.text,
                      gender.text,
                      email.text,
                      phone.text,
                      address.text,
                      hobby.text,
                      widget.data['id'],
                    );
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                child: Text('Update Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

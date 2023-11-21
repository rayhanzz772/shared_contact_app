import 'package:flutter/material.dart';
import 'package:flutter_contact_app/contact_service.dart';
import 'package:flutter_contact_app/edit_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //inisialisasi variabel
  ContactService contactService =
      ContactService(); //inisialisai class transaksi
  List data = []; //digunakan untuk menampung data yang diambil
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //menjalankan data pertama kali
    getData();
  }

  //memanggil data
  void getData() async {
    setState(() {
      isLoading = true;
    });

    //menggunakan method getData pada class transact ion
    List getData = await contactService.getData();
    setState(() {
      data = getData; //reversed.toList() akan mengurutkan data DESC
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kontak apps',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Menampilkan Circular Progress Indicator
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, item) {
                return Card(
                  elevation: 1,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                      ),
                    ),
                    title: Text(
                      '${data[item]['name']}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          'Kelamin: ${data[item]['gender']}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        Text(
                          'Phone: ${data[item]['phone']}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        Text(
                          'Alamat: ${data[item]['address']}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        Text(
                          'Hobi: ${data[item]['hobby']}',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 8,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditForm(
                                  data: data[item],
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            contactService.deleteData(item);
                            getData();
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addForm');
        },
        child: Icon(Icons.add), // Ikona FAB
        backgroundColor: Colors.pinkAccent, // Warna latar belakang FAB
      ),
    );
  }
}

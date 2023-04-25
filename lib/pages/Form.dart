import 'dart:io';

import 'package:app_register_online/Utils/ServiceSetting.dart';
import 'package:app_register_online/pages/AdminHome.dart';
import 'package:app_register_online/service/AuthProvider.dart';
import 'package:app_register_online/service/ContactProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../model/User.dart';
import '../service/AppProvider.dart';

class FormAdd extends StatefulWidget {
  const FormAdd({Key? key, required this.UserID}) : super(key: key);

  final int UserID;

  @override
  State<FormAdd> createState() => _FormAddState();
}

class _FormAddState extends State<FormAdd> {
  User? UserData;
  final _formKey = GlobalKey<FormState>();
  String Gender = 'male';
  bool _seepass1 = true;
  bool _seepass2 = true;
  bool _pressAdd = false;
  bool _chpass = false;

  TextEditingController _name = TextEditingController();
  TextEditingController _last_name = TextEditingController();
  TextEditingController _birth_day = TextEditingController();
  TextEditingController _phone_number = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirm_password = TextEditingController();
  TextEditingController _job = TextEditingController();
  TextEditingController _job_type = TextEditingController();
  TextEditingController _add_village = TextEditingController();
  TextEditingController _add_city = TextEditingController();
  TextEditingController _add_province = TextEditingController();
  TextEditingController _add_detail = TextEditingController();
  TextEditingController _web = TextEditingController();

  /// ອັບໂຫຼດຮູບ
  String? imageFilePath;
  File? imageFile;

  void getImage() async {
    final picker = ImagePicker();

    var _pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (_pickedFile != null) {
      setState(() {
        imageFilePath = _pickedFile.path;
        imageFile = File(_pickedFile.path);
      });

      // print(imageFile);
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.UserID);
    if (widget.UserID != 0) {
      GetUserData();
    }
  }

  void GetUserData() {
    // print(widget.UserID);
    List<User> listUser =
        Provider.of<ContactProvider>(context, listen: false).ListUser;
    UserData = listUser.firstWhere((i) => i.id == widget.UserID);
    // print(UserData?.name);

    if (widget.UserID != 0) {
      setState(() {
        _name.text = UserData!.name;
        _last_name.text = UserData!.last_name;
        Gender = UserData!.gender;
        // imageFilePath = BaseURL + '/img/' + UserData!.image;
        _phone_number.text = UserData!.tel;
        _birth_day.text = UserData!.birth_day;
        _add_village.text = UserData!.add_village;
        _add_city.text = UserData!.add_city;
        _add_province.text = UserData!.add_province;
        _add_detail.text = UserData!.add_detail;
        _email.text = UserData!.email;
        _web.text = UserData!.web;
        _job.text = UserData!.job;
        _job_type.text = UserData!.job_type;
        // _name.text = UserData!.name;
        print(imageFilePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'ເພີ່ມສະມາຊິກໃໝ່',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 238, 43, 153)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: (imageFilePath == null)
                          ? (widget.UserID == 0)
                              ? CircleAvatar(
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 130,
                                    color: Colors.white,
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 238, 43, 153),
                                  radius: 65,
                                )
                              : (UserData!.image == '')
                                  ? CircleAvatar(
                                      child: Icon(
                                        Icons.account_circle,
                                        size: 130,
                                        color: Colors.white,
                                      ),
                                      backgroundColor:
                                          Color.fromARGB(255, 238, 43, 153),
                                      radius: 65,
                                    )
                                  : CircleAvatar(
                                      maxRadius: 65,
                                      backgroundImage: NetworkImage(
                                          BaseURL + '/img/' + UserData!.image),
                                    )
                          : CircleAvatar(
                              maxRadius: 65,
                              backgroundImage: FileImage(imageFile!),
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 0),
                  child: Row(
                    children: [
                      Text(
                        'ຂໍ້ມູນສ່ວນໂຕ',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 238, 43, 153)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ຊື່: (*)',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _name,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                            ),
                            style: const TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ກະລຸນາປ້ອນຊື່...';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'ນາມສະກຸນ: (*)',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _last_name,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                            ),
                            style: const TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ກະລຸນາປ້ອນນາມສະກຸນ...';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: 'male',
                                      groupValue: Gender,
                                      onChanged: (value) {
                                        setState(() {
                                          Gender = value!;
                                        });
                                      }),
                                  Text(
                                    'ເພດຊາຍ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 238, 43, 153)),
                                  ),
                                  Radio(
                                      value: 'female',
                                      groupValue: Gender,
                                      onChanged: (value) {
                                        setState(() {
                                          Gender = value!;
                                        });
                                      }),
                                  Text(
                                    'ເພດຍິງ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 238, 43, 153)),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Text(
                            'ວັນເດືອນປີເກີດ:',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: _birth_day,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                            ),
                            style: const TextStyle(fontSize: 20),
                            onTap: () async {
                              DateTime? pickedate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2102));
                              if (pickedate != null) {
                                setState(() {
                                  _birth_day.text = DateFormat('dd/MM/yyyy')
                                      .format(pickedate);
                                });
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'ອີເມວລ໌: (*)',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                            ),
                            style: const TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'ກະລຸນາປ້ອນອີເມວລ໌...';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'ເວັບໄຊທ໌:',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            // keyboardType: TextInputType.emailAddress,
                            controller: _web,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                            ),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // if (UserData!.user_type != 'admin')
                          const Text(
                            'ເບີໂທລະສັບ: (*)',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          // if (UserData!.user_type != 'admin')
                          const SizedBox(
                            height: 10,
                          ),
                          // if (UserData!.user_type != 'admin')
                          TextFormField(
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            controller: _phone_number,
                            decoration: InputDecoration(
                              counterText: '',
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 10, bottom: 10, right: 0),
                                child: Text(
                                  '+ 856 ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 0,
                                top: 20,
                                bottom: 20,
                                right: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '....',
                            ),
                            style: TextStyle(fontSize: 20),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '     ກະລຸນາປ້ອນເບີໂທ...';
                              }
                              return null;
                            },
                          ),
                          // if (UserData!.user_type != 'admin')
                          const SizedBox(
                            height: 10,
                          ),
                          // if (UserData!.user_type != 'admin')
                          const Text(
                            'ລະຫັດຜ່ານ: (*)',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          // if (UserData!.user_type != 'admin')
                          const SizedBox(
                            height: 10,
                          ),
                          // if (UserData!.user_type != 'admin')
                          TextFormField(
                            obscureText: _seepass1,
                            controller: _password,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _seepass1 = !_seepass1;
                                    });
                                  },
                                  icon: (_seepass1)
                                      ? Icon(
                                          Icons.visibility_off,
                                          color:
                                              Color.fromARGB(255, 238, 43, 153),
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color:
                                              Color.fromARGB(255, 238, 43, 153),
                                        ),
                                ),
                              ),
                            ),
                            style: const TextStyle(fontSize: 20),
                            validator: (value) {
                              if (widget.UserID == 0) {
                                if (value == null || value.isEmpty) {
                                  return 'ກະລຸນາປ້ອນລະຫັດຜ່ານ...';
                                }
                              }
                              return null;
                            },
                          ),
                          // if (UserData!.user_type != 'admin')
                          const SizedBox(
                            height: 10,
                          ),
                          // if (UserData!.user_type != 'admin')
                          const Text(
                            'ຍືນຍັນຫລະຫັດຜ່ານ: (*)',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          // if (UserData!.user_type != 'admin')
                          const SizedBox(
                            height: 10,
                          ),
                          // if (UserData!.user_type != 'admin')
                          TextFormField(
                            obscureText: _seepass2,
                            controller: _confirm_password,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _seepass2 = !_seepass2;
                                    });
                                  },
                                  icon: (_seepass2)
                                      ? Icon(
                                          Icons.visibility_off,
                                          color:
                                              Color.fromARGB(255, 238, 43, 153),
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color:
                                              Color.fromARGB(255, 238, 43, 153),
                                        ),
                                ),
                              ),
                            ),
                            style: const TextStyle(fontSize: 20),
                            validator: (value) {
                              if (widget.UserID == 0) {
                                if (value == null || value.isEmpty) {
                                  return 'ກະລຸນາຍືນຍັນລະຫັດຜ່ານ...';
                                }
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 0),
                  child: Row(
                    children: [
                      Text(
                        'ຂໍ້ມູນອາຊີບ',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 238, 43, 153)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ຊື່ບ່ອນເຮັດວຽກ:',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _job,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                            ),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'ຕຳແໜງ:',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _job_type,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                            ),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 0),
                  child: Row(
                    children: [
                      Text(
                        'ຂໍ້ມູນທີ່ຢູ່',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 238, 43, 153)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ບ້ານ:',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _add_village,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                            ),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'ເມືອງ:',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _add_city,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                            ),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'ແຂວງ:',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _add_province,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                            ),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'ລາຍລະອຽດເພີ່ມເຕີມ:',
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: _add_detail,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20, right: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: '.....',
                            ),
                            maxLines: 5,
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
                if (_chpass)
                  Padding(
                    child: Text(
                      'ລະຫັດຜ່ານບໍ່ກົງກັນ ກະລຸນາກວດຄືນ!',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    padding: const EdgeInsets.all(15),
                  ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    width: double.infinity,
                    child: (_pressAdd)
                        ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                  Color.fromARGB(255, 238, 43, 153)),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // ປິດ ຄີບອດ
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                setState(() {
                                  _pressAdd = true;
                                });
                                if (widget.UserID == 0) {
                                  //add new
                                  if (_password.text ==
                                      _confirm_password.text) {
                                    setState(() {
                                      _chpass = false;
                                    });

                                    bool result =
                                        await Provider.of<ContactProvider>(
                                                context,
                                                listen: false)
                                            .AddUser(
                                                _name.text,
                                                _last_name.text,
                                                Gender,
                                                _email.text,
                                                _web.text,
                                                _birth_day.text,
                                                _phone_number.text,
                                                _password.text,
                                                _job.text,
                                                _job_type.text,
                                                _add_village.text,
                                                _add_city.text,
                                                _add_province.text,
                                                _add_detail.text,
                                                imageFile);

                                    if (result) {
                                      setState(() {
                                        _pressAdd = false;
                                      });
                                      Snackbar('ບັນທຶກຂໍ້ມູນສຳເລັດ!');
                                      Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .SetAdminPage(0);
                                    } else {
                                      setState(() {
                                        _pressAdd = false;
                                      });
                                      Snackbar(
                                          'ຜິດຜາດ! ບັນທຶກຂໍ້ມູນບໍ່ສຳເລັດ.');
                                    }
                                  } else {
                                    setState(() {
                                      _pressAdd = false;
                                      _chpass = true;
                                    });
                                  }
                                } else {
                                  // update

                                  if (_password.text == '') {
                                    bool result =
                                        await Provider.of<ContactProvider>(
                                                context,
                                                listen: false)
                                            .UpdateUserEdit(
                                                widget.UserID,
                                                _name.text,
                                                _last_name.text,
                                                Gender,
                                                _email.text,
                                                _web.text,
                                                _birth_day.text,
                                                _phone_number.text,
                                                _password.text,
                                                _job.text,
                                                _job_type.text,
                                                _add_village.text,
                                                _add_city.text,
                                                _add_province.text,
                                                _add_detail.text,
                                                imageFile);

                                    if (result) {
                                      setState(() {
                                        _pressAdd = false;
                                      });
                                      Snackbar('ອັບເດດຂໍ້ມູນສຳເລັດ!');
                                      // Navigator.of(context).pop(context);

                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);

                                      // Navigator.of(context).pushAndRemoveUntil(
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             AdminHome()),
                                      //     (Route route) => false);
                                    } else {
                                      setState(() {
                                        _pressAdd = false;
                                      });
                                      Snackbar(
                                          'ຜິດຜາດ! ອັບເດດຂໍ້ມູນບໍ່ສຳເລັດ.');
                                    }
                                  } else {
                                    if (_password.text ==
                                        _confirm_password.text) {
                                      setState(() {
                                        _chpass = false;
                                      });

                                      bool result =
                                          await Provider.of<ContactProvider>(
                                                  context,
                                                  listen: false)
                                              .UpdateUserEdit(
                                                  widget.UserID,
                                                  _name.text,
                                                  _last_name.text,
                                                  Gender,
                                                  _email.text,
                                                  _web.text,
                                                  _birth_day.text,
                                                  _phone_number.text,
                                                  _password.text,
                                                  _job.text,
                                                  _job_type.text,
                                                  _add_village.text,
                                                  _add_city.text,
                                                  _add_province.text,
                                                  _add_detail.text,
                                                  imageFile);

                                      if (result) {
                                        setState(() {
                                          _pressAdd = false;
                                        });
                                        Snackbar('ອັບເດດຂໍ້ມູນສຳເລັດ!');
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                        // Navigator.of(context)
                                        //     .pushAndRemoveUntil(
                                        //         MaterialPageRoute(
                                        //             builder: (context) =>
                                        //                 AdminHome()),
                                        //         (Route route) => false);
                                      } else {
                                        setState(() {
                                          _pressAdd = false;
                                        });
                                        Snackbar(
                                            'ຜິດຜາດ! ອັບເດດຂໍ້ມູນບໍ່ສຳເລັດ.');
                                      }
                                    } else {
                                      setState(() {
                                        _pressAdd = false;
                                        _chpass = true;
                                      });
                                    }
                                  }
                                }
                              }
                            },
                            child: (widget.UserID == 0)
                                ? Text(
                                    'ບັນທຶກຂໍ້ມູນ',
                                    style: TextStyle(fontSize: 20),
                                  )
                                : Text(
                                    'ອັບເດດຂໍ້ມູນ',
                                    style: TextStyle(fontSize: 20),
                                  ),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                primary: Color.fromARGB(255, 238, 43, 153)),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> Snackbar(
      String _mg) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(_mg),
    ));
  }
}

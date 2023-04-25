import 'package:app_register_online/service/AppProvider.dart';
import 'package:app_register_online/service/AuthProvider.dart';
import 'package:app_register_online/service/ContactProvider.dart';
import 'package:flutter/material.dart';
import '../Utils/ServiceSetting.dart';
import '../model/User.dart';
import 'Form.dart';
import 'package:provider/provider.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({Key? key, required this.UserID}) : super(key: key);
  final int UserID;

  @override
  State<Userinfo> createState() => _UserinfoState();
}

enum SampleItem { user_edit, user_del }

class _UserinfoState extends State<Userinfo> with TickerProviderStateMixin {
  late TabController _tabController;
  User? UserData;

  SampleItem? selectedMenu;

  @override
  void initState() {
    super.initState();
    GetUserData();
    _tabController =
        TabController(length: 3, vsync: this); // initialise it here
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void GetUserData() {
    // print(widget.UserID);
    List<User> listUser =
        Provider.of<ContactProvider>(context, listen: false).ListUser;
    UserData = listUser.firstWhere((i) => i.id == widget.UserID);
    // print(UserData?.name);
  }

  @override
  Widget build(BuildContext context) {
    // TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'ຂໍ້ມູນສະມາຊິກ',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 238, 43, 153),
          ),
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => FormAdd(UserID: widget.UserID)));
          //     },
          //     child: Icon(
          //       Icons.edit,
          //       size: 28,
          //       color: Color.fromARGB(255, 238, 43, 153),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.all(10),
            child: PopupMenuButton<SampleItem>(
              offset: const Offset(0, 40),
              child: Icon(
                Icons.more_vert,
                size: 28,
                color: Color.fromARGB(255, 238, 43, 153),
              ),

              initialValue: selectedMenu,
              // Callback that sets the selected popup menu item.
              onSelected: (SampleItem item) {
                setState(() {
                  //print(item);
                  //selectedMenu = item;
                  if (item == SampleItem.user_edit) {
                    //print('Ok');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FormAdd(UserID: widget.UserID)));
                  }
                  if (item == SampleItem.user_del) {
                    //print('Ok');
                    _showMyDialog(widget.UserID,
                        UserData!.name + UserData!.last_name, UserData!.gender);
                  }
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SampleItem>>[
                PopupMenuItem<SampleItem>(
                  value: SampleItem.user_edit,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 238, 43, 153),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'ແກ້ໄຂຂໍ້ມູນ',
                        style:
                            TextStyle(color: Color.fromARGB(255, 238, 43, 153)),
                      ),
                    ],
                  ),
                ),
                if (Provider.of<AuthProvider>(context, listen: false)
                        .user_login!
                        .user_type ==
                    'admin')
                  PopupMenuItem<SampleItem>(
                    value: SampleItem.user_del,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 238, 43, 153),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'ລຶບຂໍ້ມູນ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 238, 43, 153)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                      padding: EdgeInsets.all(10),
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
                      child: Wrap(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'ສະຖານະ: ${UserData?.user_type}',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.orange),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    (UserData?.gender == 'male')
                                        ? Text(
                                            'ທ່ານ ${UserData?.name}',
                                            style: TextStyle(fontSize: 22),
                                          )
                                        : Text(
                                            'ທ່ານ ນ ${UserData?.name}',
                                            style: TextStyle(fontSize: 22),
                                          ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        'ວັນເດືອນປີເກີດ: ${UserData?.birth_day}',
                                        style: TextStyle(fontSize: 16)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TabBar(
                                      controller: _tabController,
                                      labelColor:
                                          Color.fromARGB(255, 238, 43, 153),
                                      labelStyle: TextStyle(fontSize: 16),
                                      unselectedLabelColor: Colors.grey,
                                      indicatorColor:
                                          Color.fromARGB(255, 238, 43, 153),
                                      indicatorWeight: 3,
                                      // indicatorSize: TabBarIndicatorSize.tab,
                                      tabs: [
                                        Tab(text: 'ທີ່ຢູ່'),
                                        Tab(text: 'ຕິດຕໍ່'),
                                        Tab(text: 'ອາຊີບ'),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ບ້ານ: ${UserData?.add_village}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'ເມືອງ: ${UserData?.add_city}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'ແຂວງ: ${UserData?.add_province}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'ລາຍລະອຽດເພີ່ມເຕີມ: ${UserData?.add_detail}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ເບີໂທ: +856 ${UserData?.tel}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'ອີເມວລ໌: ${UserData?.email}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'ເວັບໄຊທ໌: ${UserData?.web}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ອາຊີບ: ${UserData?.job}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'ຕຳແໜ່ງ: ${UserData?.job_type}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            top: 20,
            left: 40,
            child: (UserData?.image == '')
                ? CircleAvatar(
                    child: Icon(
                      Icons.account_circle,
                      size: 130,
                      color: Colors.white,
                    ),
                    backgroundColor: Color.fromARGB(255, 238, 43, 153),
                    radius: 65,
                  )
                : CircleAvatar(
                    maxRadius: 65,
                    backgroundImage:
                        NetworkImage('$BaseURL/img/${UserData?.image}'),
                  )

            //  CircleAvatar(
            //   child: Icon(
            //     Icons.account_circle,
            //     size: 130,
            //     color: Colors.white,
            //   ),
            //   backgroundColor: Color.fromARGB(255, 238, 43, 153),
            //   radius: 65,
            // ),
            ),
      ]),
    );
  }

  /// dialog confirm
  Future<void> _showMyDialog(int UserID, String name, String gender) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ທ່ານແນ່ໃຈບໍ່ ທີ່ຈະລຶບຜູ້ໃຊ້ນີ້?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                (gender == 'male')
                    ? Text('ທ່ານ ' + name)
                    : Text('ທ່ານ ນ ' + name),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ຕົກລົງ'),
              onPressed: () async {
                // Navigator.of(context).pop();
                var result =
                    await Provider.of<ContactProvider>(context, listen: false)
                        .DeleteUser(UserID);

                if (result) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }
              },
            ),
            TextButton(
              child: const Text('ຍົກເລີກ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

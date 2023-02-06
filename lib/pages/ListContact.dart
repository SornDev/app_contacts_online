import 'package:flutter/material.dart';
import '../Utils/ServiceSetting.dart';
import '../model/User.dart';
import '../service/AppProvider.dart';
import 'Userinfo.dart';
import 'Form.dart';
import 'package:provider/provider.dart';

class ListContact extends StatefulWidget {
  const ListContact({super.key});

  @override
  State<ListContact> createState() => _ListContactState();
}

enum SampleItem { user_info, user_edit, user_logout }

class _ListContactState extends State<ListContact> {
  @override
  void initState() {
    super.initState();
    CheckGetUser();
  }

  void CheckGetUser() async {
    Provider.of<AppProvider>(context, listen: false).GetAllUser();
    // AllList = Provider.of<AppProvider>(context, listen: false).ListUser;
  }

  SampleItem? selectedMenu;

  // late List<User> AllList;

  // void filterSearchResults(String query) {
  //   List<String> dummySearchList = List<String>();
  //   dummySearchList.addAll(duplicateItems);
  //   if (query.isNotEmpty) {
  //     List<String> dummyListData = List<String>();
  //     dummySearchList.forEach((item) {
  //       if (item.contains(query)) {
  //         dummyListData.add(item);
  //       }
  //     });
  //     setState(() {
  //       items.clear();
  //       items.addAll(dummyListData);
  //     });
  //     return;
  //   } else {
  //     setState(() {
  //       items.clear();
  //       items.addAll(duplicateItems);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, Auth, child) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: SafeArea(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ລະບົບສະມາຊິກ ອອນໄລທ໌',
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 238, 43, 153)),
                          ),
                        ),
                        PopupMenuButton<SampleItem>(
                          offset: const Offset(0, 70),
                          child: (Auth.user_login!.image != '')
                              ? CircleAvatar(
                                  maxRadius: 26,
                                  backgroundImage: NetworkImage(BaseURL +
                                      '/img/' +
                                      Auth.user_login!.image),
                                )
                              : CircleAvatar(
                                  maxRadius: 26,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 238, 43, 153),
                                ),

                          initialValue: selectedMenu,
                          // Callback that sets the selected popup menu item.
                          onSelected: (SampleItem item) {
                            setState(() {
                              //print(item);
                              //selectedMenu = item;
                              if (item == SampleItem.user_info) {
                                //print('Ok');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Userinfo(
                                              UserID: Auth.user_login!.id,
                                            )));
                              }
                              if (item == SampleItem.user_edit) {
                                //print('Ok');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FormAdd(
                                              UserID: Auth.user_login!.id,
                                            )));
                              }
                              if (item == SampleItem.user_logout) {
                                Future<bool> result = Provider.of<AppProvider>(
                                        context,
                                        listen: false)
                                    .LoginOut();

                                // print('logout');
                              }
                            });
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<SampleItem>>[
                            PopupMenuItem<SampleItem>(
                              value: SampleItem.user_info,
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.info,
                                    color: Color.fromARGB(255, 238, 43, 153),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'ເບີ່ງຂໍ້ມູນ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 238, 43, 153)),
                                  ),
                                ],
                              ),
                            ),
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
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 238, 43, 153)),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem<SampleItem>(
                              value: SampleItem.user_logout,
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Color.fromARGB(255, 238, 43, 153),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'ອອກຈາກລະບົບ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 238, 43, 153)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15, left: 15, bottom: 10),
                    child: TextField(
                      onChanged: (value) {
                        Provider.of<AppProvider>(context, listen: false)
                            .SearchContact(value);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(
                              left: 20, top: 10, bottom: 10, right: 0),
                          child: Icon(
                            Icons.search,
                            size: 35,
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
                        hintText: 'ຄົ້ນຫາຂໍ້ມູນ...',
                      ),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 15, left: 15, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'ລາຍການ ສະມາຊິກ',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 238, 43, 153)),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Provider.of<AppProvider>(context, listen: false)
                                  .GetAllUser();
                            },
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      )),
                  Expanded(
                      child: Container(
                          // padding: EdgeInsets.only(right: 15, left: 15),
                          child: (Auth.Loading_list_contact)
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        Color.fromARGB(255, 238, 43, 153)),
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.only(
                                      right: 15, left: 15, bottom: 10),
                                  itemCount: Auth.ListUserSearch.length,
                                  itemBuilder: ((context, index) {
                                    return ListContact(
                                        Auth.ListUserSearch[index].image,
                                        Auth.ListUserSearch[index].name,
                                        Auth.ListUserSearch[index].tel,
                                        Auth.ListUserSearch[index].id);
                                  }),
                                )
                          // ListView(
                          //   padding: EdgeInsets.only(right: 15, left: 15, bottom: 10),
                          //   children: [
                          //     ListContact('asssss', '88888'),
                          //     ListContact('asssss', '88888'),
                          //     ListContact('asssss', '88888'),
                          //     ListContact('asssss', '88888'),
                          //     ListContact('asssss', '88888'),
                          //     ListContact('asssss', '88888'),
                          //     ListContact('asssss', '88888'),
                          //     ListContact('asssss', '88888'),
                          //     ListContact('asssss', '88888'),
                          //     ListContact('asssss', '88888'),
                          //     ListContact('asssss', '88888'),
                          //     ListContact('asssss', '88888'),
                          //   ],
                          // ),
                          ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget ListContact(String img, String title, String subtxt, int UserID) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: (img == '')
          ? CircleAvatar(
              maxRadius: 30,
              child: Icon(
                Icons.account_circle,
                size: 50,
                color: Colors.white,
              ),
              backgroundColor: Color.fromARGB(255, 238, 43, 153),
            )
          : CircleAvatar(
              maxRadius: 30,
              backgroundImage: NetworkImage(BaseURL + '/img/' + img),
            ),
      title: Text(title),
      subtitle: Text(subtxt),
      trailing: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Userinfo(
                        UserID: UserID,
                      )));
        },
        child: Icon(
          Icons.info,
          size: 40,
          color: Color.fromARGB(255, 238, 43, 153),
        ),
      ),
    );
  }
}

import 'package:azlistview/azlistview.dart';
import 'package:call_recorder/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../resources/values_manager.dart';

class AlphabetScrollPage extends StatefulWidget {
  final List<Contact> contactList;
  final ValueChanged<Contact> onClickedContact;
  AlphabetScrollPage(this.contactList, this.onClickedContact,{super.key});

  @override
  State<AlphabetScrollPage> createState() =>
      _AlphabetScrollPageState(contactList);
}

class _AlphabetScrollPageState extends State<AlphabetScrollPage> {
  List<Contact> contactList = [];

  _AlphabetScrollPageState(this.contactList);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initList(widget.contactList);
  }

  void initList(List<Contact> items) {
    this.contactList = items
        .map((contact) => Contact(
            name: contact.name,
            mob: contact.mob,
            Tag: contact.name[0].toUpperCase(),
            imagePath: contact.imagePath))
        .toList();
    SuspensionUtil.sortListBySuspensionTag(this.contactList);
    SuspensionUtil.setShowSuspensionStatus(this.contactList);
  }

  @override
  Widget build(BuildContext context) {
    return AzListView(
      padding: EdgeInsets.all(AppPadding.p8),
        data: contactList,
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          final contact = contactList[index];

          return _buildContactCard(contact);
        },

    // indexBarOptions: IndexBarOptions(
    //   needRebuild: false,
    //   indexHintAlignment: Alignment.centerRight,
    // ),
    );
  }

  Widget _buildContactCard(Contact contact) {
    final tag = contact.getSuspensionTag();
    final offstag = !contact.isShowSuspension;
    return Container(
      color: ColorManager.background,
      child: Column(
        children: [
          Divider(
            thickness: AppSize.s1_5,
          ),
          Offstage(offstage:offstag,child: _buildHeader(tag)),
          Divider(
            thickness: AppSize.s1_5,
          ),
          ListTile(
            leading: CircleAvatar(
              maxRadius: AppSize.s28,
              minRadius: AppSize.s20,
              //radius: AppSize.s28,
              backgroundImage: AssetImage(contact.imagePath),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p8),
              child: Text(
                contact.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            subtitle: Text(
              contact.mob,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Icon(Icons.call_outlined),
            onTap: () =>widget.onClickedContact(contact),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String tag){
    return Container(height: 40,alignment: Alignment.centerLeft,child: Text('$tag',softWrap: false,style: Theme.of(context).textTheme.displayLarge,),);
  }
}

class Contact extends ISuspensionBean {
  //Data Class
  String imagePath;
  String name;
  String mob;
  String Tag;

  Contact(
      {required this.name,
      required this.mob,
      required this.Tag,
      required this.imagePath});

  @override
  String getSuspensionTag() {
    // TODO: implement getSuspensionTag
    return Tag;
  }
}

import 'dart:typed_data';

import 'package:azlistview/azlistview.dart';
import 'package:call_recorder/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../resources/values_manager.dart';

class AlphabetScrollPage extends StatefulWidget {
  final List<ContactSingle> contactList;
  final ValueChanged<ContactSingle> onClickedContact;
  AlphabetScrollPage(this.contactList, this.onClickedContact,{super.key});

  @override
  State<AlphabetScrollPage> createState() =>
      _AlphabetScrollPageState(contactList);
}

class _AlphabetScrollPageState extends State<AlphabetScrollPage> {
  List<ContactSingle> contactList = [];

  _AlphabetScrollPageState(this.contactList);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initList(widget.contactList);
  }

  void initList(List<ContactSingle> items) {
    this.contactList = items
        .map((contact) => ContactSingle(
            name: contact.name,
            mob: contact.mob,
          // Tag: contact.Tag,
            Tag: contact.name[0].toUpperCase(),
            image: contact.image))
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

  Widget _buildContactCard(ContactSingle contact) {
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
            leading:  (contact.image != null && contact.image.isNotEmpty)
                ? CircleAvatar(
              backgroundImage: MemoryImage(contact.image),
            )
                : CircleAvatar(
              child: Text(contact.Tag),
              backgroundColor: Theme.of(context).colorScheme.secondary,
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

class ContactSingle extends ISuspensionBean {
  //Data Class
  Uint8List image;
  String name;
  String mob;
  String Tag;

  ContactSingle(
      {required this.name,
      required this.mob,
      required this.Tag,
      required this.image});

  @override
  String getSuspensionTag() {
    // TODO: implement getSuspensionTag
    return Tag;
  }
}

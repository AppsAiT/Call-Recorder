import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class CallHistoryLoader extends StatelessWidget {
   List<ContactHistory> contactList;
   ValueChanged<ContactHistory> onClickedContact;
   CallHistoryLoader(this.contactList,this.onClickedContact,{super.key});

 //  getSortedList(contactList);
  void getSortedList(List<ContactHistory> cont){
    this.contactList = cont
        .map((contact) => ContactHistory(
        name: contact.name,
        mob: contact.mob,
        // Tag: contact.Tag,
        tag: contact.tag,
        category: contact.category,
        imagePath: contact.imagePath))
        .toList();
    SuspensionUtil.sortListBySuspensionTag(this.contactList);
    SuspensionUtil.setShowSuspensionStatus(this.contactList);
  }

  @override
  Widget build(BuildContext context) {
    //return Center(child:Text(contactList[4].category));
    return Expanded(
      child: AzListView(
        padding: EdgeInsets.all(AppPadding.p8),
        data: contactList,
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          final contact = contactList[index];

          return _buildContactCard(context,contact);
        },

      ),
    );
  }
  Widget _buildContactCard(BuildContext context,ContactHistory contact) {
    final tag = contact.getSuspensionTag();
    final offstag = !contact.isShowSuspension;
    return Container(

      color: ColorManager.background,
      child: Column(
        children: [
          Divider(
            thickness: AppSize.s1_5,
          ),
          Offstage(offstage:offstag,child: _buildHeader(context,tag)),
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
            onTap: () =>onClickedContact(contact),
          ),
        ],
      ),
    );
  }
  Widget _buildHeader(BuildContext context,String tag) {
    return Container(height: 40,
      alignment: Alignment.centerLeft,
      child: Text('$tag', softWrap: false, style: Theme
          .of(context)
          .textTheme
          .displayLarge,),);
  }
}


class ContactHistory extends ISuspensionBean {
  //Data Class
  String imagePath;
  String name;
  String mob;
  String category;
  String tag;

  ContactHistory(
      {required this.name,
        required this.mob,
        required this.category,
        required this.tag,
        required this.imagePath});

  @override
  String getSuspensionTag() {
    // TODO: implement getSuspensionTag
    return tag;
  }
}
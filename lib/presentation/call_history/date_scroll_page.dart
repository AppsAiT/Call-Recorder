import 'dart:async';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class DateScrollPage extends StatefulWidget {

   final List<ContactHistory> contactList;
   final ValueChanged<ContactHistory> onClickedContact;
  DateScrollPage(this.contactList, this.onClickedContact,{super.key});

  @override
  State<DateScrollPage> createState() => _DateScrollPageState(contactList);
}

class _DateScrollPageState extends State<DateScrollPage> {
  List<ContactHistory> contactList = [];
  //StreamController<List<ContactHistory>> _streamController= StreamController<List<ContactHistory>>();
  _DateScrollPageState(this.contactList);

  @override
  void initState() {
    initList(widget.contactList);
   // _streamController.sink.add(widget.contactList);
    // TODO: implement initState
    super.initState();

  }

  void initList(List<ContactHistory> items) {
    this.contactList = items
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
    return Expanded(
      child: AzListView(
        padding: EdgeInsets.all(AppPadding.p8),
        data: contactList,
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          final contact = contactList[index];

          return _buildCallHistoryCard(contact);
        },

        indexBarOptions: IndexBarOptions(
          indexHintWidth: 0,
          needRebuild: false,
          indexHintAlignment: Alignment.centerRight,
        ),
      ),
    );
  }

  Widget _buildCallHistoryCard(ContactHistory contact) {
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
              maxRadius: AppSize.s20,
              minRadius: AppSize.s20,
              //radius: AppSize.s28,
              backgroundImage: AssetImage(contact.imagePath),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _getCallCategory(contact.category),
                  SizedBox(width: AppSize.s8,),
                  Text(
                    contact.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            subtitle: Text(
              contact.mob,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: Container(
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(ImageAssets.playRecBlueIc,height: 30,width: 20,),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(ImageAssets.callDarkIc,height: 20,width: 20,),
                  ),
                  SvgPicture.asset(ImageAssets.menuIc,height: 20,width: 20,),

                ],
              ),
            ),
            onTap: () =>widget.onClickedContact(contact),
          ),
        ],
      ),
    );
  }
  Widget _buildHeader(String tag) {
    return Container(height: 40,
      alignment: Alignment.centerLeft,
      child: Text('$tag', softWrap: false, style: Theme
          .of(context)
          .textTheme
          .displayLarge,),);
  }

  Widget _getCallCategory(String category){
    switch(category){
      case "incoming":
        return SvgPicture.asset(ImageAssets.incCallIc,height: 20,width: 20,);
        break;
      case "outgoing":
        return SvgPicture.asset(ImageAssets.outcomingIc,height: 20,width: 20,);
        break;
      case "missed":
        return SvgPicture.asset(ImageAssets.missedCallIc,height: 20,width: 20,);
        break;
      default:
        return Icon(Icons.call_outlined);
    }
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
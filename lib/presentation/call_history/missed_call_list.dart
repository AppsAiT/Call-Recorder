import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'date_scroll_page.dart';



class MissedCallList extends StatefulWidget {
  final List<ContactHistory> contactList;
  final ValueChanged<ContactHistory> onClickedContact;
  MissedCallList(this.contactList, this.onClickedContact,{super.key});


  @override
  State<MissedCallList> createState() => _MissedCallListState(contactList);
}

class _MissedCallListState extends State<MissedCallList> {
  List<ContactHistory> contactList = [];
  //StreamController<List<ContactHistory>> _streamController= StreamController<List<ContactHistory>>();
  _MissedCallListState(this.contactList);

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

          return _buildContactCard(contact);
        },

        // indexBarOptions: IndexBarOptions(
        //   needRebuild: false,
        //   indexHintAlignment: Alignment.centerRight,
        // ),
      ),
    );
  }

  Widget _buildContactCard(ContactHistory contact) {
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
  Widget _buildHeader(String tag) {
    return Container(height: 40,
      alignment: Alignment.centerLeft,
      child: Text('$tag', softWrap: false, style: Theme
          .of(context)
          .textTheme
          .displayLarge,),);
  }
}
import 'package:moneytos/main.dart';
import 'package:moneytos/screens/dash_settingscreen/setting_account_verifiedDialogScreen.dart';
import 'package:moneytos/utils/import_helper.dart';

class SettingVerificationSuccessfullyScreen extends StatefulWidget {
  const SettingVerificationSuccessfullyScreen({Key? key}) : super(key: key);

  @override
  State<SettingVerificationSuccessfullyScreen> createState() =>
      _SettingVerificationSuccessfullyScreenState();
}

class _SettingVerificationSuccessfullyScreenState
    extends State<SettingVerificationSuccessfullyScreen> {
  bool load = false;
  String status = '';
  String passport_type = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setdata();
    getDocumentApi();
  }

  getDocumentApi() async {
    documentdetaillist.clear();
    setState(() {
      doc_load = true;
    });
    await Webservices.DocumentDetailRequest(context, documentdetaillist);
    setState(() {
      doc_load = false;
    });
  }

  setdata() {
    status = documentdetaillist.isNotEmpty
        ? "${documentdetaillist[0].documentStatus == null || documentdetaillist[0].documentStatus.toString().isEmpty ? "" : documentdetaillist[0].documentStatus}"
        : '';
    passport_type = documentdetaillist.isNotEmpty
        ? "${documentdetaillist[0].documentType == null || documentdetaillist[0].documentType.toString().isEmpty ? "" : documentdetaillist[0].documentType}"
        : '';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
          //height:MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            color: MyColors.whiteColor,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    hSizedBox5,

                    Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        status == 'Pending'
                            ? 'assets/logo/confirm_img.svg'
                            : status == 'Rejected'
                                ? 'assets/images/failed.svg'
                                : 'assets/logo/success_img.svg',
                      ),
                    ),

                    hSizedBox4,

                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        status,
                        style: TextStyle(
                          color: status == 'Pending'
                              ? MyColors.yellow
                              : status == 'Rejected'
                                  ? MyColors.red
                                  : MyColors.greenColor2,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'assets/fonts/raleway/raleway_bold.ttf',
                        ),
                      ),
                    ),

                    hSizedBox1,

                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 10),
                      alignment: Alignment.center,
                      child: Text(
                        passport_type,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: MyColors.blackColor.withOpacity(0.60),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.4,
                          fontFamily: 'assets/fonts/raleway/raleway_medium.ttf',
                        ),
                      ),
                    ),

                    hSizedBox2,
                    hSizedBox1,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          transferbottomsheet(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => FrontImageScreen()));
                        },
                        child: Cameracard(
                          'assets/icons/choose_doc/camera.svg',
                          documentdetaillist.isNotEmpty
                              ? "${documentdetaillist[0].ducumentFrontImage == null || documentdetaillist[0].ducumentFrontImage.toString().isEmpty ? "" : documentdetaillist[0].ducumentFrontImage}"
                              : '',
                        ),
                      ),
                    ),
                    hSizedBox2,

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {},
                        child: Cameracard(
                          'assets/icons/choose_doc/camera.svg',
                          documentdetaillist.isNotEmpty
                              ? "${documentdetaillist[0].ducumentBackImage == null || documentdetaillist[0].ducumentBackImage.toString().isEmpty ? "" : documentdetaillist[0].ducumentBackImage}"
                              : '',
                        ),
                      ),
                    ),

                    hSizedBox3,
                    // load == true ? CircularProgressIndicator(color: MyColors.lightblueColor,):
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const CustomButton2(
                          btnname: 'Upload Again',
                          bg_color: MyColors.lightblueColor,
                          bordercolor: MyColors.lightblueColor,
                        ),
                      ),
                    ),

                    hSizedBox3,
                  ],
                ),
              ),
            ),
          ),
        ),
        load == true
            ? Container(
                color: MyColors.primaryColor.withOpacity(0.060),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.lightblueColor,
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  Cameracard(String img, String networkImg) {
    return Container(
      height: 110,
      //  padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          //  stops: [0.0, 1.0],
          colors: [
            MyColors.color_3F84E5.withOpacity(0.06),
            MyColors.color_3F84E5.withOpacity(0.30),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          networkImg.isNotEmpty || networkImg != ''
              ? SizedBox(
                  height: 60,
                  width: 60,
                  child: Image.network(networkImg),
                )
              : SvgPicture.asset(img),
        ],
      ),
    );
  }

  transferbottomsheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      // anchorPoint: Offset(20.0, 30.0),
      backgroundColor: MyColors.lightblueColor.withOpacity(0.10),
      builder: (context) {
        return Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.82,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: const SettingAccountVerifiedDialogScreen(),
          ),
        );
      },
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moneytos/constance/myColors/my_color.dart';
import 'package:moneytos/constance/myStrings/my_string.dart';
import 'package:moneytos/services/webservices.dart';
import 'package:moneytos/view/dash_settingscreen/setting_account_verifiedDialogScreen.dart';

import '../../constance/sizedbox/sized_box.dart';
import '../../model/documentDetailModel.dart';


class SettingVerificationSuccessfullyScreen extends StatefulWidget {
  const SettingVerificationSuccessfullyScreen({Key? key}) : super(key: key);

  @override
  State<SettingVerificationSuccessfullyScreen> createState() => _SettingVerificationSuccessfullyScreenState();
}

class _SettingVerificationSuccessfullyScreenState extends State<SettingVerificationSuccessfullyScreen> {
  bool load = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocumentApi();
  }
  List<DocumentDataDetailModel> documentdetaillist = [];

  getDocumentApi()async{
    documentdetaillist.clear();
    setState(() {
      load = true;
    });
    await Webservices.DocumentDetailRequest(context, documentdetaillist);
    setState(() {
      load = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: */
/*[
            hSizedBox5,

            Container(
                alignment: Alignment.center,
                child: SvgPicture.asset("assets/logo/success_img.svg")
            ),

            hSizedBox4,

            Container(
              alignment: Alignment.center,
              child: Text(
                documentdetaillist.length > 0 ? "${documentdetaillist[0].documentStatus == null || documentdetaillist[0].documentStatus.toString().isEmpty? "": documentdetaillist[0].documentStatus}" : "",
                //   MyString.submitted_Successfuly,
                style: TextStyle(
                    color: MyColors.greenColor2,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: "assets/fonts/raleway/raleway_bold.ttf"),
              ),
            ),

            hSizedBox1,

            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width /10),
              alignment: Alignment.center,
              child: Text(
                documentdetaillist.length > 0 ? "${documentdetaillist[0].documentType == null || documentdetaillist[0].documentType.toString().isEmpty? "": documentdetaillist[0].documentType}" : "",

             //   MyString.submitted_Successfuly_des,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyColors.blackColor.withOpacity(0.60),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.4,
                    fontFamily: "assets/fonts/raleway/raleway_medium.ttf"),
              ),
            ),

            hSizedBox2,
            hSizedBox1,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              width: double.infinity,
              alignment: Alignment.center,
              child:  GestureDetector(
                onTap: () {
                  transferbottomsheet(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => FrontImageScreen()));
                },
                child: Cameracard(
                  "assets/icons/choose_doc/camera.svg",
                  documentdetaillist.length > 0 ? "${documentdetaillist[0].ducumentFrontImage == null || documentdetaillist[0].ducumentFrontImage.toString().isEmpty? "": documentdetaillist[0].ducumentFrontImage}" :"",

                ),
              ),

            ),
            hSizedBox2,

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              width: double.infinity,
              alignment: Alignment.center,
              child:  GestureDetector(
                onTap: () {},
                child: Cameracard(
                  "assets/icons/choose_doc/camera.svg",
                  documentdetaillist.length > 0 ? "${documentdetaillist[0].ducumentBackImage == null || documentdetaillist[0].ducumentBackImage.toString().isEmpty? "": documentdetaillist[0].ducumentBackImage}" : ""

                ),
              ),

            ),

            hSizedBox3,

          ]*/ /*
,
        ),
      ),
    );
  }

  Cameracard( String img,String network_img) {
    return Container(
      height:  110,
      //  padding: EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          //  stops: [0.0, 1.0],
          colors: [
            MyColors.color_3F84E5.withOpacity(0.06),
            MyColors.color_3F84E5.withOpacity(0.30),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          network_img.isNotEmpty || network_img  != "" ?
          Container(
              height: 60,
              width: 60,
              child: Image.network(network_img)) :
          SvgPicture.asset(img),
        ],
      ),
    );
  }

  transferbottomsheet(BuildContext context){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
        ),
        // anchorPoint: Offset(20.0, 30.0),
        backgroundColor: MyColors.lightblueColor.withOpacity(0.10),
        builder: (context) {
          return Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 0.82,
              child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                  child: SettingAccountVerifiedDialogScreen())
          );}
    );
  }
}
*/

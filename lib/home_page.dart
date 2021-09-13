import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form_fields/user_model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late UserModel userModel = new UserModel(
    "",
    18,
    new List<String>.empty(growable: true),
  );

  @override
  void initState() {
    super.initState();

    userModel.emails.add("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Form"),
        backgroundColor: Colors.redAccent,
      ),
      body: _uiWidget(),
    );
  }

  Widget _uiWidget() {
    return new Form(
      key: globalFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: FormHelper.inputFieldWidgetWithLabel(
                  context,
                  Icon(Icons.web),
                  "name",
                  "User Name",
                  "",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'User Name can\'t be empty.';
                    }

                    return null;
                  },
                  (onSavedVal) => {
                    this.userModel.userName = onSavedVal,
                  },
                  initialValue: this.userModel.userName,
                  obscureText: false,
                  borderFocusColor: Theme.of(context).primaryColor,
                  prefixIconColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  borderRadius: 2,
                  paddingLeft: 0,
                  paddingRight: 0,
                  showPrefixIcon: false,
                  fontSize: 13,
                  labelFontSize: 13,
                  onChange: (val) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: FormHelper.inputFieldWidgetWithLabel(
                  context,
                  Icon(Icons.web),
                  "name",
                  "Age",
                  "",
                  (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return 'Age can\'t be empty.';
                    }

                    return null;
                  },
                  (onSavedVal) => {
                    this.userModel.userAge = int.parse(onSavedVal),
                  },
                  initialValue: this.userModel.userAge.toString(),
                  obscureText: false,
                  borderFocusColor: Theme.of(context).primaryColor,
                  prefixIconColor: Theme.of(context).primaryColor,
                  borderColor: Theme.of(context).primaryColor,
                  borderRadius: 2,
                  paddingLeft: 0,
                  paddingRight: 0,
                  showPrefixIcon: false,
                  fontSize: 13,
                  labelFontSize: 13,
                  onChange: (val) {},
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Email Address(s)",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  emailsContainerUI(),
                  new Center(
                    child: FormHelper.submitButton(
                      "Save",
                      () async {
                        if (validateAndSave()) {
                          print(this.userModel.toJson());
                        }
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailsContainerUI() {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: this.userModel.emails.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Row(children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: emailUI(index),
              ),
            ]),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget emailUI(index) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: FormHelper.inputFieldWidget(
              context,
              Icon(Icons.web),
              "email_$index",
              "",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return 'Email ${index + 1} can\'t be empty.';
                }

                return null;
              },
              (onSavedVal) => {
                this.userModel.emails[index] = onSavedVal,
              },
              initialValue: this.userModel.emails[index],
              obscureText: false,
              borderFocusColor: Theme.of(context).primaryColor,
              prefixIconColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              borderRadius: 2,
              paddingLeft: 0,
              paddingRight: 0,
              showPrefixIcon: false,
              fontSize: 13,
              onChange: (val) {},
            ),
          ),
          Visibility(
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addEmailControl();
                },
              ),
            ),
            visible: index == this.userModel.emails.length - 1,
          ),
          Visibility(
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  removeEmailControl(index);
                },
              ),
            ),
            visible: index > 0,
          )
        ],
      ),
    );
  }

  void addEmailControl() {
    setState(() {
      this.userModel.emails.add("");
    });
  }

  void removeEmailControl(index) {
    setState(() {
      if (this.userModel.emails.length > 1) {
        this.userModel.emails.removeAt(index);
      }
    });
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

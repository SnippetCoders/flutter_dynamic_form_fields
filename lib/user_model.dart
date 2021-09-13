class UserModel {
  late String userName;
  late int userAge;
  late List<String> emails;

  UserModel(this.userName, this.userAge, this.emails);

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    userAge = json['UserAge'];
    emails = json['Emails'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['UserAge'] = this.userAge;
    data['Emails'] = this.emails;
    return data;
  }
}

/*
{
    "UserName": "Raman",
    "UserAge": 30,
    "Emails": [
        "raman@snippetcoder.com",
        "snippetcoder@gmail.com"
    ]
}
*/
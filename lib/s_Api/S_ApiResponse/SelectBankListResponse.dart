class PostsBankList {
  final List<BankListSelectPost>? bankList;
  PostsBankList({
    this.bankList,
  });

  factory PostsBankList.fromJson(List<dynamic> parsedJson) {

    List<BankListSelectPost>? posts = <BankListSelectPost>[];
    posts = parsedJson.map((i)=>BankListSelectPost.fromJson(i)).toList();

    return new PostsBankList(
        bankList: posts
    );
  }
}

class BankListSelectPost{
  final String? id;
  final String? name;

  BankListSelectPost({
    this.id,
    this.name
  });

  factory BankListSelectPost.fromJson(Map<String, dynamic> json){
    return new BankListSelectPost(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}

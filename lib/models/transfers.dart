class Transfers {
  final String name;
  final String desc;
  final String sum;
  final String time;
  Transfers({
    required this.name,
    required this.desc,
    required this.sum,
    required this.time,
  });

  factory Transfers.fromJson(Map<String, dynamic> json) => Transfers(
        name: json['name'],
        desc: json['desc'],
        sum: json['sum'],
        time: json['time'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'desc': desc,
        'sum': sum,
        'time': time,
      };
}

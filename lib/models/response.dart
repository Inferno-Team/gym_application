

class Response{
  int code;
  String msg;
  Response({required this.code , required this.msg});
  factory Response.empty()=>Response(code: 404, msg: 'Error');
  factory Response.fromJson(dynamic json)
    => Response(code:json['code'] , msg:json['msg']);
}
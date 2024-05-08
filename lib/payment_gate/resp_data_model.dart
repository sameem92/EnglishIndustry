// ignore_for_file: unnecessary_this

class RespDataModel
{
  String resKey ="";
  String resValue ="";


  RespDataModel({ this.resKey,  this.resValue});


  @override
  String toString() {
    return '{ ${this.resKey}, ${this.resValue} }';
  }
}
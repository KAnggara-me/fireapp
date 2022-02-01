import 'package:equatable/equatable.dart';

abstract class DeviceEvent extends Equatable {}

class GetAllDevice implements DeviceEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

import 'package:equatable/equatable.dart';
import 'package:fire_app/models/device.dart';

abstract class DeviceState extends Equatable {}

class DeviceLoading implements DeviceState {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class DeviceLoaded implements DeviceState {
  final List<Device> devices;

  const DeviceLoaded(this.devices);

  @override
  List<Object?> get props => [devices];

  @override
  bool? get stringify => true;
}

class DeviceError implements DeviceState {
  final String error;
  const DeviceError(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];

  @override
  // TODO: implement stringify
  bool? get stringify => false;
}

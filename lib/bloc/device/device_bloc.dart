import 'package:fire_app/bloc/device/device_event.dart';
import 'package:fire_app/bloc/device/device_state.dart';
import 'package:fire_app/repository/device_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_app/models/device.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository _deviceRepository;

  DeviceBloc(this._deviceRepository) : super(DeviceLoading()) {
    on<GetAllDevice>((event, emit) async {
      final List<Device> devices = await _deviceRepository.fetchDevice();
      emit(DeviceLoaded(devices));
    });
  }
}

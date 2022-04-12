<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Setting;

class SettingController extends Controller
{
  public function index()
  {
    $settings = Setting::get()->last();
    return response()->json($settings, 200, [], JSON_NUMERIC_CHECK);
  }

  public function update(Request $request)
  {
    $setting = Setting::get()->last();
    if (isset($setting)){
      $setting->update($request->all());
      $data = [
        'mq2' => $setting->mq2,
        'temp' => $setting->temperature,
        'humidity' => $setting->humidity,
        'status' => 'success',
        'message' => 'Setting updated successfully.'
      ];
    } else {
      Setting::create($request->all());
      $data = [
        'mq2' => $request->mq2,
        'temp' => $request->temperature,
        'humidity' => $request->humidity,
        'status' => 'success',
        'message' => 'Setting add successfully.'
      ];
    }
    return response()->json($data, 200, [], JSON_NUMERIC_CHECK);
  }
}

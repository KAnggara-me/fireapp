<?php

namespace App\Http\Controllers;

use App\Models\Log;
use App\Models\Board;
use App\Models\Setting;

class LogController extends Controller
{
  public function index()
  {
    $suhu = Setting::get()->last();
    if (isset($suhu)) {
      $mq2 = $suhu->mq2;
      $humi = $suhu->humidity;
      $temp = $suhu->temperature;
      $omq2 = $suhu->mq2_operator;
      $otemp = $suhu->temp_operator;
      $ohumi = $suhu->humi_operator;
      $data = Log::where('temp', $otemp, $temp)
        ->orWhere('humidity', $ohumi, $humi)
        ->orWhere('mq2', $omq2, $mq2)
        ->orderBy('id', 'desc')
        ->get();
      return response()->json($data, 200, [], JSON_NUMERIC_CHECK);
    } else {
      return response()->json(["messege" => "No Setting Content"], 404);
    }
  }

  public function show($id)
  {
    $suhu = Setting::get()->last();
    $board = Board::where('id', '=', $id)->first();
    if (isset($board)) {
      $mq2 = $suhu->mq2;
      $temp = $suhu->temperature;
      $omq2 = $suhu->mq2_operator;
      $otemp = $suhu->temp_operator;
      $sensor = Log::where('board_id', '=', $id)
        ->where(
          function ($query) use ($otemp, $temp, $omq2, $mq2) {
            $query->where('temp', $otemp, $temp)
              ->orWhere('mq2', $omq2, $mq2);
          }
        );
      $data = $sensor->orderBy('id', 'desc')->get();
      $fcm = $sensor->first();
      if (isset($fcm)) {
        fcm()
          ->toTopic('api')
          ->priority('high')
          ->timeToLive(0)
          ->notification([
            'title' => $fcm->notif,
            'body' => 'Lokasi ' . $fcm->ruangan . ' Di ' . $board->name,
            'sound' => 'default',
          ])
          ->send();
      }
    } else {
      $data = [];
    }
    return response()->json($data, 200, [], JSON_NUMERIC_CHECK);
  }

  public function destroy($id)
  {
    Log::where('board_id', $id)->delete();
    return response()->json(['message' => 'Log Cleared'], 200);
  }
}

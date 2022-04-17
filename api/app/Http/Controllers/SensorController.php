<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Models\Setting;
use App\Models\Sensor;
use App\Models\Board;
use App\Models\Log;

class SensorController extends Controller
{
  public function index()
  {
    $json = DB::table('boards')
      ->select(DB::raw('sensors.id as id, ruangan, status, notif, temp, humidity, mq2, board_id, sensors.updated_at, boards.name, lat, lon'))
      ->join('sensors', 'board_id', '=', 'boards.id')
      ->groupBy('id')
      ->get();
    return response()->json($json, 200, [], JSON_NUMERIC_CHECK);
  }

  public function show($id)
  {
    $json = DB::table('boards')
      ->select(DB::raw('sensors.id as id, ruangan, status, notif, temp, humidity, mq2, board_id, sensors.updated_at, boards.name, lat, lon'))
      ->join('sensors', 'board_id', '=', 'boards.id')
      ->groupBy('id')
      ->where('board_id', '=', $id)
      ->get();
    return response()->json($json, 200, [], JSON_NUMERIC_CHECK);
  }

  public function store(Request $request)
  {
    $cek = Board::where('id', '=', $request->board_id)->first();
    if (isset($cek)) {
      Log::create($request->all());
      Sensor::create($request->all());
      return response()->json(["messege" => "Success"], 201);
    } else {
      return response()->json(["messege" => "Board not found"], 404);
    }
  }

  public function update(Request $request)
  {
    $cek = Sensor::where('id', $request->id)->first();
    if (isset($cek)) {
      $cek->update($request->all());
      return response()->json(["messege" => "Success"], 200);
    } else {
      return response()->json(["messege" => "Sensor not found"], 404);
    }
  }

  public function updatehw(Request $request)
  {
    $bcek = Board::where('id', $request->board_id)->first();
    $setting = Setting::get()->last();
    $suhu = $setting->temperature;
    $mq2 = $setting->mq2;
    if (isset($bcek)) {
      $cek = Sensor::where('board_id', $request->board_id)->skip(($request->id) - 1)->first();
      $cruang = isset($cek->ruangan) ? $cek->ruangan : "No Name";
      $ruangan = isset($request->ruangan) ? $request->ruangan : $cruang;
      if (($request->temp > $suhu) && ($request->mq2 > $mq2)) {
        $notif = "Kebakaran Terdeteksi";
      } else if ($request->temp > $suhu) {
        $notif = "Temperatur Tinggi";
      } else if ($request->mq2 > $mq2) {
        $notif = "Asap/Gas Terdeteksi";
      }
      if (($request->temp > $suhu) || ($request->mq2 > $mq2)) {
        fcm()
          ->toTopic('api')
          ->priority('high')
          ->timeToLive(0)
          ->notification([
            'title' => $notif,
            'body' => 'Lokasi ' . $ruangan . ' Di ' . $bcek->name,
            'sound' => 'default',
          ])
          ->send();
      }
      if (isset($cek)) {
        Log::create([
          'ruangan' => $ruangan,
          'mq2' => $request->mq2,
          'temp' => $request->temp,
          'notif' => $request->notif,
          'status' => $request->status,
          'humidity' => $request->humidity,
          'board_id' => $request->board_id,
        ]);
        $cek->update($request->all());
        return response()->json(["messege" => "Success"], 200);
      } else {
        Log::create($request->all());
        Sensor::create($request->all());
        return response()->json(["messege" => "Add Success"], 201);
      }
    } else {
      return response()->json(["messege" => "No Board"], 404);
    }
  }

  public function destroy(Sensor $sensor)
  {
    $sensor->delete();
    return response()->json("Success", 200);
  }
}

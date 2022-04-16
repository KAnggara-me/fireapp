<?php

namespace App\Http\Controllers;

use App\Models\Board;
use App\Models\Sensor;
use Illuminate\Http\Request;
use App\Http\Requests\StoreDeviceRequest;
use App\Http\Requests\UpdateDeviceRequest;
use Illuminate\Support\Facades\DB;

class BoardController extends Controller
{
  public function index()
  {
    $json = DB::table('sensors')
              ->select(DB::raw('boards.id, boards.name, lat, lon, user_id, round(avg(sensors.temp)) as temp, round(avg(sensors.humidity)) as humidity, round(avg(sensors.mq2)) as mq2,boards.updated_at'))
              ->join('boards', 'boards.id', '=', 'sensors.board_id')
              ->groupBy('id')
              ->get();
    return response()->json($json, 200, [], JSON_NUMERIC_CHECK);
  }

  public function show($id)
  {
    $sensor = Sensor::where('board_id', $id)->get();
    return response()->json($sensor, 200, [], JSON_NUMERIC_CHECK);
  }

  public function create(Request $request)
  {
    Board::create($request->all());
    return response()->json("Success", 201);
  }

  public function update(Request $request, Board $board)
  {
    $board->update($request->all());
    return response()->json($board, 200, [], JSON_NUMERIC_CHECK);
  }
}

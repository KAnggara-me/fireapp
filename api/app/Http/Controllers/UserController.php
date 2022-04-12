<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Board;
use App\Models\Setting;

class UserController extends Controller
{
  public function index()
  {
    return abort(403, 'Unauthorized action.');
  }

  public function auth(Request $request)
  {
    $user = User::where('email', '=', $request->email)->first();
    $setting = Setting::first();
    if (isset($user)){
      if(password_verify($request->password, $user->password)) {
        return response()->json([
          "id" => $user->id,
          "name" => $user->name,
          "email" => $user->email,
          "status" => $user->status,
          "mq2_max" => $setting->mq2,
          "password"=> $user->password,
          "help_wa" => $setting->help_wa,
          "humi_max" => $setting->humidity,
          "help_msg" => $setting->help_msg,
          "mq2_op" => $setting->mq2_operator,
          "temp_max" => $setting->temperature,
          "temp_op" => $setting->temp_operator,
          "humi_op" => $setting->humi_operator,
          "messege" => "Success",
        ], 200, [], JSON_NUMERIC_CHECK);
      } else {
        return response()->json([
          "id" => 0,
          "name" => '',
          "email" => '',
          "status" => 0,
          "password"=> '',
          "messege" => "Wrong email or password",
        ], 402, [], JSON_NUMERIC_CHECK);
      }
    } else {
      return response()->json([
        "id" => 0,
        "name" => '',
        "email" => '',
        "status" => 0,
        "password"=> '',
        "messege" => "Wrong email or password",
      ], 402, [], JSON_NUMERIC_CHECK);
    }
  }

  public function register(Request $request)
  {
    $token = env("TOKEN", null);
    $lon = $request->lon;
    $lat = $request->lat;
    $name = $request->name;
    $email = $request->email;
    $password = $request->password;
    $setting = Setting::get()->last();
    if (isset($lon)&&isset($lat)&&isset($name)&&isset($email)&&isset($password))
    {
      if ($request->token == $token){
        $cekuser = User::where('email', '=', $request->email)->first();
        if (!isset($cekuser)){
          User::create([
            'status' => 2,
            'name' => $name,
            'email' => $email,
            'password' => bcrypt($password),
          ]);
          $user = User::all()->last();
          Board::create([
            "name" => $name,
            "lon" => $lon,
            "lat" => $lat,
            "user_id" => $user->id,
          ]);
          return response()->json([
          "id" => $user->id,
          "name" => $user->name,
          "email" => $user->email,
          "status" => $user->status,
          "mq2_max" => $setting->mq2,
          "password"=> $user->password,
          "help_wa" => $setting->help_wa,
          "humi_max" => $setting->humidity,
          "help_msg" => $setting->help_msg,
          "mq2_op" => $setting->mq2_operator,
          "temp_max" => $setting->temperature,
          "temp_op" => $setting->temp_operator,
          "humi_op" => $setting->humi_operator,
          "messege" => "Success",
        ], 200, [], JSON_NUMERIC_CHECK);
        } else {
          return response()->json([
            "messege" => "E-Mail Already Registered",
          ], 202, [], JSON_NUMERIC_CHECK);
        }
      } else {
        return response()->json([
          "messege" => "Unauthorized",
        ], 401, [], JSON_NUMERIC_CHECK);
      }
    } else {
      return response()->json([
        "messege" => "Bad Request",
      ], 400, [], JSON_NUMERIC_CHECK);
    }
  }
}

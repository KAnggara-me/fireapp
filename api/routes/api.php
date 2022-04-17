<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// API for Sensor
Route::get('/sensor', 'SensorController@index');
Route::get('/sensor/{id}', 'SensorController@show');
Route::post('/sensor', 'SensorController@store');
Route::put('/sensor', 'SensorController@update');
Route::get('/push', 'SensorController@update'); //interaksi dengan Hardware  TODO: fix this
Route::delete('/sensor/{sensor}', 'SensorController@destroy');

// API for Board
Route::get('/board', 'BoardController@index');
Route::get('/board/{id}', 'BoardController@show');
Route::post('/board', 'BoardController@create');
Route::put('/board/{board}', 'BoardController@update');

// API Log
Route::get('/log', 'LogController@index');
Route::get('/log/{id}', 'LogController@show');
Route::delete('/log/{id}', 'LogController@destroy');

// User API
Route::get('/auth', 'UserController@index');
Route::post('/auth', 'UserController@auth');

// Register API
Route::post('register', 'UserController@register');

// Setting API
Route::get('/setting', 'SettingController@index');
Route::post('/setting', 'SettingController@update');
Route::get('/sett', 'SettingController@hwsetting'); // for hardware TODO: fix this
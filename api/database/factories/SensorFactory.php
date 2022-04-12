<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class SensorFactory extends Factory
{
  public function definition()
  {
    $status = array(
      'Aktif',
      'Non Aktif',
    );
    $notif = array(
      'Aman',
      'Asap/Gas Terdeteksi',
    );

    return [
      'ruangan' => 'Kamar ' . $this->faker->firstName(),
      'humidity' => rand(20, 80),
      'status' => $status[rand(0,(count($status)-1))],
      'notif' => $notif[rand(0,(count($notif)-1))],
      'temp' => rand(20, 90),
      'board_id' => rand(1,5),
      'mq2' => rand(100,1024),
    ];
  }
}

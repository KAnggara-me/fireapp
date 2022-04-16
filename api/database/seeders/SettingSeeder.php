<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Setting;

class SettingSeeder extends Seeder
{
  public function run()
  {
    Setting::create([
      'temperature' => 40, // Max temperature in degrees
      'humidity' => 40, // Minimum humidity in %
      'mq2' => 350, // Maximum CO2 in ppm
    ]);
  }
}

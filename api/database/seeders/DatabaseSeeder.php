<?php

namespace Database\Seeders;
use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Board;
use App\Models\Sensor;
use App\Models\Log;

class DatabaseSeeder extends Seeder
{
  public function run()
  {
    User::create([
      'name' => "Admin",
      'email' => "a@b.c",
      'password' => bcrypt('llllllll'),
      'status' => 1,
    ]);
    Board::factory(1)->create();
    $this->call([
      SettingSeeder::class,
    ]);
  }
}

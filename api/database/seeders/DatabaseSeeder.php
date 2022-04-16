<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Board;

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
    Board::create([
      'name' => 'Admin',
      'lon' => 102.753897,
      'lat' => 2.988897,
      'user_id' => 1,
    ]);
    $this->call([
      SettingSeeder::class,
    ]);
  }
}

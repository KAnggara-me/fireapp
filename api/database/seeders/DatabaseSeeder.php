<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Board;

class DatabaseSeeder extends Seeder
{
  public function run()
  {
    $this->call([
      UserSeeder::class,
      BoardSeeder::class,
      SettingSeeder::class,
    ]);
  }
}

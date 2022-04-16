<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Board;

class BoardSeeder extends Seeder
{
  public function run()
  {
    Board::create([
      'name' => 'Admin',
      'lon' => 102.753897,
      'lat' => 2.988897,
      'user_id' => 1,
    ]);
  }
}

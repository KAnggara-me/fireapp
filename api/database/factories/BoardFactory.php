<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class BoardFactory extends Factory
{
  public function definition()
  {
    return [
      'name' => 'Admin',
      'lon' => $this->faker->longitude($min = 100, $max = 102),
      'lat' => $this->faker->latitude($min = -1, $max = 2.5),
      'user_id' => 1,
    ];
  }
}

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBoardsTable extends Migration
{
  public function up()
  {
    Schema::create('boards', function (Blueprint $table) {
      $table->id();
      $table->string('name')->default('Fire_Alarm');
      $table->float('lon', 9,6);
      $table->float('lat', 9,6);
      $table->foreignId('user_id')->constrained('users');
      $table->timestamps();
    });
  }

  public function down()
  {
    Schema::dropIfExists('boards');
  }
}

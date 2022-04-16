<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateSettingsTable extends Migration
{
  public function up()
  {
    Schema::create('settings', function (Blueprint $table) {
      $table->id();
      $table->integer('mq2');
      $table->float('humidity');
      $table->float('temperature');
      $table->string('mq2_operator')->default('>');
      $table->string('temp_operator')->default('>');
      $table->string('humi_operator')->default('<');
      $table->string('help_wa')->default('6289636214214');
      $table->string('help_msg')->default('Halo, saya ada kesulitan dengan sensor ini, Mohon bantuanya, Board ID saya adalah : ');
      $table->timestamps();
    });
  }

  public function down()
  {
    Schema::dropIfExists('settings');
  }
}

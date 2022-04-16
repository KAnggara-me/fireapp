<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateLogsTable extends Migration
{
  public function up()
  {
    Schema::create('logs', function (Blueprint $table) {
      $table->id();
      $table->string('ruangan')->nullable()->default("Untitled");
      $table->float('humidity')->nullable()->default(85);
      $table->string('status')->nullable()->default("off");
      $table->string('notif')->nullable()->default("off");
      $table->float('temp')->nullable()->default(28);
      $table->integer('mq2')->nullable()->default(100);
      $table->foreignId('board_id')->constrained('boards')->default(1);
      $table->timestamps();
    });
  }

  public function down()
  {
    Schema::dropIfExists('logs');
  }
}

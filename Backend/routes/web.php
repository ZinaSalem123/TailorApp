<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return ['Laravel2' => app()->version()];
});

require __DIR__.'/auth.php';

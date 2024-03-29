<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Aplicacion_Encuesta extends Model
{
    protected $fillable = [
        'FK_USUARIO',
        'FK_ENCUESTA',
        'FECHA_APLICACION',
        'FECHA_RESPUESTA',
        'ESTADO',
        'FK_USUARIO_REGISTRO',
        'FECHA_REGISTRO',
        'FK_USUARIO_MODIFICACION'
    ];
    public $timestamps = false;

    protected $primaryKey = 'PK_APLICACION_ENCUESTA';

    protected $table = 'TR_APLICACION_ENCUESTA';
}

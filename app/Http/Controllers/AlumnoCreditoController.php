<?php

namespace App\Http\Controllers;

use App\alumnoCredito;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;

class AlumnoCreditoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }


    public function store(Request $request)
    {
        $alumnoCredito = new alumnoCredito();
        $alumnoCredito->FK_ALUMNO = $request->FK_ALUMNO;
        $alumnoCredito->FK_LINEAMIENTO = $request->FK_LINEAMIENTO;
        $alumnoCredito->save();

        echo json_encode($alumnoCredito);

    }

    public function show($pk_usuario)
    {
        $creditos = alumnoCredito::join('LINEAMIENTOS','FK_LINEAMIENTO','=','PK_LINEAMIENTO')
                    ->select('PK_ALUMNO_CREDITO','LINEAMIENTOS.NOMBRE','PERIODO','VALIDADO')
                    ->where('FK_ALUMNO','=',$pk_usuario)
                    ->get();
        $response = Response::json($creditos);
        return $response;
    }

    public function getCreditosPorValidar(){
        $creditos = alumnoCredito::join('LINEAMIENTOS','FK_LINEAMIENTO','=','PK_LINEAMIENTO')
                    ->join('users','FK_ALUMNO','=','PK_USUARIO')
                    ->select('PK_ALUMNO_CREDITO', 'LINEAMIENTOS.NOMBRE', 'users.NUMERO_CONTROL','users.PRIMER_APELLIDO','users.SEGUNDO_APELLIDO','users.name','CALIFICACION')
                    ->where('VALIDADO','=',0)
                    ->take(200)
                    ->get();
        $response = Response::json($creditos);
        return $response;
    }

    public function getCreditosPorValidarByNumC($num_control){
        $creditos = alumnoCredito::join('LINEAMIENTOS','FK_LINEAMIENTO','=','PK_LINEAMIENTO')
                    ->join('users','FK_ALUMNO','=','PK_USUARIO')
                    ->select('PK_ALUMNO_CREDITO', 'LINEAMIENTOS.NOMBRE', 'users.NUMERO_CONTROL','users.PRIMER_APELLIDO','users.SEGUNDO_APELLIDO','users.name','CALIFICACION')
                    ->where('users.NUMERO_CONTROL','=',$num_control)
                    ->where('VALIDADO','=',0)
                    ->get();
        $response = Response::json($creditos);
        return $response;
    }
    public function getCreditosPorValidarByLin($lineamiento){
        $creditos = alumnoCredito::join('LINEAMIENTOS','FK_LINEAMIENTO','=','PK_LINEAMIENTO')
                    ->join('users','FK_ALUMNO','=','PK_USUARIO')
                    ->select('PK_ALUMNO_CREDITO', 'LINEAMIENTOS.NOMBRE', 'users.NUMERO_CONTROL','users.PRIMER_APELLIDO','users.SEGUNDO_APELLIDO','users.name','CALIFICACION')
                    ->where('LINEAMIENTOS.PK_LINEAMIENTO','=',$lineamiento)
                    ->where('VALIDADO','=',0)
                    ->get();
        $response = Response::json($creditos);
        return $response;
    }

    /**........................................................................... */

    public function getCreditosValidados(){
        $creditos = alumnoCredito::join('LINEAMIENTOS','FK_LINEAMIENTO','=','PK_LINEAMIENTO')
                    ->join('users','FK_ALUMNO','=','PK_USUARIO')
                    ->select('PK_ALUMNO_CREDITO', 'LINEAMIENTOS.NOMBRE', 'users.NUMERO_CONTROL','users.PRIMER_APELLIDO','users.SEGUNDO_APELLIDO','users.name','CALIFICACION')
                    ->where('VALIDADO','=',1)
                    ->orderBy('PK_ALUMNO_CREDITO','desc')
                    ->take(200)
                    ->get();
        $response = Response::json($creditos);
        return $response;
    }

    public function getCreditosValidadosByNumC($num_control){
        $creditos = alumnoCredito::join('LINEAMIENTOS','FK_LINEAMIENTO','=','PK_LINEAMIENTO')
                    ->join('users','FK_ALUMNO','=','PK_USUARIO')
                    ->select('PK_ALUMNO_CREDITO', 'LINEAMIENTOS.NOMBRE', 'users.NUMERO_CONTROL','users.PRIMER_APELLIDO','users.SEGUNDO_APELLIDO','users.name','CALIFICACION')
                    ->where('users.NUMERO_CONTROL','=',$num_control)
                    ->where('VALIDADO','=',1)
                    ->get();
        $response = Response::json($creditos);
        return $response;
    }

    public function getCreditosValidadosByLin($lineamiento){
        $creditos = alumnoCredito::join('LINEAMIENTOS','FK_LINEAMIENTO','=','PK_LINEAMIENTO')
                    ->join('users','FK_ALUMNO','=','PK_USUARIO')
                    ->select('PK_ALUMNO_CREDITO', 'LINEAMIENTOS.NOMBRE', 'users.NUMERO_CONTROL','users.PRIMER_APELLIDO','users.SEGUNDO_APELLIDO','users.name','CALIFICACION')
                    ->where('LINEAMIENTOS.PK_LINEAMIENTO','=',$lineamiento)
                    ->where('VALIDADO','=',1)
                    ->get();
        $response = Response::json($creditos);
        return $response;
    }

    /**------------------------------------------------------------------------ */
    public function getCreditosByCarrera($carrera){
        $creditos = alumnoCredito::join('LINEAMIENTOS','FK_LINEAMIENTO','=','PK_LINEAMIENTO')
                    ->join('users','FK_ALUMNO','=','PK_USUARIO')
                    ->select('PK_ALUMNO_CREDITO', 'LINEAMIENTOS.NOMBRE', 'users.NUMERO_CONTROL','users.PRIMER_APELLIDO','users.SEGUNDO_APELLIDO','users.name','CALIFICACION')
                    ->where('users.CLAVE_CARRERA','=',$carrera)
                    ->get();
        $response = Response::json($creditos);
        return $response;
    }
    
    
    public function update($pk_alumnoCredito)//validar credito
    {
        $alumnoCredito = alumnoCredito::find($pk_alumnoCredito);
        $alumnoCredito->VALIDADO = 1;
        $alumnoCredito->save();
    }

    public function validarCreditos($pk_alumnoCredito){
        $alumnoCredito = alumnoCredito::find($pk_alumnoCredito);
        $alumnoCredito->VALIDADO = 1;
        $alumnoCredito->save();
    }

    public function destroy($id)
    {
        $alumnoCredito = alumnoCredito::find($id);
        $alumnoCredito->delete();
    }
}

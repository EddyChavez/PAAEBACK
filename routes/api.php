<?php

use Illuminate\Http\Request;

Route::group([

    'middleware' => 'api',

], function ($router) {

    Route::post('login', 'AuthController@login');
    Route::post('signup', 'AuthController@signup');
    Route::post('logout', 'AuthController@logout');
    Route::post('refresh', 'AuthController@refresh');
    Route::post('me', 'AuthController@me');
    Route::post('sendPasswordResetLink', 'ResetPasswordController@sendEmail');
    //Route::post('sendAspirantePasswordLink','AspirantePasswordController@sendEmail');
    Route::post('resetPassword', 'ChangePasswordController@process');
    Route::post('control', 'NumeroControl@getControl');
   // Route::post('permisos', 'Sistema_permisos@getPermisos');

    Route::group(['middleware' => ['jwt.auth']], function () {
        Route::get('logout', 'AuthController@logout');
        Route::post('Periodo','PeriodoController@store');
        Route::post('PAAE_Periodo','PAAE_Periodo@store');




        //Route::post('control', 'NumeroControl@getControl');

    });
    //Route::post('periodo', 'PAAE_Periodo@getPeriodo');

});

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::resource('Aspirante', 'AspiranteController');
Route::resource('Universidad', 'UniversidadController');
Route::resource('Carrera_Universidad', 'Carrera_UniversidadController');
Route::resource('Carrera', 'CarreraController');
Route::resource('Dependencia', 'DependenciaController');
Route::resource('Estado_Civil', 'Estado_CivilController');
Route::resource('Incapacidad', 'IncapacidadController');
Route::resource('Propaganda_Tecnologico', 'PropagandaController');
Route::resource('CreditosSiia','CreditosSiiaController');
Route::resource('Entidad_Federativa','Entidad_FederativaController');
Route::resource('ColoniaCodigoPostal','ColoniaCodigoPostalController');
Route::resource('Ciudad','CiudadController');
Route::resource('Colonia','ColoniaController');
Route::resource('CodigoPostal','CodigoPostalController');
Route::resource('Usuario_Rol','Usuario_RolController');
Route::get('PAAE_Periodo','PAAE_Periodo@index');
Route::get('Hora','PAAE_Periodo@horario');
Route::get('HoraAll','PAAE_Periodo@horarioAll');
Route::get('Materia','PAAE_Periodo@materia');
Route::get('Datos','PAAE_Periodo@getDatos');
Route::get('Promedio','PAAE_Periodo@promedio');
Route::get('MateriAsesor','PAAE_Periodo@materiAsesor');
Route::get('Asesor','PAAE_Periodo@getAsesor');
Route::get('AsesorAsigna','PAAE_Periodo@getAsesorAsigna');
Route::get('AsesorPeriodo','PAAE_Periodo@getAsesorPeriodo');
Route::get('Solicitudes','PAAE_Periodo@getSolicitud');
Route::get('SolicitudesAsigna','PAAE_Periodo@getSolicitudAsigna');
Route::get('SolicitudesPeriodo','PAAE_Periodo@getSolicitudPeriodo');
Route::get('Seguimiento','PAAE_Periodo@seguimiento');
Route::get('AllMaterias','PAAE_Periodo@allMaterias');
Route::get('ClaveGrupo','PAAE_Periodo@claveGrupo');
Route::get('ClaveHorario','PAAE_Periodo@claveHorario');
Route::get('Asesoria','PAAE_Periodo@getAsesoria');
Route::get('AsesoriaPeriodo','PAAE_Periodo@getAsesoriaPeriodo');
Route::get('AsesoriaGrupo','PAAE_Periodo@getAsesoriaGrupo');
Route::get('AsesoriaGrupoPeriodo','PAAE_Periodo@getAsesoriaGrupoPeriodo');
Route::get('AsesoriaId','PAAE_Periodo@getAsesoriaId');
Route::get('Docentes','PAAE_Periodo@allDocente');
Route::get('NameAses','PAAE_Periodo@nombreAsesor');
Route::post('SolicitudAsesoria','PAAE_Periodo@crearSolicitud');
Route::post('SolicitudAsesor','PAAE_Periodo@crearSolicitudAsesor');
Route::post('ActualizAsesor','PAAE_Periodo@actualizAsesor');
Route::post('ActualizaSolicitud','PAAE_Periodo@actualizaSolicitud');
Route::post('BorrAsesor','PAAE_Periodo@borrAsesor');
Route::post('BorraSolicitud','PAAE_Periodo@borraSolicitud');
Route::post('AsignaIndividual','PAAE_Periodo@asignacionIndividual');
Route::post('AsignaGrupal','PAAE_Periodo@asignacionGrupal');
Route::post('ActualizaInd','PAAE_Periodo@actualizAsigInd');
Route::post('BorraInd','PAAE_Periodo@borrInd');
Route::post('ActualizaGrupo','PAAE_Periodo@actualizGrupo');
Route::post('BorraGru','PAAE_Periodo@borrGru');
Route::post('Motivo','PAAE_Periodo@motivo');
Route::post('CompromisoUser','PAAE_Periodo@compromisoUser');
Route::post('EvaluacionSatisfaccion','PAAE_Periodo@evaluacionSatisfaccion');
Route::post('CompromisoAsesor','PAAE_Periodo@compromisoAsesor');
Route::resource('Encuestas', 'EncuestaController');
Route::resource('Seccion_Encuesta', 'Seccion_EncuestaController');
Route::resource('Tipo_Pregunta', 'Tipo_PreguntaController');
Route::resource('PAAE_Periodo','PAAE_Periodo');
Route::resource('Anteproyecto', 'AnteproyectoResidenciasController');
Route::resource('Documentacion', 'DocumentacionResidenciasController');
Route::resource('Reporte','ReporteResidenciaController');
Route::resource('proyecto','ProyectoController');
Route::resource('Docente','DocenteController');
Route::resource('Comentario','ComentariosController');
Route::resource('Repdocente','ReporteDocenteController');
Route::resource('Alumnor','AlumnoController');
Route::resource('PeriodoR','PeriodoResidenciaController');
Route::resource('Convenio','ConveniosController');
Route::resource('Informe','InformeTecnicoController');
Route::resource('CalificacionR','CalificacionAlumnoController');
Route::resource('ExternoR','ExternoController');
Route::resource('Repexterno','ReporteExternoController');
Route::resource('Estadisticas','EstadisticasController');
Route::post('documentacion', 'DocumentacionResidenciasController@updatesolicitud');
Route::post('documentacion2', 'DocumentacionResidenciasController@updateaceptacion');
Route::post('anteproyecto2', 'AnteproyectoResidenciasController@proyecto');
Route::post('Totalr','EstadisticasController@reportestotal');
route::get('Periodo','PeriodoController@index');
route::get('Proyecto/{id}','AnteproyectoResidenciasController@alumno');
Route::get('Pdf/{id}','FichaUnicaController@FUApdf');
Route::get('Proyecto1/{id}','AnteproyectoResidenciasController@ind1');
Route::get('Proyecto2/{id}','AnteproyectoResidenciasController@ind2');
Route::get('Totalp','EstadisticasController@totalproyectos');
Route::resource('CreditosSiia', 'CreditosSiiaController');
Route::resource('Entidad_Federativa', 'Entidad_FederativaController');
Route::resource('Ciudad', 'CiudadController');
Route::resource('Usuario_Rol', 'Usuario_RolController');
Route::resource('PAAE_Periodo', 'PAAE_Periodo');
route::resource('Bachillerato', 'BachilleratoController');
route::resource('Colonia', 'ColoniaController');
route::get('Periodo', 'PeriodoController@index');





/* Route::get('Ficha/{preficha}',function(){
    $pdf = PDF::loadView('ficha');
        return $pdf->download('archivo.pdf');
}); */


//Route::resource('Periodo','PeriodoController');
Route::resource('Campus','CampusController');
Route::resource('TipoEspacio','TipoEspacioController');
Route::resource('Espacio','EspacioController');
Route::resource('TipoInstituto','TipoInstitutoController');
Route::resource('Edificio','EdificioController');
Route::resource('Tecnologico','TecnmController');

route::get     ('Periodo','PeriodoController@index');
//Route::resource('Periodo','PeriodoController');
//route::get     ('pdf/{orientation}','PdfController@pdf');
route::get     ('pdf','PdfController@pdf');


Route::resource('Pregunta', 'PreguntaController');

Route::resource('Pregunta', 'PreguntaController');

Route::get('pdf1',function(){
    $pdf = PDF::loadView('vista');
    return $pdf->download('archivo.pdf');
});


Route::resource('lineamientos','LineamientoController');
Route::resource('tipos','TipoController');
Route::resource('actividades','ActividadController');
Route::resource('alumno-actividades','AlumnoActividadController');
Route::resource('asistencia-alumnos','AsistenciaAlumnoActividadController');
Route::resource('alumno-creditos','AlumnoCreditoController');
Route::get('actividades-disponibles/{id_alumno}', 'ActividadController@actividadesDisponibles');
Route::get('lista-actividades/{FK_LINEAMIENTO}/{FK_ALUMNO}', 'AsistenciaAlumnoActividadController@actividadesList');
Route::resource('responsables-actividad','ResponsableActividadController');
Route::get('responsable-lista-asistentes/{pk_actividad}','ResponsableActividadController@getListaAsistentes');
Route::resource('asistentes-actividad','AsistenteActividadController');
Route::get('alumnos-num-control/{NUM_CONTROL}','AsistenteActividadController@getAlumnoByNc');
Route::get('alumnos-num-control/{PRIMER_APELLIDO}/{SEGUNDO_APELLIDO}/{name}','AsistenteActividadController@getPkuserByName');
Route::get('registrar-asistencia','AsistenteActividadController@habilitarTomaAsistencia');






Route::resource('Salon', 'SalonController');
Route::resource('Turno', 'TurnoController');
route::get('Referencia/{preficha}', 'AspiranteController@referencia');
route::get('Aspirantes/{PK_PERIODO}', 'AspiranteController@aspirantes');
route::get('Aspirantes2', 'AspiranteController@aspirantes2');
route::get('Aspirantes3/{PK_PERIODO}', 'AspiranteController@aspirantes3');
route::get('EstatusAspirante/', 'AspiranteController@estatusAspirante');
route::get('GraficaEstatus/{PK_PERIODO}', 'AspiranteController@graficaEstatus');
route::get('GraficaCarreras/{PK_PERIODO}', 'AspiranteController@graficaCarreras');
route::get('GraficaCampus/{PK_PERIODO}', 'AspiranteController@graficaCampus');
route::post('CargarArchivoBanco/{PK_PERIODO}', 'AspiranteController@cargarArchivoBanco');
route::post('CargarArchivoPreRegistroCENEVAL/{PK_PERIODO}', 'AspiranteController@cargarArchivoPreRegistroCENEVAL');
route::post('CargarArchivoRegistroCENEVAL/{PK_PERIODO}', 'AspiranteController@cargarArchivoRegistroCENEVAL');
route::post('Aspirante2', 'AspiranteController@modificarAspirante');
route::get('Ficha/{preficha}', 'FichaController@descargarFicha');
Route::get('Grupo', 'GrupoController@listaGrupos');
class Deposito{
	
	var property formaciones = []
	var property locomotoras = []
	const limiteUnidades = 20
	const limiteDePeso = 10000
	
	method agregarFormacion(formacion) = formaciones.add(formacion)
	
	method agregarLocomotoraSuelta(locomotora) = locomotoras.add(locomotora)
	
	method vagonesPesadosXformacion(){
		return formaciones.map{formacion => formacion.vagonPesadoXformacion()}
	}
	method formacionComplejaExtendida(){
		return formaciones.any{formacion => formacion.unidadesXformacion()} >= limiteUnidades
	}
	method formacionComplejaPesada(){
		return formaciones.any{formacion => formacion.pesoTotalFormacion()} >= limiteDePeso
	}
	method necesitaConductorExperimentado(){
		 return (self.formacionComplejaExtendida() or self.formacionComplejaPesada())
		 
	}
	
	
}

class Formacion{
	
	var property vagonesUtilizados = []
	var property locomotoras = []
	
	method agregarVagon(vagon) = vagonesUtilizados.add(vagon)
	
	method agregarLocomotora(locomotora) = locomotoras.add(locomotora)
	
	method vagonesLivianos(){
		return vagonesUtilizados.count{vagon =>vagon.peso() <= 2500}
	}
	method velocidadMaximaDeFormacion(){
		return locomotoras.min{locomotora=> locomotora.velocMaxima()}.velocMaxima()
	}
	method esEficiente(){
		return  locomotoras.all{locomotora=> locomotora.pesoMaximoArrastre() >= locomotora.peso()*5}
	}
	method formacionPuedeMoverse(){
		return locomotoras.sum{locomotora => locomotora.arrastreUtil()} >= vagonesUtilizados.sum{vagones => vagones.peso()}
	}
	method cuantoEmpujeFalta(){
		if (self.formacionPuedeMoverse())
		return 0
		else
		return (vagonesUtilizados.sum{vagones => vagones.peso()}- locomotoras.sum{locomotora =>locomotora.arrastreUtil()})
	}
	method vagonPesadoXformacion(){
		return vagonesUtilizados.max{vagones => vagones.peso()}
	}
	method unidadesXformacion(){
		return vagonesUtilizados.size() + locomotoras.size()
	}
	method pesoTotalFormacion(){
		return vagonesUtilizados.sum{vagones => vagones.peso()} + locomotoras.sum{locomotora => locomotora.peso()}
	}
	
	}

class Locomotora{
	var property peso = null
	var property pesoMaximoArrastre = null
	var property velocMaxima = null
		
	method arrastreUtil() = pesoMaximoArrastre - peso
	
	}
	
class VagonDePasajeros{
	var property largoVagon = null
	var property anchoVagon =null
	const pesoDePasajero = 80
	
	method capacidad(){
		if (anchoVagon <= 2.5)
	    return  largoVagon*8
	    else
		return largoVagon*10
		
	}
	method peso() = self.capacidad()*pesoDePasajero
	
}
class VagonDeCarga{

	var property cargaMaxima = null
	const pesoDeGuardas = 160
	
	method peso() = cargaMaxima + pesoDeGuardas
	
	method capacidadPasajeros() = 0
	
}
class Deposito{
	
	var property formaciones = []
	var property locomotoras = []
	
	method agregarFormaciones(formacion) = formaciones.add(formacion)
	
	method agregarLocomotoras(locomotora) = locomotoras.add(locomotora)
	
	method vagonesPesadosXformacion(){
		return formaciones.map{formacion => formacion.vagonPesadoXformacion()}
	}
	
	
}

class Formacion{
	
	var property vagonesUtilizados = []
	var property locomotoras = []
	
	method agregarVagon(vagon) = vagonesUtilizados.add(vagon)
	
	method agregarLocomotoras(locomotora) = locomotoras.add(locomotora)
	
	method vagonesLivianos(){
		return vagonesUtilizados.count{vagon =>vagon.pesoMaximo() <= 2500}
	}
	method velocidadMaximaDeFormacion(){
		return locomotoras.min{locomotora=> locomotora.velocMaxima()}.velocMaxima()
	}
	method esEficiente(){
		return  locomotoras.all{locomotora=> locomotora.pesoMaximoArrastre() >= locomotora.pesoLocomotora()*5}
	}
	method formacionPuedeMoverse(){
		return locomotoras.sum{locomotora => locomotora.arrastreUtil()} >= vagonesUtilizados.sum{vagones => vagones.pesoMaximo()}
	}
	method cuantoEmpujeFalta(){
		if (self.formacionPuedeMoverse())
		return 0
		else
		return (vagonesUtilizados.sum{vagones => vagones.pesoMaximo()}- locomotoras.sum{locomotora =>locomotora.arrastreUtil()})
	}
	method vagonPesadoXformacion(){
		return vagonesUtilizados.max{vagones => vagones.pesoMaximo()}
	}
	
	}

class Locomotora{
	var property pesoLocomotora = null
	var property pesoMaximoArrastre = null
	var property velocMaxima = null
		
	method arrastreUtil() = pesoMaximoArrastre - pesoLocomotora
	
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
	method pesoMaximo() = self.capacidad()*pesoDePasajero
	
}
class VagonDeCarga{

	var property cargaMaxima = null
	const pesoDeGuardas = 160
	
	method pesoMaximo() = cargaMaxima + pesoDeGuardas
	
	method capacidadPasajeros() = 0
	
}
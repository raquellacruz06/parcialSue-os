class Persona {
	var sueniosPendientes = []
	var edad
	var sueniosCumplidos = []
	var dineroQueDesea
	var lugaresADondeViajar = []
	var carrerasAEstudiar = []
	var property cantidadHijos 
	var carrerasEstudiadas = []
	var felicidad
	var personalidad
	
	method cumplirSuenio(suenio){
		suenio.cumplirse(self)
	}
	method cumplirSuenios(){
	sueniosPendientes.forEach{suenio => suenio.cumplirse(self)}
	}
	method agregarSuenio(suenio){
		sueniosCumplidos.add(suenio)
	}
	
	method suenioPiolaaaaaaaaWachoo(suenio) = suenio.nivelFelicidad() >= 100
	
	method cantSuenioPiolasPAPA(lista) = (lista.filter({unSuenio => self.suenioPiolaaaaaaaaWachoo(unSuenio)})).size()
	
	method cantidadDeSueniosPiolasEnTotal() = self.cantSuenioPiolasPAPA(sueniosPendientes) +  self.cantSuenioPiolasPAPA(sueniosCumplidos)
	
	method esAmbisioso() =  self.cantidadDeSueniosPiolasEnTotal() > 3
	
	method felicidadDeLosSueniosPendientes() = (sueniosPendientes.forEach({unSuenio=>unSuenio.nivelFelicidad()})).sum()
	
	method esFeliz() = felicidad > self.felicidadDeLosSueniosPendientes()
	
	method cambiarPersonalidad() {
		personalidad = personalidad.aLaQuePuedeCambiar()
	} 
	method primerSuenio() = sueniosPendientes.first()
	method suenioAlAzar() = sueniosPendientes.anyOne()
	method metaMasImportante() = sueniosPendientes.max({unSuenio=>unSuenio.nivelFelicidad()})
	method cumplirSuenioMasImportante(){
		self.cumplirSuenio(personalidad.criterioSuenio(self))	
	}
	method aumentarFelicidad(nivelFelicidad){
		felicidad += nivelFelicidad
	}
	method quieroViajar(lugar){
		lugaresADondeViajar.contais(lugar)
	}
	method fijarseSiSueldoEstaBien(sueldo) = dineroQueDesea <= sueldo

	method tieneHijos() = cantidadHijos > 0
	method tenerUnHijo(cantidad){
		cantidadHijos += cantidad
	}
	method yaMeRecibi(carrera) = carrerasEstudiadas.contains(carrera)
	method meQuieroRecibir(carrera) = carrerasAEstudiar.contains(carrera)
	method recibirseDeUnaCarrera(carrera){
		carrerasEstudiadas.add(carrera)
	}
	
}
class Suenio{
	var property nivelFelicidad
	method cumplirse(persona){
		persona.agregarSuenio(self)
		persona.aumentarFelicidad(nivelFelicidad)
	}
}
class Recibirse inherits Suenio{
	var nombreCarrera
	
	override method cumplirse(persona){
		!self.hayProblemaParaGraduarse(persona)	//ESTE ERROR ROMPE ACA O EN HAY PROBLEMA PARA GRADUARSE?
		self.cumplirDefinitivamente(persona)
		super(persona)
	}
	
	method cumplirDefinitivamente(persona){
		persona.recibirseDeUnaCarrera(nombreCarrera)
		}
		
	method hayProblemaParaGraduarse(persona){
		if( !persona.meQuieroRecibir(nombreCarrera) ){
			self.error("No puede recibirse de esta carrera, ya que no quiere estudiar esta carrera")
		} 
		if(persona.yaMeRecibi(nombreCarrera)){
			
			self.error("No puede recibirse nuevamente")
			
		} return false
	}
		
}
class ConseguirLaburo inherits Suenio{
	var sueldo
	override method cumplirse(persona){
		if(!persona.fijarseSiSueldoEstaBien(sueldo)){
			self.error("el sueldo es muy bajo")
		} 
		super(persona)
	}
}

class TenerHijos inherits Suenio{
	override method cumplirse(persona){
		persona.tenerUnHijo(1)
		super(persona)
	}
}
class AdoptarHijo inherits Suenio{
	var cantidad
	override method cumplirse(persona){
		if(persona.tieneHijos()){
			self.error("No puede adoptar ya que tiene hijos")
		}
		persona.tenerUnHijo(cantidad) 
		super(persona)
	}
}
class Viajar inherits Suenio{
	var lugar
	override method cumplirse(persona){
		persona.quieroViajar(lugar)
		super(persona)
	}
}
class SuenioMultiple inherits Suenio{
	var suenios = []
	
	override method cumplirse(persona){
		suenios.forEach({suenio=>suenio.cumplirse(persona)}) 	//FALTA 
	//super(persona) cargamos cada sueño por separado o el sueño multiple
	} 
	
}
object realista{						
	method criterioSuenio(persona) = persona.metaMasImportante()
	method aLaQuePuedeCambiar() = obsesivo
	
}
object alocado{
	method criterioSuenio(persona) = persona.suenioAlAzar()
	method aLaQuePuedeCambiar() = realista
}
object obsesivo{
	method criterioSuenio(persona) = persona.primerSuenio()
	method aLaQuePuedeCambiar() = {}
}
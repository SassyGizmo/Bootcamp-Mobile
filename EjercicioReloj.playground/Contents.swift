import Foundation

class Reloj {
    var horas : Int
    var minutos : Int
    var segundos : Int
    
    init() {
        self.horas = 0
        self.minutos = 0
        self.segundos = 0
    }
    
    // Declaracion del metodo setReloj()
    func setReloj(segundosDesdeMedianoche: Int) {
        let segundosTotalesDia = 86400
        let segundosTotales = segundosDesdeMedianoche % segundosTotalesDia // Calculo para no sobrepasar la cantidad de segundos en un dia
        
        self.horas = (segundosTotales / 3600) % 24 // Calculo para no sobrepasar la cantidad de horas
        self.minutos = (segundosTotales % 3600) / 60 // Calculo para no sobrepasar la cantidad de minutos
        self.segundos = segundosTotales % 60 // Calculo para no sobrepasar la cantidad de segundos
    }
    
    // Metodos get
    
    func getHoras() -> Int {
        return self.horas
    }
    
    func getMinutos() -> Int {
        return self.minutos
    }
    
    func getSegundos() -> Int {
        return self.segundos
    }
    
    // Metodos set
    func setHoras(horas: Int) {
        self.horas = horas
    }
    
    func setMinutos(minutos: Int) {
        self.minutos = minutos
    }
    
    func setSegundos(segundos: Int) {
        self.segundos = segundos
    }
    
    func tick() {
        self.segundos += 1 // Incremento de segundos en 1
        if self.segundos == 60 { // Si segundos llega a 60 resetear a 0 y modificar los minutos
            self.segundos = 0
            self.minutos += 1
            if self.minutos == 60 {
                self.minutos = 0
                self.horas += 1
                if self.horas == 24 {
                    self.horas = 0
                }
            }
        }
    }
    
    func addReloj(otroReloj: Reloj) {
        // Suma de todos los segundos del reloj actual
        let segundosTotalesActuales = self.horas * 3600 + self.minutos * 60 + self.segundos
        // Suma de todos los segundos del otro reloj
        let segundosOtroReloj = otroReloj.horas * 3600 + otroReloj.minutos * 60 + otroReloj.segundos
        
        // Total de segundos entre ambos relojes
        let segundosTotalesSuma = segundosTotalesActuales + segundosOtroReloj
        
        // Formateo de segundos a Horas/Minutos/Segundos
        setReloj(segundosDesdeMedianoche: segundosTotalesSuma)
    }
    
    func toString() -> String {
        // Formateo de hora en [hh:mm:ss]
        return String(format: "[%02d:%02d:%02d]", self.horas, self.minutos, self.segundos)
    }
    
    func tickDecrement() {
        self.segundos -= 1
        if self.segundos < 0 {
            self.segundos = 59
            self.minutos -= 1
            if self.minutos < 0 {
                self.minutos = 59
                self.horas -= 1
                if self.horas < 0 {
                    self.horas = 23
                }
            }
        }
    }
}

let reloj1 = Reloj()
let reloj2 = Reloj()

reloj1.setReloj(segundosDesdeMedianoche: 4200)
reloj2.setReloj(segundosDesdeMedianoche: 2100)

print("La hora del primer reloj es: \(reloj1.toString())")
print("La hora dek segundo reloj es: \(reloj2.toString())")

reloj1.addReloj(otroReloj: reloj2)
print("La hora de ambos relojes sumados es: \(reloj1.toString())")

reloj1.tick()
print("La hora del reloj despues del incremento de tick: \(reloj1.toString())")

reloj1.tickDecrement()
print("La hora del reloj luego del decremento de tick: \(reloj1.toString())")




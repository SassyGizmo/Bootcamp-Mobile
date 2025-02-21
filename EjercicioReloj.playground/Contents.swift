import Foundation

class Reloj {
    var horas : Int
    var minutos : Int
    var segundos : Int
    
    init(horas: Int, minutos: Int, segundos: Int) {
        self.horas = horas
        self.minutos = minutos
        self.segundos = segundos
    }
    
    func setReloj(segundosDesdeMedianoche: Int) {
        let segundosTotalesDia = 86400
        let segundosTotales = segundosDesdeMedianoche % segundosTotalesDia
        
        self.horas = (segundosTotales / 3600) % 24
        self.minutos = (segundosTotales % 3600) / 60
        self.segundos = segundosTotales % 60
    }
    
    func getHoras() -> Int {
        return self.horas
    }
    
    func getMinutos() -> Int {
        return self.minutos
    }
    
    func getSegundos() -> Int {
        return self.segundos
    }
    
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
        self.segundos += 1
        if self.segundos == 60 {
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
        let segundosTotalesActuales = self.horas * 3600 + self.minutos * 60 + self.segundos
        let segundosOtroReloj = otroReloj.horas * 3600 + otroReloj.minutos * 60 + otroReloj.segundos
        
        let segundosTotalesSuma = segundosTotalesActuales + segundosOtroReloj
        
        setReloj(segundosDesdeMedianoche: segundosTotalesSuma)
    }
    
    func toString() -> String {
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

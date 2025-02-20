import Foundation

// Funcion para leer el numero de la maquina
func numeroRandomSecreto() -> String {
    
    // Declaracion de variables locales
    var numeroSecreto = ""
    var primerDigito = false
    var digitos = ""
    
    // Bucle para generar 4 numeros aleatorios y evitar que el primero sea cero
    while numeroSecreto.count < 4 {
        digitos = String(Int.random(in: 0...9))
        if !primerDigito {
            numeroSecreto += String(Int.random(in: 1...9))
            primerDigito = true
        } else if !numeroSecreto.contains(digitos) {
            
            numeroSecreto += digitos
        }
    }
    return numeroSecreto
}


// Funcion para ejecutar el juego
func juegoVacasToros(inputUsuario: String) -> String {
    // Inicializacion de variables y llamada a la funcion de numeroRandomSecreto
    var vacas = 0
    var toros = 0
    var numeroSecreto : String = numeroRandomSecreto()
    
    print("El numero secreto es: \(numeroSecreto)")
    print("El input del usuario es: \(inputUsuario)")
    
    // Bucle para comparar un caracter del input del usuario con todos los caracteres del numero random
    for i in 0...3 {
        
        // Extraccion de caracter del input del usuario
        var indexInputUsuario = inputUsuario.index(inputUsuario.startIndex, offsetBy: i)
        var charInputUsuario = inputUsuario[indexInputUsuario]
        
        // Bandera para verificar la posibilidad de obtener un toro
        var flag = false
        
        // Bucle para recorrer los caracteres del numero random
        for j in 0...3 {
            
            // Variables para recorrer todos los caracteres del numero secreto
            var indexNumeroSecreto = numeroSecreto.index(numeroSecreto.startIndex, offsetBy: j)
            var charNumeroSecreto = numeroSecreto[indexNumeroSecreto]
            
            // Variables para comprar el caracter de la misma posicion que el caracter del input del usuario
            var indexToroNumeroSecreto = numeroSecreto.index(numeroSecreto.startIndex, offsetBy: i)
            var charToroNumeroSecreto = numeroSecreto[indexToroNumeroSecreto]
            
            
            // Condicionalidad de Vacas y Toros
            if charInputUsuario == charToroNumeroSecreto && flag == false {
                toros += 1
                flag = true
            } else if charInputUsuario == charNumeroSecreto {
                vacas += 1
            }
        }
        
        
    
    
    }
    
    var resultado = "Vacas \(vacas - toros) | Toros \(toros)"
    return resultado
}

print(juegoVacasToros(inputUsuario: "1234"))

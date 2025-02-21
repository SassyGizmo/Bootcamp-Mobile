import Foundation

func generarPilas() -> Array<Int> {
    var arrayPilas : Array<Int> = []
    
    for _ in 0...2 {
        arrayPilas.append(Int.random(in: 0...10))
    }
    
    return arrayPilas
}

func imprimirPilas(arrayPilas: Array<Int>) {
    print("A: \(arrayPilas[0]) B: \(arrayPilas[1]) C: \(arrayPilas[2])")
}


func juegoNim() {
    print("Ingresar nombre de los jugadores")
    
    let jugadorUno = readLine()!
    let jugadorDos = readLine()!
    var turno = "jugadorUno"
    var eleccionPila = ""
    var cantidadExtraccionPila : Int
    
    var pilas = generarPilas()
    imprimirPilas(arrayPilas: pilas)
    
    while pilas[0] + pilas[1] + pilas[2] != 0 {
        
        if turno == "jugadorUno" {
            print("\(jugadorUno) elija una pila")
            eleccionPila = readLine()!
            
            while eleccionPila != "A" && eleccionPila != "B" && eleccionPila != "C" {
                print("Por favor introduzca una opcion valida")
                eleccionPila = readLine()!.uppercased()
            }
            
            if eleccionPila == "A" {
                print("Cuanto desea sacar?")
                cantidadExtraccionPila = Int(readLine()!)!
                
                if (pilas[0] - cantidadExtraccionPila) >= 0 {
                    pilas[0] -= cantidadExtraccionPila
                    imprimirPilas(arrayPilas: pilas)
                } else {
                    print("Perdiste tu tuno por querer sacar mas")
                }
                
            } else if eleccionPila == "B" {
                print("Cuanto desea sacar?")
                cantidadExtraccionPila = Int(readLine()!)!
                
                if (pilas[1] - cantidadExtraccionPila) >= 0 {
                    pilas[1] -= cantidadExtraccionPila
                    imprimirPilas(arrayPilas: pilas)
                } else {
                    print("Perdiste tu tuno por querer sacar mas")
                }
                
            } else {
                print("Cuanto desea sacar?")
                cantidadExtraccionPila = Int(readLine()!)!
                
                if (pilas[2] - cantidadExtraccionPila) >= 0 {
                    pilas[2] -= cantidadExtraccionPila
                    imprimirPilas(arrayPilas: pilas)
                } else {
                    print("Perdiste tu tuno por querer sacar mas")
                }
                
            }
            turno = "jugadorDos"
            
        } else if turno == "jugadorDos" {
            print("\(jugadorDos) elija una pila")
            eleccionPila = readLine()!
            
            while eleccionPila != "A" && eleccionPila != "B" && eleccionPila != "C" {
                print("Por favor introduzca una opcion valida")
                eleccionPila = readLine()!.uppercased()
            }
            
            if eleccionPila == "A" {
                print("Cuanto desea sacar?")
                cantidadExtraccionPila = Int(readLine()!)!
                
                if (pilas[0] - cantidadExtraccionPila) >= 0 {
                    pilas[0] -= cantidadExtraccionPila
                    imprimirPilas(arrayPilas: pilas)
                } else {
                    print("Perdiste tu tuno por querer sacar mas")
                }
                
            } else if eleccionPila == "B" {
                print("Cuanto desea sacar?")
                cantidadExtraccionPila = Int(readLine()!)!
                
                if (pilas[1] - cantidadExtraccionPila) >= 0 {
                    pilas[1] -= cantidadExtraccionPila
                    imprimirPilas(arrayPilas: pilas)
                } else {
                    print("Perdiste tu tuno por querer sacar mas")
                }
                
            } else {
                print("Cuanto desea sacar?")
                cantidadExtraccionPila = Int(readLine()!)!
                
                if (pilas[2] - cantidadExtraccionPila) >= 0 {
                    pilas[2] -= cantidadExtraccionPila
                    imprimirPilas(arrayPilas: pilas)
                } else {
                    print("Perdiste tu tuno por querer sacar mas")
                }
                
            }
            turno = "jugadorUno"
        }
    }
    
    if turno == "jugadorUno" {
        print("El ganador es \(jugadorDos)")
    } else {
        print("El ganar es \(jugadorUno)")
    }
    
}
juegoNim()

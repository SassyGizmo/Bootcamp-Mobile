import Foundation

print("---------------- Ejercicio 1 ----------------")

func mayorElementoArray() -> String {
    var mayorElemento = 0
    var arrayEntero : Array<Int> = []
    
    for i in 0...9 {
        arrayEntero.append(Int.random(in: -5...5))
    }

    mayorElemento = arrayEntero[0]
    
    for i in 1...9 {
        if arrayEntero[i] > mayorElemento {
            mayorElemento = arrayEntero[i]
        }
    }
    return "El array es \(arrayEntero) \nEl mayor elemento del array es \(mayorElemento)"
}

print(mayorElementoArray())

print("---------------- Ejercicio 2 ----------------")

func array100() {
    
    var arrayEnteros : Array<Int> = []
    for i in 0...99 {
        arrayEnteros.append(Int.random(in: -33...33))
    }
    
    var contador : [Int: Int] = [:]
    for numero in arrayEnteros {
        contador[numero, default: 0] += 1
    }
    
    let numeroMasRepetido = contador.max { a, b in a.value < b.value }
    
    var enterosPresentes : Set<Int> = []
    for i in 0...99 {
        enterosPresentes.insert(arrayEnteros[i])
    }
    
    var enterosAusentes : Array<Int> = []
    for i in -33...33 {
        if !enterosPresentes.contains(i) {
            enterosAusentes.append(i)
        }
    }
    

    print("El array esta conformado por\n\(arrayEnteros) \nEl numero que mas se repite es \n\(String(describing: numeroMasRepetido?.value)) \nLos enteros ausentes son\n\(enterosAusentes)")}

print(array100())

print("---------------- Ejercicio 3 ----------------")

func palabrasPalindrome() -> String {
    var resultado : String
    var palabra = "WAS IT A CAR OR A CAT I SAW"
    var longitudPalabra = Int(palabra.count)
    var arrayPalabra : Array<Character> = []
    var palindrome : Bool = true
    
    for i in 0..<longitudPalabra {
        var index = palabra.index(palabra.startIndex, offsetBy: i)
        if palabra[index] != " " {
            arrayPalabra.append(palabra[index])
        }
    }
    
    
    
    var arrayPalabraInvertido : Array<Character> = arrayPalabra.reversed()
    
    for i in 0..<arrayPalabra.count {
        
        if arrayPalabra[i] != arrayPalabraInvertido[i] {
            palindrome = false
            break
        }
    }
    
    if palindrome {
        resultado = "Es palindrome"
    } else {
        resultado = "No es palindrome"
    }
    
    return resultado
}
print(palabrasPalindrome())

print("---------------- Ejercicio 4 ----------------")

func cadenaDigitos() -> Array<Int> {
    var digitosCadena = "12182"
    var arrayDigitos : Array<Int> = []
    if digitosCadena.allSatisfy({ $0.isNumber }) {
        arrayDigitos = digitosCadena.compactMap { $0.wholeNumberValue }
        
    } else {
        print("La cadena contiene caracteres no numéricos.")
    
    }
    
    return arrayDigitos
}

print(cadenaDigitos())

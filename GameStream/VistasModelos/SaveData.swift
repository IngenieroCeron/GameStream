//
//  SaveData.swift
//  GameStream
//
//  Created by Eduardo Ceron on 31/01/22.
//

// Esta clase es para la funcion del botón actualizar datos

import Foundation

class SaveData {
    var correo: String = ""
    var contraseña: String = ""
    var nombre: String = ""
    
    func guardarDatos(correo: String, contraseña: String, nombre: String) -> Bool {
        print("Dentro de la funcion guardar datos obtuve: \(correo) + \(contraseña) + \(nombre)")
        
        // Despues de lo anterior vamos a mandar a llamar a una clase que nos va ayudar a guardar dentro de un espacio especial de memoria reservado para guardar datos pequeños que pesen poco por ejemplo un texto, un pequeño numero, un numero con decimales un boolenao, no nos sirve para guardar imagenes o videos por que necesitan mucha info para guardar esos datos:
        // despues del set en esta ocasion le vamos a decir que queremos guardar un arreglo de strings, que va a tener las tres variables:
        UserDefaults.standard.set([correo, contraseña, nombre], forKey: "datosUsuario")
        // La clase userdefaults esta dentro del import por eso la podemos usar.
        // con la palabra set le estamos diciendo guarda un arreglo con esas tres variables.
        // para recuperar esa informacion le tenemos que dar una llave, muy oarecido a los json que tienen llave-valor, por medio de la llave accesamos al valor. Para eso utilizamos la palabra reservada "forkey" y despues le especificamos el nombre de la llave, en este caso es datosUsuario.
        
        // por ultimo regresamo el valor bool que le especificamos arriba, en este caso solo le regresamos un true solo para saber que ya se ejecutaron las lineas de codigo anterior
        
        return true
        
    }
    
    // despues necesitamos una segunda funcion que se va a llamar recuperarDatsos, no recibe ningun parametro y devulve un arreglo de strings por que vamos a recuperar los datos. Si los guardamos en la funcion anterior como una funcion de strins, tenemos que recuperarlos tambien como un arreglo de strings
    
    func recuperarDatos() -> [String] {
        
        // Aqui creamos una constante de tipo arreglo de string y despues del igual le estamos diciendo que del lugar donde tenemos guardados los datos de usuario, recupere un arreglo de strings con la llava (forkey)
        // nos va a marcar un error diciendo que estas seguro que existe una llave datosUsuario por que si no voy a generer error y pues como estamos seguros por que antes nosotros estamos guardando entonces solo le ponemos que lo solucione con un signo de admiración
        let datosUsuario: [String] = UserDefaults.standard.stringArray(forKey: "datosUsuario")!
        
        // despues solo hacemos un print que muestre lo que recuperó de datos
        print("estoy en el metodo recuperar datos y recuperé: \(datosUsuario)")
        
        // despues para el eturn estamos tratando de recuperar un arreglo de strings entonces le ponemos lo siguiente:
        
        return datosUsuario
        
    }
    
    /*
     despues creamos una tercera funcion llamada validar para saber si tenemos datos guardados dentro de nuestro userdefaults.
     Le pasamos como parametros un correo de tipo string y una contraseña de tipo string tambien.
     Vamos a regresar un booleano que nos indiqeu si pudo validar o no
     
     Esta funcion tambien nos puede ayudar para la pantalla de iniciar sesion
     */
    
    func validar(correo: String, contraseña: String) -> Bool {
        // vamos a declarar una variable llamada correoguardado, actualmente no sabemos si tenemos guardado algo, asi qu ele damos un valor vacio
        
        var correoGuardado = ""
        // hacemos lo mismo con la contraseña:
        var contraseñaGuardada = ""
        
        print("revisando si tengo datos guardados en userdefaults con el correo \(correo) y la contraseña \(contraseña)")
        
        // despues vamos a poner un if: si en nuestro userDefault en el guardado standard tenemos un objeto con la llave datosUsuario, en caso de que se pueda recuperar y esté diferente a un objeto vacio a un nill, en otras palabras le estamos diciendo, en caso de que si exista algo guardado con la llave datosUsuario entonces ejecuta el bloque del codigo entre los corchetes, si no existe, ejecuta lo siguiente:
        
        if UserDefaults.standard.object(forKey: "datosUsuario") != nil {
            
            correoGuardado = UserDefaults.standard.stringArray(forKey: "datosUsuario")![0]
            
            contraseñaGuardada = UserDefaults.standard.stringArray(forKey: "datosUsuario")![1]
            
            //Ahora vamos a imprimir lo que se supone tenemos guardado dentro del userdefault
            
            print("El correo guardado es: \(correoGuardado) y la ocntraseña guardada es: \(contraseñaGuardada)")
            
            //Despues vamos a tener otro if un poquitin mas complejo que los anteriores por que vamos a preguntar lo siguiente:
            // en caso de que el correo que escribio el usuario (recuerda que esta funcion recibe correo y contraseña como parametros de entrada, entonces vamos a validar contra el correo guardado y si la contraseña guardada, el usuario puede entrar):
            // con este if ya tenemos la logica para la validación de usuario, ya solo falta implemetarla
            // y con esto nos vamos al EditProfileView a modificar la funcion ctualizarDatos
            if (correo == correoGuardado && contraseña == contraseñaGuardada) {
                return true
            }else {
                return false
            }
            
            
        }else {
            print("no hay datos de usuario guardados en el userDefault")
            return false
        }
    }
    
}

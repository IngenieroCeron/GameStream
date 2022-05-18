//
//  ViewModel.swift
//  GameStream
//
//  Created by Eduardo Ceron on 17/01/22.
//
import Foundation
import UIKit

// vamos a crear una clase por que las clases son diferentes a las estructuras por que las clases apuntan a una direccion de memoria, es por medio de un apuntador de memoria, esto significa que en cualquier parte que estemos en nuestra aplicaión, podremos crear un objeto, instanciar una clase y ese objeto podemos acceder a la intormacion de ese objeto, eso nos sirve a la hora de estar programando por ejemplo si queremos recuperar la informacion del titulo de un viedojuego podremos hacer una referencia a nuestroviewmodel que es el intermediario entre la vista y el modelo.

// esto es para hacer la llamada al servidor:

class ViewModel: ObservableObject {
    
    // en el gamesInfo se van a guardar los datos de todos los juegos:
    @Published var gamesInfo = [Game]()
    // al utilizar el property wrapper Published significa que cualquier vista que quiera agarrar esa info lo puede hacer. Es decir que va a publicar la información y dice cualquiera que la quiera agarrar tiene que implementar que la pueda agarrar

    // despues se crea un metodo init que al momento que se inicialice el ViewModel, al momento de crear el objeto, quiero que vaya al servidor, haga la petición, recupere los datos y lo almacene dentro de nuestra variable "gamesInfo" y como gamesInfo es publica entonces ya cualquier vista lo puede representar y mostrar esa informarmación.
    init() {

        // Despues creamos una costante de url, esta constante va a ser la URL para la petición. la url va a ser un string que lo vamos a tomar de nuestra API, literal ahi dice REQUEST URL, ponemos esa. Tons por medio de esa url nosotros podemos hacer una petición, una petición de tipo GET. Usamos un signo de exclamacion para decirle a XCode; yo como programador tomo la responsabilidad de que esa url efectivamente se puede transformar en un tipo URL.
        let url = URL(string: "https://gamestream-api.herokuapp.com/api/games")!
        
        // Despues creamos una variable "request" de tipo URLRequest, y va a recibir como parametro una url, que seria la url de arriba, o sea la constante.
        var request = URLRequest(url: url)
        
        // Una vez que tenemos la peticion tenemos que darle el tipo de metodo de llamada de tipo GET, asi que accedemos al request le decimos que tipo de metodo http es, y ahi le dices que tipo de request es, o sea de tipo GET. Existen de tipo POST pero ese es para enviar informacion al servidor y que se grabe.
        request.httpMethod = "GET"
        
        // Una vez que ya tenemos ese get de arriba, vamos a iniciar sesion para hacer la petición:
        // Ese urlsession va a ser compartido y ahora un dataTask con un request (que anteriormente declaramos), despues el completionHandler le damos doble clic y nos lo cambia a "{ <#Data?#>, <#URLResponse?#>, <#Error?#> in" es decir que vamos a recibir datos, vamos a recibir una respuesta del servidor y vamos a recibir un posible error. Ahora el codigo que va haber dentro de esto va a ser un bloque llamado "docatch" donde basicamente le estas diciendo: Yo voy hacer una sesion con una peticion que viene por medio del request y en caso de que nosotros hagamos la petición nos va adevolver unos datos, una respuesta y un posible error; los datos es lo que nos interesa ahi van a venir los video juegos, la respuesta tmb nos interesa por si hay una respuesta erronea vamos a saber que es y un error para mostrar en consola el error que tenmos. Y con el do-catch le estamos diciendo intenta recuperar la información y si no puedes entonces muestra que error vas a tener, para ello se pone el print en el catch.
        // Dentro del bloque de "do", tenemos un if let que basicamente dice: "si puedes hacer esto, por favor almacena dentro de la constante jsonData los datos(data)". Una vez que tenemos los datos podemos imprimir la informacion de los datos; por ejemplo tamaño del jsonData. sea que nos devolvio datos erroneos o correctos lo va a imprimir en consola.
        // Despues vamos a decodificar la información que nos llegua de Json con  let decodeData y aqui lo vamos a intentar con try.
        // Ahora ponemos JSONDecoder.decode y aqui vamos a descodificar dependiendo del tipo, de que tipo estamos decodificando? como va a venir nuestra información?; va a venir por medio de un arreglo de [Game]. El .self despues de la estructura le indica que es de tipo [Game] y va a recuperar los datos de jsonData.
        // Despues de hacer eso vamos a abrir el ultimo bloque. El ultimo bloque es un bloque asincrono: DispatchQueu, aqui le estamos diciendo: "vete a otro hilo de tu cpu, no lo hagas en el hilo directo donde esta la interfaz de usuario para que no se trabe la aplicación", por que si no hacemos este codigo donde recuperamos la información, donde se la damos a nuestra variable gamesInfo, en lo que recupera la informacion y hace todo el proceso se va a detener la interfaz de usuario y si por ejemplo tiene un scroll el usuario no va a poder darle el scroll, entonces tenemos que mandar a llamar otro hilo en el cpu por medio del despatchqueu de maner asincrona.
        // Despues con el "self.gamesInfo.append(contentsOf: decodeData)" le estamos diciendo que de manera asincrona le añadas los datos que decodificaste, ahora si los va a poder entender a nuestro gamesInfo.
        // Y CON ESTO SE TERMINA NUESTRA PETICION. Entonces ya tenemos una variable (gamesInfo) que se puede comunicar con nuestra pantalla GamesView(). Y con esto ahora podemos ir a nuestro GamesView() y mostrar cualquier info de los videojuegos.
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            do{
                
                if let jsonData = data {
                    print("tamaño del json \(jsonData)")
                    
                    let decodeData = try
                    JSONDecoder().decode([Game].self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        self.gamesInfo.append(contentsOf: decodeData)
                    }
                    
                }
                
            }catch{
                print("Error: \(error)")
            }
            
            //este resume es importante por que es para decirle al sistema: "ya manda la petición", luego se nos olvida y no recibimos informacion por que ni siquiera mandamos a llamar a que se ejecute la petición.
        }.resume()
    }
    
}

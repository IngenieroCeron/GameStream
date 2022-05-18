//
//  PantallaHome.swift
//  GameStream
//
//  Created by Eduardo Ceron on 13/01/22.
//

import SwiftUI
import AVKit

//MARK: - PANTALLA HOME
struct PantallaHome: View {
    
    
    
    var body: some View {
        ZStack {
            Color("colorFondo").ignoresSafeArea()
            VStack {
                Image("appLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.bottom , 12)
                
                
                ScrollView(showsIndicators: false){
                SubModuloHome()
                }
                
                
            }//: VSTACK
            .padding(.horizontal, 18)
        }//: ZSTACK
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
    }//: BODY
    
//    func busqueda() {
//        print("el usuario está buscando \(textoBusqueda)")
//    }
    
}//: STRUCT

//MARK: - SUBMODULOHOME
struct SubModuloHome: View {
    
    //MARK: - PROPERTY
    
    @ObservedObject var juegoEncontrado = SearchGame()
    @State var isGameViewActive = false
    
    @State var url: String = ""
    @State var titulo: String = ""
    @State var studio: String = ""
    @State var calificacion: String = ""
    @State var anoPublicacion: String = ""
    @State var descripcion: String = ""
    @State var tags: [String] = [""]
    @State var imgsUrl: [String] = [""]
    
    
    @State var textoBusqueda = ""
    @State var isGameInfoEmpty = false
    
    var body: some View {
        VStack {
            
            HStack{
                
                Button(action: {
                    watchGame(name: textoBusqueda)
                    
                    // Aqui vamos a crear una alerta al usuario en caso de que no se encuentre el juego o esta vacio, tenemos que mostrar algo en pantalla que no se hicieron bien las cosas para ello vamos a crear una alerta justo despues de la imagen de la lupita, justo donde termina el label ahi vamos a embeber una alerta
                    
                    
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(textoBusqueda.isEmpty ? Color(.yellow) : Color("dark-cian"))
                })//: BUTTON
                // la alerta siempre va a estar monitoreando ese isGameInfoEmpty, en el momento que sea true, va a mostrar la alerta, cuando veamos que no podamos recuperar la informacion del juego y eso se va a ver en el metodo watchGAme
                    .alert(isPresented: $isGameInfoEmpty) {
                        Alert(title: Text("Error"), message: Text("No se encontró el juego"), dismissButton: .default(Text("Entendido")))
                    }
                
                ZStack(alignment: .leading){
                    if textoBusqueda.isEmpty {
                        Text("Buscar un video")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 174/255, green: 177/255, blue: 185/255, opacity: 1))
                    }
                    TextField("", text: $textoBusqueda)
                        .foregroundColor(.white)
                    
                }//: ZSTACK
                
            }//: HSTACK
            .padding([.top, .leading, .bottom], 11)
            .background(Color("blue-gray"))
            // Para darle redondeo al background se puede usar con cornerRadius o como lo hace en el tutorial con un clipShape
            //.cornerRadius(12)
            .clipShape(Capsule())
            
            Text("los más populares".uppercased())
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            ZStack{
                Button(action: {
                    watchGame(name: "The Witcher 3")
                }, label: {
                    VStack(spacing: 0){
                        Image("thewitcher")
                            .resizable()
                            .scaledToFit()
                        Text("The Witcher 3")
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .background(Color("blue-gray"))
                    }//: VSTACK
                })//: BUTTON
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 42, height: 42)
            }//: ZSTACK
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .padding(.vertical)
            
            Text("categorías sugeridas para ti".uppercased())
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    Button(action: {
                        print("pulse categoria fps")
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("blue-gray"))
                                .frame(width: 160, height: 90)
                            Image("fps")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    })
                    Button(action: {
                        print("pulse categoria rpg")
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("blue-gray"))
                                .frame(width: 160, height: 90)
                            Image("rpg")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    })
                    Button(action: {
                        print("pulse categoria openworld")
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("blue-gray"))
                                .frame(width: 160, height: 90)
                            Image("open-world")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 42, height: 42)
                        }
                    })
                }
            }//: SCROLLVIEW HORIZONTAL
            .padding(.bottom)
            
            Text("recomendado para ti".uppercased())
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack{
                    Button(action: {
                        watchGame(name: "Abzu")
                    }, label: {
                        Image("abzu")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    })
                    Button(action: {
                        watchGame(name: "Crash Bandicoot")
                    }, label: {
                        Image("crashb")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    })
                    Button(action: {
                        watchGame(name: "DEATH STRANDING")
                    }, label: {
                        Image("deathstanding")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    })
                }
            })
            
            Text("VIDEOS QUE PODRÍAN GUSTARTE")
                .font(.title3)
                .foregroundColor(.white)
                .bold()
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.top, 25)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button(action: {
                        watchGame(name: "Cuphead")
                    }, label: {
                        Image("deathstanding").resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    })
                    Button(action: {
                        watchGame(name: "Hades")
                    }, label: {
                        Image("destiny").resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    })
                    Button(action: {
                        watchGame(name: "Grand Theft Auto V")
                    }, label: {
                        Image("spiderman").resizable()
                            .scaledToFit()
                            .frame(width: 240, height: 135)
                    })
                }
            }
            
        }//: VSTACK
        NavigationLink(
            destination: GameView(url: url, titulo: titulo, studio: studio, calificacion: calificacion, anoPublicacion: anoPublicacion, descripcion: descripcion, tags: tags, imgsUrl: imgsUrl),
            isActive: $isGameViewActive,
            label: {
                EmptyView()
            })
        
    }//: BODY
    
    //MARK: - FUNC WATCHGAME
    func watchGame(name: String) {
        
        // Aqui vamos a programar la funcion de busqueda al servidor.
        // Primero vamos acrear un nuevo archivo dentro de la carpeta VistasModelos de tipo Swift file
        // Dentro del nuevo archivo vamos a crear una nueva clase que se va a llamar igual que el archivo
        // Despues la clase va a ser muy parecida a lo que tenemos en el viewmodel entonces vamos a copiar lo que esta dentro del metodo init hasta donde esta el resume. Nos va a dar error por que no tenemos los datos de la url. entonces por lo mientras lo comentamos.
        // Y despues vamos a crear una funcion llamada search en donde vamos a embeber todo lo que copiamos y antes de descomentarlo vamos a crear una property wrapper con la palabra Published, esa variable va a ser un arreglo de juegos y va a ser una instancia de ellos (poniendole parentesis al final)
        // La logica detras de todo eso es recuperar los juegos y tan solo agarra los que provengan del API de busqueda, tenemos un api diferento que tu le puedes dar como argumento un nombre de videojuego y te va a devolver tan solo los videojuegos que sean necesarios para ti. Una ve que tenemos esos viedeojuegos, los capturamos en la varable que cabamos de crear gameInfo y los vamos a añadir a otra vriable que sea nuestra variable simplemnte de juegos que podemos encontrar para ello vamos a crear una variable resultados pero en nuestro modelo. Asi que vamos a ir a nuestro Model y le vamos a agregar otra estructura que se va a llamar Resultados y eso nos va ayudar a guardar simplemente los resultados que envia el api.
        // despues ya podemos descomentar todo lo que habiamos copiado y hacer unos pequeños cambios descritos en la class.
        // Despues tenemos que agregar a esta estructura unas variables: la primer variable va a ser de un juego encontrado, para eso le damos propertywrapper observedObjetc de tipo variable llamado juegoEncontrado y ese va a provenir de SearchGame y la segunda de tipo state que se llame isGameViewActive y esa la tenemos que dejar en true pero por el momento como no hemos encontrado nada lo dejamos en false.
        // Ahora tenemos que pasarle datos a nuestra pantalla de gameview que es el detalle de cada juego y recibe datos. Esto se hace con el codigo siguiente:
        
        juegoEncontrado.search(gameName: name)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
            print("Cantidad E: \(juegoEncontrado.gameInfo.count)")
            
            if juegoEncontrado.gameInfo.count == 0 {
                isGameInfoEmpty = true
            }else{
                url = juegoEncontrado.gameInfo[0].videosUrls.mobile
                titulo = juegoEncontrado.gameInfo[0].title
                studio = juegoEncontrado.gameInfo[0].studio
                calificacion = juegoEncontrado.gameInfo[0].contentRaiting
                anoPublicacion = juegoEncontrado.gameInfo[0].publicationYear
                descripcion = juegoEncontrado.gameInfo[0].description
                tags = juegoEncontrado.gameInfo[0].tags
                imgsUrl = juegoEncontrado.gameInfo[0].galleryImages
                
                isGameViewActive = true
                
            }
            
        }
        
    }
    
}//: STRUCT

struct PantallaHome_Previews: PreviewProvider {
    static var previews: some View {
        PantallaHome()
    }
}

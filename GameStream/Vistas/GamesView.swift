//
//  GamesView.swift
//  GameStream
//
//  Created by Eduardo Ceron on 17/01/22.
//

// UNa vez que ya tenemos en la variable gamesInfo con la información de los videojuegos, queremos mostrar el primer elemento del json y queremos mostrar el primer titulo del videojuego, para hacer esto:
// Creamos otra variable pero ahora tendra otro porperty wrapper que se llama ObservedObject y la llamamos "todosLosVideojuegos". Con quien se va a comunicar la vista? recuerda en MVVM la vista se comunica con el ViewModel. Entonces vamos a decir que sea una instancia de nuestra clase ViewModel y como le escribimos ObservedObject, entonces la variable va a poder acceder a la información de gamesInfo, o sea a todo el archivo json

import SwiftUI
import Kingfisher

struct GamesView: View {
    
    @ObservedObject var todosLosVideojuegos = ViewModel()
    
    // creamos otra varible que pueden captar la informacion de nuestro videojuego seleccionado, (en la variable anterior tiene la informacion de todos los videojuegos) pero cada uno de los juegos tiene su información.
    // esta variable va a ser falta por que nosotros queremos controlar cuando nos vayamos a la vista de game para que cuando seleccionemos un solo videojuego nos mande a uno solo y sea la pantalla del video juego donde se vea el video y toda la informacion. Dicha informacion la vamos a captirar en la variable url, titulo y asi sucesivamente.
    
    @State var gameViewIsActive: Bool = false
    @State var url: String = ""
    @State var titulo: String = ""
    @State var studio: String = ""
    @State var calificacion: String = ""
    @State var anoPublicacion: String = ""
    @State var descripcion: String = ""
    @State var tags: [String] = [""]
    @State var imgsUrl: [String] = [""]
    
    // para mostrar los datos anteriores vamos a utilizar un lazyVGrid por que es para cuando mostramos muchos datos y solo cargue en memoria cuando se muestra al usuario, es decir, es perfecto para datos que no sabes cuantos son, por que imaginate que la vista tiene que cargar 100 imagenes, va a consumir mucha ram. Para esto tenemos que especificarle primero la forma de nuestro grid.
    
    let formaGrid = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack{
            
            Color("colorFondo").ignoresSafeArea()
            
            VStack{
                Text("Juegos".uppercased())
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 64, trailing: 0))
                
                ScrollView{

//                    // el lazyvgrid es parecido al vstack pero aqui podemos tener columnas(rows)
                    LazyVGrid(columns: formaGrid, spacing: 8){

//                        // para el contenido vamos a integrar algo llamado forEach en el cual va a iterar entre cada uno de los elementos de nuestra variable todosLosVideojuegos. despues de la coma necesita un id un identificador para poder iterar entre cada uno de los elementos
                        ForEach(todosLosVideojuegos.gamesInfo, id: \.self){ juego in
                            Button(action: {

                                url = juego.videosUrls.mobile
                                titulo = juego.title
                                studio = juego.studio
                                calificacion = juego.contentRaiting
                                anoPublicacion = juego.publicationYear
                                descripcion = juego.description
                                tags = juego.tags
                                imgsUrl = juego.galleryImages

                                print("Pulse el juego \(titulo)")
                                
                                // esto es para poner en verdadero la variable y el navigationLink se vaya a la pantalla GameView
                                gameViewIsActive = true

                            }, label: {
                                
                                // Para cargar imagenes de internet podemos usar la nueva funcion AsyncImage o en este caso del curso usamos una libreria de terceros que se llama KigsFisher, para agregar la libreria solo hay que if a file>Add Packages> ingresar la url de github de la libreria (se tarda un poco en cargar) y por ultimo clic en añadir package.
                                // Despues de lo anterior importamos en este archivo la libreria y por ultimo ya podemos usar el elemento KfImage
                                
                                KFImage(URL(string: juego.galleryImages[0])!)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .padding(.bottom, 12)
                            })
                        }//: FOREACH

                    }//: LAZYVGRID

                }//: SCROLLVIEW
                
            }//: VSTACK
            
            // aqui le tenemos que pasar las propiedades a la pantalla GameView
            NavigationLink(destination: GameView(url: url, titulo: titulo, studio: studio, calificacion: calificacion, anoPublicacion: anoPublicacion, descripcion: descripcion, tags: tags, imgsUrl: imgsUrl),
                           isActive: $gameViewIsActive,
                           label: {
                EmptyView()
            })
            
        }//: ZSTACK
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
            // el onAppear es para cuando inicie la pantalla ejecute lo que tu quieras. Lo tuve que comentar por que la aplicación crasheaba.
//            .onAppear(perform: {
//                print("primer elemento del json:\(todosLosVideojuegos.gamesInfo[0])")
//                print("titulo del primer videojuego de json\(todosLosVideojuegos.gamesInfo[0].title)")
//            })//: ONAPPEAR
    }//: BODY
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        GamesView()
    }
}

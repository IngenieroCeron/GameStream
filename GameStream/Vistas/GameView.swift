//
//  GameView.swift
//  GameStream
//
//  Created by Eduardo Ceron on 21/01/22.
//

// Esta vista es para programar la vista del detalle de cada juego, para ello le tenemos que pasar todos los datos desde la vista GamesView.
// Primeto tenemos que declarar todas las variables que declaramos en la vista GamesView pero sin el @State y sin darles datos, osea dejar las variables vacias
// Haciendo lo anterior, se va a quejar el preview diciendo que le faltan argumentos. Encones por lo mientras comentamos ese bloque del preview y con eso se oculta el canvas.
// Despues desde el Navigation link de la pantalla de GamesView, en la parte de destination, declaramos esta pantalla y desde ahi pasamos todos los datos
// Una vez que ya le pasamos todos los datos a esta estructura, tenemos que proporcinarle datos de inicio a nuestro canvas.
// Para esto descomentamos el preview y le damos cualquier argmento.
// Primero vamos a crear el modulo de video, para esto creamos una nueva estructura terminando la estructura GameView, despues le vamos a pasar el argumento url a este nuevo modulo, para ello tenemos que declarar la variable url dentro del nuevo modulo
// Despues hacemos un scrollview para la descripcion del videojuego. Al scrollview le damos un frame maxwidth de infinity para que se expanda a toda la pantalla independiente del tamaño de la panatalla

import SwiftUI
import AVKit
import Kingfisher

//MARK: - GAMEVIEW
struct GameView: View {
    
    var url: String
    var titulo: String
    var studio: String
    var calificacion: String
    var anoPublicacion: String
    var descripcion: String
    var tags: [String]
    var imgsUrl: [String]
    
    var body: some View {
        
        ZStack {
            Color("colorFondo").ignoresSafeArea()
            
            VStack {
                
                // Modulo Video
                
                video(url: url)
                    .frame(height: 300)
                
                ScrollView {
                    
                    // Modulo informacion Video
                    
                    videoInfo(titulo: titulo, studio: studio, calificacion: calificacion, anoPublicacion: anoPublicacion, descripcion: descripcion, tags: tags)
                        .padding(.bottom, 40)
                    
                    // Modulo Galeria de imagenes
                    // Aqui empezamos el codigo para mostrar en pantalla un scrill horizontal para mostrar imagenes del servidor.
                    // primero declaramos una nueva estructura llamada Gallery y la creamos debajo de la estrutura videoInfo(), y solo le pasamos la variable imgsUrl.
                    
                    Gallery(imgsUrl: imgsUrl)
                        .padding(.bottom, 40)
                    
                    // Aqui comienza un reto: poner el modulo "Comentarios" y el modulo "Juegos Similares"
                    
                    Comentarios()
                        .padding(.bottom, 40)
                    
                    juegosSimilares()
                    
                }//: SCROLLVIEW
                .frame(maxWidth: .infinity)
                
            }//: VSTACK
            
        }//: ZSTACK
        
    }//: BODY
    
}//: STRUCT

//MARK: - VIDEO
struct video: View {
    
    var url: String
    
    var body: some View {
        
        VideoPlayer(player: AVPlayer(url: URL(string: url)!))
            .ignoresSafeArea()
        
    }
}

//MARK: - VIDEOINFO
struct videoInfo: View {
    
    var titulo: String
    var studio: String
    var calificacion: String
    var anoPublicacion: String
    var descripcion: String
    var tags: [String]
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            Text("\(titulo)")
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding(.leading)
            
            HStack{
                Text("\(studio)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5)
                    .padding(.leading)
                
                Text("\(calificacion)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5)
                
                Text("\(anoPublicacion)")
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .padding(.top, 5)
            }
            
            Text("\(descripcion)")
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.top, 5)
                .padding(.trailing, 5)
                .padding(.leading)
            
            // este hstack es para mostrar los tags, los tags en un arreglo de strings entonces usamos un forEach para iterar
            HStack{
                ForEach(tags, id:\.self){ tag in
                    Text("#\(tag)")
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .padding(.top, 4)
                        .padding(.leading)
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

//MARK: - GALLERY
struct Gallery: View {
    
    var imgsUrl: [String]
    
    //Aqui vamos a crear una constante para crear un LazyHStack para mostrar las imagenes esta vez de manera horizontal y solo será una columna
    
    let formaGrid = [
        
        GridItem(.flexible())
        
    ]
    
    var body: some View {
        
        // Primero hacemos un VStack por que en el diseño tenemos un texto con el nombre galerias y despues el scrollview horizontal que contendrá a su vez el lazyGrid para que si hay mas de dos imagenes que se salga de la pantalla, puedas darle scroll
        
        VStack(alignment: .leading) {
            
            Text("GALERÍA")
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)
            
            
            ScrollView(.horizontal) {
                
                LazyHGrid(rows: formaGrid, spacing: 8) {
                    
                    
                    ForEach(imgsUrl, id: \.self) { item in
                        
                        // Vamos a desplegar las imagenes del servidor por medio de url
                        
                        KFImage(URL(string: item))
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.bottom, 12)
                    }//: FOREACH
                    
                }//: LAZYGRID
                
            }//: SCROLLVIEW
            .frame(height: 180)
            
        }//: VSTACK
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

//MARK: - COMENTARIOS
struct Comentarios: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Comentarios".uppercased())
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)
            VStack(alignment: .leading) {
                HStack{
                    Image("perfilEjemplo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    VStack(alignment: .leading){
                        Text("Freddy Krueger")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        Text("Hace 7 días")
                            .foregroundColor(.white)
                            .fontWeight(.light)
                        
                    }//: VSTACK
                    .padding(.leading)
                }//: HSTACK
                .padding(.top, 10)
                .padding(.leading, 10)
                Text("He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.")
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    .padding(.bottom, 10)
            }//: VSTACK
            // el backgorund tambien puede ir con el color exacto del ejemplo, así:
            // .background(Color("blue-gray"))
            .background(Color(white: 1, opacity: 0.08))
            .cornerRadius(12)
            .padding(.leading, 10)
            .padding(.trailing, 10)
        }//: VSTACK PRINCIPAL
        .frame(maxWidth: .infinity, alignment: .leading)
    }//: BODY
}//: STRUCT

//MARK: - JUEGOS SIMILARES
struct juegosSimilares: View {
    var body: some View {
        VStack {
            Text("Juegos Similares".uppercased())
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)
            // apara el reto de mostrar los juegos similares puedo hacer un scrollview horizontal y adentro un lazyHStack como en el de galeria de imagenes pero no se bien de donde voy a tomar las imagenes, o si son botones cuales juegos voy a presentar por eso aun no lo he hecho.
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(url: "Ejemplo.com", titulo: "Sonic", studio: "Sega", calificacion: "E+", anoPublicacion: "1991", descripcion: "Juego de Sega Genesis publicado en 1991 con más de 40 millones de copias vendidas actualmente", tags: ["plataformas","mascota"], imgsUrl: [ "https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg","https://cdn.cloudflare.steamstatic.com/steam/apps/268910/ss_615455299355eaf552c638c7ea5b24a8b46e02dd.600x338.jpg"])
    }
}

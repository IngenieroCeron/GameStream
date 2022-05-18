//
//  FavoritesView.swift
//  GameStream
//
//  Created by Eduardo Ceron on 26/01/22.
/*
 En esta pantalla vamos a mostrar puros videos donde se puedan reproducir mas de un video a la vez.
 1. Crear un observableObject llamado todoslosvideojuegos
 2. en el scrollview metemos un for each (igualito al que usamos en la pantalla gamesview) solo le agregamos un texto abajo para que sea igual al diseño.
 */

import SwiftUI
import AVKit

struct FavoritesView: View {
    
    @ObservedObject var todosLosVideoJuegos = ViewModel()
    
    var body: some View {
        
        ZStack {
            Color("colorFondo")
                .ignoresSafeArea(.all, edges: .all)
            VStack {
                Text("favoritos".uppercased())
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 9)
                ScrollView{
                    VStack(spacing: 0) {
                        ForEach(todosLosVideoJuegos.gamesInfo, id: \.self) { juego in
                            VideoPlayer(player: AVPlayer(url: URL(string: juego.videosUrls.mobile)!))
                                .frame(height: 300)
                            Text("\(juego.title)")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color("blue-gray"))
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                        }
                    }
                }.padding(.bottom, 8)
            }
            .padding(.horizontal, 6)
            
        }
        //.navigationBarHidden(true)
        //.navigationBarBackButtonHidden(true)
        
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}

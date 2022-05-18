//
//  Home.swift
//  GameStream
//
//  Created by Eduardo Ceron on 13/01/22.
//

import SwiftUI

struct Home: View {
    
    @State var tabSeleccionado: Int = 2
    
    var body: some View {
        
        TabView(selection: $tabSeleccionado){
            ProfileView()
                .tabItem{
                    Image(systemName: "person")
                    Text("Perfil")
                }.tag(0)
            //Text("Juegos")
            GamesView()
                .tabItem{
                    Image(systemName: "gamecontroller")
                    Text("Juegos")
                }.tag(1)
            PantallaHome()
                .tabItem{
                    Image(systemName: "house")
                    Text("Inicio")
                }.tag(2)
            FavoritesView()
                .tabItem{
                    Image(systemName: "heart")
                    Text("Favoritos")
                }.tag(3)
        }
        // este es para cambiar el color de la vista selecconada a blanco (por default me lo daba en azul)
        .accentColor(.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    //Para poder personalizar el tabView necesitamos ocupar la libreria anterior o sea UIKit; para eso hacemos un init:
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color("tabBarColor"))
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().isTranslucent = true
        print("iniciando las vistas de home")
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

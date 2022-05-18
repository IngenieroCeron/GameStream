//
//  EditProfileView.swift
//  GameStream
//
//  Created by Eduardo Ceron on 27/01/22.
//

import SwiftUI

struct EditProfileView: View {
    
    @State var imagenPerfil: Image? = Image("perfilEjemplo")
    @State var isCameraActive = false
    
    var body: some View {
        ZStack {
            
            Color("colorFondo")
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack {
                    
                    Text("Editar perfil")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom,28)
                    
                    //SUImagePickerView(sourceType: .photoLibrary, image: $imagenPerfil, isPresented: $isCameraActive)
                    
                    //MARK: - Boton para tomar foto
                    Button(action: {
                        print("Foto")
                        isCameraActive = true
                    }, label: {
                        ZStack {
                            imagenPerfil!
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .sheet(isPresented: $isCameraActive, content: { SUImagePickerView(sourceType: .photoLibrary, image: self.$imagenPerfil, isPresented: $isCameraActive)
                            })
                            
                            Image(systemName: "camera")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                        }
                    })
                    
                }//: VSTACK
                .padding(.bottom, 18)
                
                ModuloEditar()
                
            }//: SCROLVIEW
            
        }//: ZSTACK
        
    }//: BODY
    
}

//MARK: - MODULO EDITAR

struct ModuloEditar: View  {
    
    @State var contraseña = ""
    @State var correo = ""
    @State var nombre = ""
    
    var body: some View{
        VStack(alignment: .leading) {
            Text("Correo Electrónico")
                .foregroundColor(Color("dark-cian"))
                .font(.title3)
                .fontWeight(.heavy)
            ZStack(alignment: .leading){
                if correo.isEmpty {
                    Text("Ejemploagmailcom")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                TextField("", text: $correo)
                    .foregroundColor(.white)
                    .font(.title3)
            }//: ZStack
            Divider()
                .frame(height: 1)
                .background(Color("dark-cian"))
                .padding(.bottom)
            Text("Contraseña")
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.bold)
            ZStack(alignment: .leading){
                if contraseña.isEmpty {
                    Text("Introduce tu nueva contraseña")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                SecureField("", text: $contraseña)
                    .foregroundColor(.white)
                    .font(.title3)
            }//: ZStack
            Divider()
                .frame(height: 1)
                .background(.white)
                .padding(.bottom)
            Text("Nombre")
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.bold)
            ZStack(alignment: .leading){
                if nombre.isEmpty {
                    Text("Introduce tu nombre de usuario")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                TextField("", text: $nombre)
                    .foregroundColor(.white)
                    .font(.title3)
            }//: ZStack
            Divider()
                .frame(height: 1)
                .background(.white)
                .padding(.bottom)
            
            Button(action: {
                actualizarDatos()
            }, label: {
                Text("Actualizar Datos".uppercased())
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 11,
                                        leading: 18,
                                        bottom: 11,
                                        trailing: 18))
                    .overlay(RoundedRectangle(cornerRadius: 6.0)
                                .stroke(Color("dark-cian"), lineWidth: 1.0)
                                .shadow(color: .white, radius: 4)
                    )
            })
            
        }//: VSTACK
        .padding(.horizontal, 42)
    }
    //MARK: - Funcion Actualizar datos
    // esta funcion la vamos a utilizar al momento de pulsar el boton actualizar datos
    // Primero creamos una constante llamada objetoActualizadorDatos, este objeto va a provenir de una clase llamada SaveData() guardada en la logica o sea en la carpeta de VistasModelo
    // Despues creamos otra constante que se llame resultado, que va a ser el resultado de guardar datos de la clase SaveData()
    
    func actualizarDatos() {
        
        let objetoActualizadorDatos = SaveData()
        
        // en esta constante estamos guardando el correo, contraseña y nombre que el usuario ingresa aqui en la pantalla editar perfil
        let resultado = objetoActualizadorDatos.guardarDatos(correo: correo, contraseña: contraseña, nombre: nombre)
        
        // Y despues solo imprimimos en consola los datos que haya guardado
        
        
        print("se guardaron los datos con éxito? \(resultado)")
    }
    
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

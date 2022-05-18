//
//  ProfileView.swift
//  GameStream
//
//  Created by Eduardo Ceron on 27/01/22.
//

import SwiftUI

struct ProfileView: View {
    
    @State var nombreUsuario = "Lorem"
    @State var imagenPerfil: UIImage = UIImage(named: "perfilEjemplo")!
    
    var body: some View {
        ZStack {
            
            Color("colorFondo")
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
            VStack {
                
                Text("Perfil".uppercased())
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .center)
                
                
                VStack{
                    
                    Image(uiImage: imagenPerfil)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                    
                    Text(nombreUsuario)
                        .fontWeight(.bold)
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .center)
                    
                }
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 32, trailing: 0))
                
                
                Text("Ajustes".uppercased())
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 18)
                    .padding(.bottom)
                
                ModuloAjustes()
                
                Spacer()
                
            }//: VSTACK
            
            .navigationBarHidden(true)
            
        }//: ZSTACK
        //Aqui e vamos a poner un onAppear que sirve para añadir una accion cuando la pantalla se ejecute. AQui vamos a poner para que se recupere la informacion del usuario pero por lo mientras solo le pondremos un print
        .onAppear(perform: {
            print("revisando si tengo datos de usuario en mis user default")
            // metodo para recuperacion de imagen
            if returnUiImage(named: "fotoPerfil") != nil {
                imagenPerfil = returnUiImage(named: "fotoPerfil")!
            }else {
                print("No encontré foto de perfil")
            }
            
            // este if es para que cuando aparezca la pantalla ayude a recuperar la información del usuario, en este caso el nombre del usuario. En caso de que no encuentre nada va a mostrar lorem por defecto
            if UserDefaults.standard.object(forKey: "datosUsuario") != nil {
                nombreUsuario = UserDefaults.standard.stringArray(forKey: "datosUsuario")![2]
            }else{
                print("No encontré información del usuario")
            }
            
        })//: ONAPPEAR
    }//: BODY
    
    func returnUiImage(named:String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false){
            
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
            
        }
        return nil
    }
    
}//: STRUCT

//MARK: - MODULO AJUSTES

struct ModuloAjustes: View {
    
    @State var isToggleOn = true
    @State var isEditProfileViewActive = false
    
    var body: some View {
        VStack(spacing: 3) {
            
            //: BOTON CUENTA
            
            Button(action: {}, label: {
                HStack {
                    Text("Cuenta")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding()
            })//: BUTTON
                .background(Color("blue-gray"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            //: BOTON NOTIFICACION
            
            Button(action: {}, label: {
                HStack {
                    Text("Notificaciones")
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $isToggleOn)
                }
                .padding()
            })//: BUTTON
                .background(Color("blue-gray"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            //: BOTON EDITAR PERFIL
            
            Button(action: {
                isEditProfileViewActive = true
            }, label: {
                HStack {
                    Text("Editar Perfil")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding()
            })//: BUTTON
                .background(Color("blue-gray"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            //: BOTON CALIFICAR ESTA APLICACION
            
            Button(action: {}, label: {
                HStack {
                    Text("Califica esta aplicación")
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding()
            })//: BUTTON
                .background(Color("blue-gray"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            NavigationLink(destination: EditProfileView(),
                           isActive: $isEditProfileViewActive ,
                           label: {
                EmptyView()
            })
            
        }//: VSTACK
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

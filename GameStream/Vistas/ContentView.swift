//
//  ContentView.swift
//  GameStream
//
//  Created by Eduardo Ceron on 30/10/21.
//

import SwiftUI

//MARK: - ContentView

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                //este spacer es para cuando agregamos mas contenido, no lo
                //pase arriba del safearea
                Spacer()
                Color(red: 19/255, green: 30/255, blue: 53/255, opacity: 1)
                    .ignoresSafeArea()
                VStack{
                    Image("appLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .padding(.bottom , 42)
                    
                    InicioYRegistro()
                    
                }
            }//: ZSTACK
            .navigationBarHidden(true)
        }//: NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
//MARK: - InicioYREgistro
struct InicioYRegistro:View {
    
    @State var tipoInicioSesion: Bool = true
    
    var body: some View{
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    tipoInicioSesion = true
                }) {
                    Text("INICIO DE SESIÓN")
                        .foregroundColor(tipoInicioSesion ? .white : .gray)
                }
                Spacer()
                Button(action: {
                    tipoInicioSesion = false
                }) {
                    Text("REGÍSTRATE")
                        .foregroundColor(tipoInicioSesion ? .gray : .white)
                }
                Spacer()
            }//: HStack
        }//: VStack
        Spacer(minLength: 42)
        if tipoInicioSesion {
            InicioSesionView()
        }else{
            RegistroView()
        }
    }//: var body some View
}
//MARK: - InicioSesionView
struct InicioSesionView:View {
    @State var correo: String = ""
    @State var contraseña = ""
    @State var contraseñaInvisible: Bool = false
    @State var isPantallaHomeActive: Bool = false
    @State var alertaInicioSesion = false
    var body: some View{
        ScrollView {
            VStack(alignment: .leading) {
                Text("Correo Electrónico")
                    .foregroundColor(Color("dark-cian"))
                    .fontWeight(.semibold)
                ZStack(alignment: .leading){
                    if correo.isEmpty {
                        Text("Ejemploagmailcom")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    TextField("", text: $correo)
                        .foregroundColor(.white)
                }//: ZStack
                Divider()
                    .frame(height: 1)
                    .background(Color("dark-cian"))
                    .padding(.bottom)
                Text("Contraseña")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                ZStack(alignment: .leading){
                    if contraseña.isEmpty {
                        Text("Escribe tu contraseña")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    HStack{
                        if !contraseñaInvisible {
                            SecureField("", text: $contraseña)
                                .foregroundColor(.white)
                        } else {
                            TextField("", text: $contraseña)
                                .foregroundColor(.white)
                        }
                        Button(action: {
                            contraseñaInvisible.toggle()
                        }, label: {
                            Image(systemName: "eye.fill")
                                .foregroundColor(contraseñaInvisible ? Color("dark-cian") : .gray)
                        })
                    }
                }//: ZStack
                Divider()
                    .frame(height: 1)
                    .background(Color("dark-cian"))
                    .padding(.bottom)
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .foregroundColor(Color("dark-cian"))
                    .frame(alignment: .trailing)
                    .padding(.bottom)
                //MARK: - BOTON INICIO SESIÓN
                Button(action: {
                    iniciarSesion()
                }) {
                    Text("INICIAR SESIÓN")
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
                }//: Button
                .padding(.bottom, 50)
                //MARK: - Alerta InicioSesión
                .alert(isPresented: $alertaInicioSesion) {
                    Alert(title: Text("Error"), message: Text("Usuario o contraseña incorrecto"), dismissButton: .default(Text("Entendido")))
                }
                
                Text("Inicia sesión con redes sociales")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 32)
                
                HStack{
                    //MARK: - boton face y twitter
                    //Este es el reto que hizo el programador, como yo lo hice esta abajo comentado
                    Button(action: {print("Inicio de sesión con Facebook")}) {
                        Text("Facebook")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 8.0)
                            .frame( maxWidth: .infinity, alignment: .center)
                            .background(Color("blue-gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }
                    Button(action: {print("Inicio de sesión con Twitter")}) {
                        Text("Twitter")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 8.0)
                            .frame( maxWidth: .infinity, alignment: .center)
                            .background(Color("blue-gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }
                }
                .padding(.bottom)
                
                //                HStack {
                //                    Button(action: {
                //                        print("facebook")
                //                    }) {
                //                        Text("Facebook")
                //                            .fontWeight(.medium)
                //                            .foregroundColor(.white)
                //                            .frame(width: 140, height: 35,alignment: .center)
                //                            .background(Color(white: 1, opacity: 0.15))
                //                            .cornerRadius(8)
                //                    }
                //                    Button(action: {
                //                        print("Twitter")
                //                    }) {
                //                        Text("Twitter")
                //                            .fontWeight(.medium)
                //                            .foregroundColor(.white)
                //                            .frame(width: 140, height: 35,alignment: .center)
                //                            .background(Color(white: 1, opacity: 0.15))
                //                            .cornerRadius(8)
                //                    }
                //                }
            }//: VStack
            .padding(.horizontal, 27)
            
            NavigationLink(
                destination: Home(),
                isActive: $isPantallaHomeActive,
                label: {
                EmptyView()
            })
            
        }//: ScrollView
        
    }//: BODY
    
    //MARK: - FUNC INICIARSESIÓN
    
    func iniciarSesion(){
        
        let objetoActualizadorDatos = SaveData()
        let resultado = objetoActualizadorDatos.validar(correo: self.correo, contraseña: self.contraseña)
        
        if resultado == true
        {
            // Se activa la pantalla Home
            alertaInicioSesion = false
            isPantallaHomeActive = true
        }else {
            // Se activa la alerta
            alertaInicioSesion = true
            
        }
        
    }//: FUNC
    
}//: STRUCT




//MARK: - RegistroView
struct RegistroView:View {
    @State var correo: String = ""
    @State var contraseña = ""
    @State var confirmarContraseña = ""
    @State var contraseñaInvisible: Bool = false
    @State var contraseñaIncorrecta: Bool = false
    
    var body: some View{
        ScrollView {
            VStack(alignment: .center){
                Text("Elige una foto de perfil")
                    .fontWeight(.bold)
                    .foregroundColor(.white )
                Text("Puedes cambiar o elegirla mas adelante")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                Button(action: {
                    tomarFoto()
                }, label: {
                    ZStack{
                        Image("perfilEjemplo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "camera")
                            .foregroundColor(.white)
                    }
                })
                    .padding(.bottom)
            }
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                Text("Correo Electrónico*")
                    .foregroundColor(Color("dark-cian"))
                    .fontWeight(.semibold)
                ZStack(alignment: .leading){
                    if correo.isEmpty {
                        Text("Ejemploagmailcom")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    TextField("", text: $correo)
                        .foregroundColor(.white)
                }//: ZStack
                Divider()
                    .frame(height: 1)
                    .background(Color("dark-cian"))
                    .padding(.bottom)
                Text("Contraseña*")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                ZStack(alignment: .leading){
                    if contraseña.isEmpty {
                        Text("Escribe tu contraseña")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    HStack{
                        if !contraseñaInvisible {
                            SecureField("", text: $contraseña)
                                .foregroundColor(.white)
                        } else {
                            TextField("", text: $contraseña)
                                .foregroundColor(.white)
                        }
                        Button(action: {
                            contraseñaInvisible.toggle()
                        }, label: {
                            Image(systemName: "eye.fill")
                                .foregroundColor(contraseñaInvisible ? Color("dark-cian") : .gray)
                        })
                    }
                }//: ZStack
                Divider()
                    .frame(height: 1)
                    .background(Color("dark-cian"))
                    .padding(.bottom)
                Text("Confirmar Contraseña*")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                ZStack(alignment: .leading){
                    if confirmarContraseña.isEmpty {
                        Text("Escribe tu contraseña")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    HStack{
                        if !contraseñaInvisible {
                            SecureField("", text: $confirmarContraseña)
                                .foregroundColor(.white)
                        } else {
                            TextField("", text: $confirmarContraseña)
                                .foregroundColor(.white)
                        }
                        Button(action: {
                            contraseñaInvisible.toggle()
                        }, label: {
                            Image(systemName: "eye.fill")
                                .foregroundColor(contraseñaInvisible ? Color("dark-cian") : .gray)
                        })
                            
                    }
                }//: ZStack
                Divider()
                    .frame(height: 1)
                    .background(Color("dark-cian"))
                    .padding(.bottom)
                
            }
                //MARK: - BOTON REGISTRAR
                Button(action: {
                    registrar()
                }) {
                    Text("REGÍSTRATE")
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
                }//: Button
                .padding(.bottom, 30)
                //MARK: - ALERTA CONTRASEÑA INCORRECTA
                .alert(isPresented: $contraseñaIncorrecta) {
                    Alert(title: Text("Error"), message: Text("Las contraseñas no coinciden"), dismissButton: .default(Text("Entendido")))
                }
                
                Text("Regístrate con redes sociales")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 32)
                
                HStack{
                    Button(action: {print("Inicio de sesión con Facebook")}) {
                        Text("Facebook")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 8.0)
                            .frame( maxWidth: .infinity, alignment: .center)
                            .background(Color("blue-gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }
                    Button(action: {print("Inicio de sesión con Twitter")}) {
                        Text("Twitter")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 8.0)
                            .frame( maxWidth: .infinity, alignment: .center)
                            .background(Color("blue-gray"))
                            .clipShape(RoundedRectangle(cornerRadius: 4.0))
                    }
                }
                
                
            }//: VStack
            .padding(.horizontal, 27)
        }//: ScrollView
    }
    //MARK: - FUNC REGISTRAR
    func registrar(){
        
        if confirmarContraseña == contraseña {
            let objetoActualizadorDatos = SaveData()
            
            let registro = objetoActualizadorDatos.guardarDatos(correo: correo, contraseña: contraseña, nombre: "")
            
            print("\(registro)")
        }else {
            contraseñaIncorrecta = true
        }
    }
    
}

func tomarFoto(){
    print("Toma foto de perfil")
}


// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

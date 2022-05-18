#  Para Usar camara o Imagenes del celular

Vamos a necesitar una libreria de terceros (hasta ahorita swiftui no tiene algo nativo para usar)

La libreria es: SUImagePickerView: https://github.com/karthironald/SUImagePickerView

Descargamos la carpeta en zip, despues abrimos el zip, nos vamos a la carpeta principal (SUImagePickerView) y vamos a arrastrar la carpeta que dice SUImagePickerView.swift y lo vamos a colocar dentro de la carpeta VistasModelo ya que tiene que ver con lógica.

Ahora nos vamos a la pantalla de EditProfile y nos dirigimos a la parte donde tenemos nuestro boton para tomar foto. Dentro de la accion del boton queremos que al pulsar el boton se muestre una vista, esta vista la tenemos que modificar por que actualmente no la podemos usar directamente. Si utilizamos la vista directamente, nos aparecereía la vista completa con las imagenes de la biblioteca de fotos de nuestro cel:
                    SUImagePickerView(sourceType: .photoLibrary, image: $imagenPerfil, isPresented: $isCameraActive)
    Pero lo que quieres es que al pulsar el boton se muestre la vista con la galeria de fotos de tu biblioteca, entonces para eso hacemos lo siguiente:

Creamos una variable para la foto de perfil:
    @State var imagenPerfil: Image? = Image("perfilEjemplo")

Creamos otra variable:
    @State var isCameraActive = false

Le vamos a agregar a nuestros modificadores del label del boton un .sheet que es una hoja, le vamos a dar el inicializador isPresented: y content:
    Dentro del ispresented le vamos a dar una variable previamente creada de tipo booleano (@State var isCameraActive = false) y en content o sea el contenido de la hoja va a ser el codigo de SUImagePickerView que pusimos en la linea 10 de este documento. Quedando de la siguiente manera el codigo:
                            .sheet(isPresented: $isCameraActive, content: { SUImagePickerView(sourceType: .photoLibrary, image: self.$imagenPerfil, isPresented: $isCameraActive)
                            })

##Ahora para usar la camara del celular, tomar la foto y usar esa foto para mostrar en la app es de la siguiente manera:

Abrimos el archivo que importamos (**SUImagePickerView.swift**) y nos vamos a la linea 45 a la funcion func imagePickerController, ahi es donde se recupera la imagen que el usuario selecciona, ya sea por medio de la libreria o por medio de la captura de camara, entonces a nosotros nos interesa guardar esa constante image en la memoria flash del dispositivo para despues poderla mosrar dentro de nuestra pantalla de la app, entoces:
    Primero vamos a modificar nuestro nombre de la constante para que haya una diferencia entre el self.image y la constante. Le ponemos nombre UiImage, entonces en la linea de abajo donde esta el self.image, al final le cambiamos tambien por UiImge.
    Despues ahi dentro del if, vamos a declarar otro if con otra constante, dentro de ese if vamos a declarar donde queremos guardar nuestra fotografia, entonces hacemos otra constante llamada documents y va a ser igual a "FileManager" (esta clase nos ayuda a poder guardar y recuperar información del dispositivo) despues ponemos .default, quiere decir en la posición default y despues .urls con el inicializador (for:in:) en el for le ponemos .documentDirectory y en el in: ponemos lo que el tiene  el usuario para guardar: userDomainMask y por ultimo en la posición 0, quedando así:
                if let data = UiImage.pngData(){
                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            }
    Despues hacemos una referencia a esa dirección  de donde se va a guardar la imagen, le tenemos que dar como la direccion de donde esta ubicada esa imagen mas el nombre de la imagen y esos se hace con .appendingPathComponent
    Despues agregamos un do/catch y dentro del do ponemos que intente escribbir la informacion de nuestra fotografia en la url antes declarada que apunta a nuestros documentos del dispositivo:
                    try data.write(to: url)
    Y con esto terminamos de modificar nuestra libreria de terceros. Con esta modificacion que hicimos, ya tenemos al habilidad de guardar la fotografia que el usuario seleccione ya sea de sus fotografias ya guardadas o de una fotografia que apenas va a tomar
Ya solo falta recuperar la foto que guardamos.

Dentro de la pantalla de perfil tenemos que programar la habilidad para que cuando el usuario entre a esa pantalla, se cambien esa foto de perfil con la que el usuario seleccionó al momento de editar su perfil
    
Entonces primero creamos una variable la cual tenga state para seguirla en caso e cualquier cambio. y va a ser de tipo UIImage:
    @State var imagenPerfil: UIImage = UIImage(named: "perfilEjemplo")!
    
Despues en el bloque de .onAppear vamos agregar codigo para que cuando abra la pantalla Profileview en ese momento recupere la imagen de perfil guardada 
Primero agregamos un método despues de body, dentro de la misma estructura de ProfileView.
Agregamos la funcion returnUiImage, y dentro un if: para el if primero recuperamos el directorio:
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false){
            
        }
Despues dentro del if regresamos la imagen que estamos buscando dentro de ese direcorio:
    func returnUiImage(named:String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false){
            
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
            
        }
        return nil
    }
Despues nos regresamos al ONAPPEAR para agregarle un if: si nosotros podemos recuperar la imagencon la funcion returnUiImage:
            if returnUiImage(named: "fotoPerfil") != nil {
                imagenPerfil = returnUiImage(named: "fotoPerfil")!
            }else {
                print("No encontré foto de perfil")
            }
Despues de haber hecho lo anterior conseguimos que en nuestra pantalla profileView aparezca la imagen que seleccionamos de nuestra galeria. Ahora ya solo nos falta implementar para tomar la foto.

    Simplemente le cambiamos al SUImagePickerView en la propiedad sourceType cambiarle a .camera en vez de .photoLibrary
    
Pero para que usemos la camara del dispositivo tenemos que probarlo en un dispositivo real y para ello se requieren ciertas cosas:
1. dirigirnos al info.plist, si no lo encuentras, puedes irte en los targets en la pestaña info
2. agregarle con el boton mas uno que se llama Privacy - Camera Usage Description y en los valores le ponemos "Se utiliza cámara para tomar foto de perfil" para que le aparezca al usuario que la aplicacion quiere acceder a la camara


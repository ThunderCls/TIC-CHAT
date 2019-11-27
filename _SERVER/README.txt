***********************
    TIC CHAT v1 DOC
***********************

[Configurar el servidor]

  1- Editar archivo server.ccc
  2- Primera linea: color primario del servidor, misma sintaxis que el color en CMD
  3- Segunda linea: color secundario
  4- Tercera linea: Descripcion, mensaje que le aparecerá a todo el mundo
  5- Cuarta linea: Latencia del servidor (en segundos), entre 1 y 9999, es el tiempo en que hará el refresco de pantalla cada cliente

[Borrar los datos del servidor]
  1- Abrir clearserver.bat
  2- Listo

[Licencia]
  Creative Commons 0
  https://creativecommons.org/publicdomain/zero/1.0/

["Librerias"]
  Son archivos EXE que sirven como extensiones para batch, están alojados en la carpeta "_SERVER".
  1- Insertbmp: Sirve para insertar imagenes .bmp en batch
     https://www.thebateam.org/2016/11/how-to-show-images-on-cmd-console.html?fbclid=IwAR3kVjDHGuqW0CGyOk6u5P6ivDZrxG03FLYmBbtrzP8k8dUt40zeCtshy8I

  2- Cmdow: Permite funciones con ventanas como moverlas, obtener su posicion, etc.
     https://ritchielawrence.github.io/cmdow/

  3- Cursor: Permite posicionar el cursor en cualquier parte de la pantalla
     En ordenadores antiguos puede dar error por no encontrar el archivo "msvcr70.dll", así que lo he añadido a la carpeta del servidor
     Esta extensión la hice con C++


  Código de "cursor.exe":

  #include <windows.h>
  #include <stdio.h>

  void gotoxy(int x, int y) {
      COORD pos = {x, y};
      HANDLE output = GetStdHandle(STD_OUTPUT_HANDLE);
      SetConsoleCursorPosition(output, pos);
  }

  int main(int argc,char* argv[])
   {
      int xx = atoi(argv[1]);
      int yy = atoi(argv[2]);
      gotoxy(xx,yy);
      return 0;
  }
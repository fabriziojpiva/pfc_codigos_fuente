## -*- octave -*-
##Carga coordenadas y iD's de los vertices del
##contorno FSI, correspondientes a la configuracion
##inicial.
clear
hold off
close all

k=0;


##Path de trabajo: aca tendrian que poner el directorio en donde van a guardar los
##datos y los resultados para la corrida.
working_path=strcat("/home/gustavo/Dropbox/coupling_sp/Continuo/Escalado_1/prueba",num2str(k+5),"/");
##working_path=strcat("./Discontinuo/prueba",num2str(k+5),"/");
command=strcat("mkdir\t",working_path);
system(command,"sync");


##Path donde esta el codigo de proyeccion conservativo
##project_path="/u/grios/state_projection/conservative_method/";
project_path="/home/gustavo/Dropbox/state_projection/conservative_method/";


##Crea un subdirectorio figuras en el working_path
command=strcat("mkdir\t",working_path,"figuras");
system(command,"sync");


##Genera la malla del fluido y la estructura y el estado sobre
##el contorno del fluido.

##Factor de escala para la malla
##scale_factor=100; Sólo se uso en el caso conservativo.
scale_factor=1;


##Estructura
##xs=linspace(-0.5, 0.5, 2^k * 7 + 1); ##paper de Boer
xs=linspace(-0.5, 0.5, 2^k * 5 + 1); ##Tesis de Boer
ys=0.2*sin(2*pi*xs);

## Tesis de Boer (discontinua)
## a=0.5-2/5;
## ys=feval("w_hat",xs,a);

icone_s=[[length(xs):-1:2]',[length(xs)-1:-1:1]'];

my_fprintf(strcat(working_path,"struct_1.nod.tmp"),"%f\t%f\n",[scale_factor.*xs',ys']);
my_fprintf(strcat(working_path,"struct_1.con_surf_fsi.tmp"),"%d\t%d\n",icone_s);



##Fluido
##xf=linspace(-0.5, 0.5, 2^k * 21 + 1); ##paper de Boer
xf=linspace(-0.5, 0.5, 2^k * 26 + 1); ##Tesis de Boer
yf=0.2*sin(2*pi*xf);
icone_f=[[1:length(xf)-1]',[2:length(xf)]'];


##Test 1 de Boer para la presion (continua)
pf=0.2+0.01*cos(2*pi*xf);


## ##Test 2 tesis de Boer para la presion (discontinua)
## af=0.5-9/26;
## pf=feval("w_hat",xf,af);
## ##plot(xf,pf,"k-")


my_fprintf(strcat(working_path,"fluid_1.nod.tmp"),"%f\t%f\n",[scale_factor.*xf',yf']);
my_fprintf(strcat(working_path,"fluid_1.con_surf_fsi.tmp"),"%d\t%d\n",icone_f);
my_fprintf(strcat(working_path,"fluid_1.state.tmp"),"%f\n",pf);



###########################################################
## Proyeccion del estado desde el contorno del fluido hacia
## el de la estructura.


##Aca tendrian que insertar una llamada para ejecutar el
##codigo que proyeccion que escribieron


##Ejecuta el pconserv.bin. De aca ya sale el
##archivo con el estado interpolado en el contorno
##de la estructura.
## disp("Starts State Projection")
## command=strcat(project_path,"pconserv.bin");
## system(command,"sync");
## disp("Ends State Projection")



######################################################
##Cargo el estado proyectado sobre los vertices del
##contorno de la estructura.
file2load=strcat(working_path,"struct_1.state_interp.tmp");
state_csd=load(file2load);

##Genero el estado exacto que tendrian que tener los
##vertices de la estructura.

##Test 1 de Boer para la presion (continua)
state_exact=0.2+0.01*cos(2*pi*xs(:,1));

## ##Test 2 de Boer (tesis) para la presion (discontinua)
## ##Notar que aca voy a tener problemas con la coincidencia
## ##del salto justo en algun vertice de la malla de la
## ##estructura.
## af=0.5-9/26;
## state_exact=feval("w_hat",xs(:,1),af);


keyboard



###############################################
## Calculo la norma L2 del error en el estado proyectado
## de los vertices del contorno de la estructura.

error=state_exact-state_csd';
l2_err=sqrt(sum(error.^2));

file2open=strcat(working_path,"l2_err.tmp");
[fid,msg]=fopen(file2open,"a");
fprintf(fid,"%f\n",l2_err);
fclose(fid);

## Hacemos un grafico con la solucion exacta y
## la proyectada. Escalamos el intervalo por 0.1,
## ya que consideramos para resolver el problema
## numerico uno 10 veces mayor.

plot(xnod_csd(:,1),state_exact,"b-;exact pressure;",xnod_csd(:,1),state_csd,"r-;projected pressure;")
hold on
xlabel("X");  ylabel("Pressure"); grid on;
axis auto;
path_figure=strcat(working_path,"figuras/struct_1.state_interp.eps");
print(path_figure,"-deps","-color","-S800,600");
command=strcat("epstopdf\t",path_figure);
system(command,"sync");


xnode1 = [1 1 0;
         2 1 0;
         3 1 0;
         4 0.5 0;
         4 2 0;
         3 5 0;
         2 4 0;
         1 3 0;
         1.5 2 0;
         2.5 1.5 0;
         3 3 0;
         ];
icone1 = [1 2 9;
         2 10 9;
         2 3 10;
         3 11 10;
         3 4 5;
         3 5 11;
         5 6 11;
         6 7 11;
         7 9 11;
         9 10 11;
         9 7 8;
         1 9 8];
estados1  = [ [1:size(xnode1,1)]' , ones(size(xnode1,1),3)*3 ];
%--------------------         
xnode2 = [1.5 0.5 0;
          2 0.5 0;
          3 0.5 0;
          3.5 0.5 0;
          3.5 1.5 0;
          3.5 3 0;
          2.5 3 0;
          2 3 0;
          1.5 3 0;
          1.5 1.5 0;
          2 1.5 0;
          3 1.5 0;
          2 2 0;
          2.5 2 0 ;
          3.5 2 0
          ];
icone2 = [1 2 11 10;
          2 3 12 11 ;
          3 4 5 12 ;
          11 5 15 13;
          14 15 6 7;
          13 14 7 8;
          10 11 8 9  
            ] ;
estados2  = [ [1:size(xnode2,1)]' , ones(size(xnode2,1),3)*(-1) ];
%------------------            
xnode3 = [1 0.5 0;
          2 0.5 0;
          3 0.5 0;
          4.5 1.5 0;
          3.5 2 0;
          3 2.5 0;
          2.5 2.5 0;
          1.5 2.5 0;
          1.5 1.5 0;
          2 1.5 0 ;
          3 1.5 0
            ];
icone3 = [%1 2 9;
          2 3 9;
          3 11 9;
          %3 4 11;
          %11 4 5;
          11 5 6;
          11 6 7;
          10 11 7;
          10 7 8;
          9 10 8
          %1 9 8
            ];
% estados3 MODIFICADO PARA QUE SEA MALLA CONOCIDA CON FUNCION SIN(X*Y).
estados3  = [ [1:size(xnode2,1)]' , ( 0.5*xnode2(:,1)+xnode2(:,2)) ];

xnode4=[1.5 4 0;
        2.5 6 0;
        4.5 7 0;
        5.5 7 0;
        7.5 8 0;
        8.5 8 0;
        9   8 0;
        11.5 9.5 0
        ];
        
icone4=[1 2;
        2 3;
        3 4;
        4 5;
        5 6;
        6 7;
        ];

estados4  = [ [1:size(xnode4,1)]' , ones(size(xnode4,1),3).*(-1)];

xnode5=[ 1 1 0;
         2 2.5 0;
         3.5 3.5 0;
         4.5 4 0;
         7 5 0;
         8.5 5.5 0;
         10 5.5 0
         ];
         
icone5=[%1 2;
        2 3;
        3 4;
        4 5;
        5 6;
        %6 7
        ];

estados5  = [ [1:size(xnode5,1)]' , ones(size(xnode5,1),3).*5 ];

## Test de Boer: mallas.

cells = 1000;

k=log2( (cells-1)/5 );
k = round(k);

#xs= linspace( -0.5, 0.5, 2^k * 7 + 1); Paper de Boer
xs= linspace( -0.5, 0.5, 2^k * 5 + 1 ); #
ys= 0.2*sin( 2*pi.*xs);

xf = linspace( -0.5, 0.5, 2^k * 26 + 1);
yf= 0.2*sin( 2*pi.*xf);


xnode_s=[xs' ys' zeros(length(xs),1)];
xnode_f=[xf' yf' zeros(length(xf),1)];

icone_s= [ [1:length(xs)-1]' , [2:length(xs)]' ];
icone_f= [ [1:length(xf)-1]' , [2:length(xf)]' ];

u_s= 0.01*cos( 2*pi.*xs) ;
p_f= 0.01*cos( 2*pi.*xf) ;

state_s = [ [1:length(xs)]' , u_s' ];
state_f = [ [1:length(xf)]' , ones(length(xf),1)*(-1)  ];

## Fin de test de Boer.

DIR = make_absolute_filename("mallas.m") ;
save( strcat(DIR,"at") );

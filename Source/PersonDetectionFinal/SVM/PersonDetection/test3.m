styles = {'r','b','k','m','g','r--', 'b--', 'k--','m--','g--'};
x= 1:1:100 ;
y1 = cos(x) ; 
y2 =sin(x) ; 
y3 = x.^2 ; 
y4 = sqrt(x) ; 
y5 = x.^3 ; 
figure  ; 

plot(x,y1,'color', [1 0.7 0.7]) ; 
hold on ; 
plot(x,y2,'color', [0.7 1 0.7]) ; 
hold on ; 
plot(x,y3,'color', [0.7 0.7 1]) ; 
hold on ; 
plot(x,y4,'color', [1 0.7 1]) ; 
hold on ; 
plot(x,y5,'color', [0.7 0.7 0.7]) ; 
hold on ; 

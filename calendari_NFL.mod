# PLE calendario NFL

param n >= 0, integer; 
param r >= 0, integer;
param s >= 0, integer;
param J = r*((n/2)-1)+s*n/2, integer;

set EQUIPOS:= 1..n; 
set JORNADAS:=1..J;

set PARTIDOS_INTRA_DA = {(i, j) in {1..n/2, 1..n/2}: i < j};
set PARTIDOS_INTRA_DB = {(i, j) in {n/2 + 1..n, n/2 + 1..n}: i < j};
set PARTIDOS_INTER = {(i,j) in {1..n/2, n/2 + 1..n}};

var x{(i, j, k) in {EQUIPOS, EQUIPOS, JORNADAS}}, binary;

# Función objetivo
maximize total:
sum {(i, j, k) in {EQUIPOS, EQUIPOS, JORNADAS}: i != j and k >= 2}
if ((i, j) in PARTIDOS_INTRA_DA) or ((i, j) in PARTIDOS_INTRA_DB)
    then x[i,j,k]*(2^(k-2)); 

# Restricciones 

# 1) Partidos a jugar. 
# 1.1) Cada equipo de la división A debe jugar r partidos contra cada equipo de su división.
subject to res_partidos_DA{(i, j) in PARTIDOS_INTRA_DA}:
sum {k in JORNADAS} (x[i, j, k]) = r;

# 1.2) Cada equipo de la división B debe jugar r partidos contra cada equipo de su división.
subject to res_partidos_DB{(i, j) in PARTIDOS_INTRA_DB}:
sum {k in JORNADAS} (x[i, j, k]) = r;
  
# 1.3) Cada equipo debe jugar s partidos contra cada equipo de la otra división. 
subject to res_partidos_inter{(i, j) in PARTIDOS_INTER}:
sum {k in JORNADAS} (x[i, j, k]) = s;
   
# 2) Cada equipo i juega un único partido cada jornada k.  
subject to res_unico_partido{(i, k) in {EQUIPOS, JORNADAS}}:
sum {j in EQUIPOS: j != i} (x[i, j, k]) = 1;
 
# 3) Para cada jornada k, el partido (i,j) es el mismo que el partido (j,i)
subject to res_orden{(i, j, k) in {EQUIPOS, EQUIPOS, JORNADAS}: j!= i}:
x[i, j, k] = x[j, i, k];
 

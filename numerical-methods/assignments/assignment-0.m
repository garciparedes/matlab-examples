% Sergio García Prado

% Matriz de datos
B = [1, 2, 3; 2, 4, 5; 3, 7, 8];

% Objtenemos la matriz de autovectores y la diagonal de autovalores
[V, D] = eig(B)

E = diag(D)

% Demostraci�n del primer autovalor
B * V(:,1)
E(1) * V(:,1)

% Vemos que es el mismo vector

B * V(:,1) == E(1) * V(:,1)

% Demostraci�n de que los 3 autovalores son autovalores de B
B * V == D * V

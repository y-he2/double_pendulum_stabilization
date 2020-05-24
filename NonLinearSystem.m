M = 100;
M1 = 10;
M2 = 10;
L1 = 2;
L2 = 1;
g = 10;

x0 = [0 3.14/2 0 0 0 0 0]';
tval = [0 10];

display( 'ode45 started...' );
[ t, xt ] = ode45( @f, tval, x0, odeset('RelTol', 1e-2) );
display( 'ode45 finished...' );

x = xt(:, 1:6)';
screenDim = [ 200 100 1000 500 ];
fig = figure( 'Name', 'Transient States', 'position', screenDim );
subplot( 1, 2, 1 );
plot( t, x )
title( sprintf('State Transients') );

y = [ x(1,:); 
	x(1,:) + L1*sin(x(2,:)); 
	x(1,:) + L1*sin(x(2,:)) + L2*sin(x(2,:) + x(3,:)) ];

%comet( t,y );
subplot( 1, 2, 2 );
plot( t,t,t,y );
title( sprintf('Output Transients') );

PendulumMovie( M, M1, M2, L1, L2, x, y, false )
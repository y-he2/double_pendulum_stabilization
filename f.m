function [ xdot ] = f( t, x )
	%x1 = x(1);
	x2 = x(2);
	x3 = x(3);
	x4 = x(4);
	x5 = x(5);
	x6 = x(6);
	u = x(7);
	
	% Used to compute the static feedback.
% 	A_lin = ...
% 		[ [0, 0, 0, 1, 0, 0];
% 		[0, 0, 0, 0, 1, 0];
% 		[0, 0, 0, 0, 0, 1]; 
% 		[0, -(5/2), -(1/2), 0, 0, 0];
% 		[0, 35/4, -(9/4), 0, 0, 0];
% 		[0, -5, 15, 0, 0, 0] ];
% 	B_lin = [0 0 0 1/100 -(1/200) 0 ]';
% 	po_lin = [ -1 -1.1 -1.2 -1.3 -1.4 -1.5 ];
% 	F = -place( A_lin, B_lin, po_lin );
	% u = F*x(1:6);	% Comment out to disable static input stab.
	u = 1000*(2*(rand > 0.5) - 1);
	
	% The nonlinear system, computed by solve out dx4,5,6.
	A_nonlin_inv = ...
		[ [120, 40*cos(x2), 10*cos(x2 + x3)];
		[40*cos(x2), 80, 20*cos(x3)];
		[10*cos(x2 + x3), 20*cos(x3), 10] ];
	rhs_nonlin = [ 40*x5^2*sin(x2) + 10*x5*x6*sin(x2 + x3) + 10*x6^2*sin(x2 + x3) + u;
			400*sin(x2) + 20*x6^2*sin(x3) + 100*sin(x2 + x3) - 10*x4*x6*sin(x2 + x3);
			100*sin(x2 + x3) + 10*x4*x5*sin(x2 + x3) ];
		
	xdot = [ x4; x5; x6; A_nonlin_inv\rhs_nonlin; 0 ];
end
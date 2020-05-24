function PendulumMovie( M, M1, M2, L1, L2, x, y, followCart )
	% Test variables.
	%L1 = 2;
	%L2 = 3;
	%M = 20;
	%M1 = 10;
	%M2 = 5;
	%y = 3*rand( 3, 200 );

	screenDim = [ 200 100 800 800 ];
	frames = size( y, 2 ); % The total time steps is the frame count in the movie.
	movie_repeat = 200;
	display( 'Rendering starts...' );
	% For each of 4 modes, plot the dispositioned towers
	Frm(frames) = struct('cdata',[],'colormap',[]);
	fig_rend = figure( 'Name', 'Rendering Frame', 'position', screenDim );

	for t = 1 : frames
		figure( fig_rend );
		clf;

		if mod( t, 10 ) == 0
			fprintf( 'Rendering frame: %d of %d...\n', t, frames );
		end

		dy1 = y(2,t) - y(1,t);
		dy2 = y(3,t) - y(2,t);
		%l1 = sqrt(abs(L1^2 - abs(dy1)^2));
		% Only need x2 = theta1, x3 = theta2,
		l1 = cos( x(2,t) )*L1;
		%l2 = l1 + sqrt(abs(L2^2 - abs(dy2)^2));
		l2 = l1 + cos( x(2,t) + x(3,t) )*L2;
		p = [ [y(1,t), 0];
			  [y(2,t), l1];
			  [y(3,t), l2] ];

		if followCart 
			axis( [y(1,t) - 4, y(1,t) + 4, -4, 4] ); % View follows pendulum.
		else
			axis( [-8 8 -8 8] );
		end
		
		hline = refline( 0, 0 );
		hline.Color = 'black';
		%axis( [p(1,1) - 5, p(1,1) + 5, 0, 10] );
		%rectangle( 'Position', [p(1,:) - sqrt( M )/10, 2*sqrt( M )/10, 2*sqrt( M )/10] );
		%drawCircle( p(2,:), M1 );
		%drawCircle( p(3,:), M2 );
		halfdiag = sqrt( M )/40;
		rectangle( 'Position', [p(1,:) - halfdiag, 2*halfdiag, 2*halfdiag] );
		drawCircle( p(2,:), M1 );
		drawCircle( p(3,:), M2 );
		line( p(:,1), p(:,2) );
		
		title( sprintf('Pendulum Simulation Animation frame = %d', t) );

		Frm( t ) = getframe( fig_rend );
	end
	display( 'Rendering finished...' );

	display( 'Write movie started...' );
	fig_sim = figure( 'Name', 'Simulation Frame', 'position', screenDim );
	% resize figure based on frame's w x h, and place at (100, 100)
	%axis off 
	movie( fig_sim, Frm, movie_repeat);
	
	vw = VideoWriter('pendulum.avi', 'Motion JPEG AVI');
	open(vw);
	writeVideo( vw, Frm );
	close(vw);
	
	display( 'Write movie finished...' );
end
function drawCircle( center, mass )
	radius = sqrt( mass )/40;
    rectangle( 'Position', [center - radius, 2*radius, 2*radius], 'Curvature', [1 1] );
end


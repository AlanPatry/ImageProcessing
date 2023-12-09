function [x_p,y_p] = draw_polygon(hfig) 

	figure(hfig); 
	hold on

	max_points = 100;

	polygon_coordinates = NaN*ones(max_points,2);
	for i = 1:max_points
		[x_p_i,y_p_i] = ginput(1); 
		if(length(x_p_i)==0)
			polygon_coordinates = polygon_coordinates(1:i-1,:);
			line([polygon_coordinates(end,1) polygon_coordinates(1,1)],[polygon_coordinates(end,2) polygon_coordinates(1,2)],'Color','r','LineWidth',2)
			break
		else
			polygon_coordinates(i,1) = x_p_i;
			polygon_coordinates(i,2) = y_p_i;
			plot(polygon_coordinates(i,1), polygon_coordinates(i,2), '*r','Markersize',4);
		end
		if(i>1)
			line([polygon_coordinates(i-1,1) polygon_coordinates(i,1)],[polygon_coordinates(i-1,2) polygon_coordinates(i,2)],'Color','r','LineWidth',2)
		end
	end
	hold off
	
	x_p = polygon_coordinates(:,1);
	y_p = polygon_coordinates(:,2);
	

end

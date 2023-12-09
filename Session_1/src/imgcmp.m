function [similarity] = imgcmp(I1,I2)
% INPUTS
%    I1 (nr x nc): double-precision image
%    I2 (nr x nc): double-precision image
% OUTPUTS
%    similarity (1): similarity between I1 and I2 in percent
    if size(I1) ~= size(I2)
        print("Image are not the same size")
        return;
    end
    sum = 0;
	for i = 1:size(I1,1)
        for j = 1:size(I1,2)
            if I1(i,j) == I2(i,j)
                sum = sum + 1;
            end
        end
    end
	similarity = sum / (size(I1,2)*size(I1,1));
	
end

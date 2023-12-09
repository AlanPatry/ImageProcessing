function contour_elements = contour_matrix_elements(matrix)
    
    contour_elements = matrix;

    contour_elements(2:end-1, 2:end-1) = 0;
    
    contour_elements = find(contour_elements>0);

end
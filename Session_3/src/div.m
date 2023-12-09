function divergence = div(g_x,g_y,Dx,Dy)
    divergence = - Dx' * g_x(:) - Dy' * g_y(:);
end
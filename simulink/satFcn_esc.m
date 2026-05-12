function sat = satFcn_esc(X, xmin, xmax)

    x1 = X(1,1) ;
    
    if x1 <= xmin
        x1 = xmin ;
    elseif x1 >= xmax 
        x1 = xmax;
    else 
        x1 = x1 ;
    end

    sat = x1 ;    

end
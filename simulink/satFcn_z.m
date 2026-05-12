function satZ = satFcn_z(X, xmin, xmax)
    
    if X <= xmin
        X = xmin ;
    elseif X >= xmax 
        X = xmax;
    else 
        X = X ;
    end

    satZ = X ;    

end
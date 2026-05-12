function satX = satFcn_xy(X, xmin, xmax)

    x1 = X(1,1) ;
    x2 = X(2,1) ;
    
    if x1 <= xmin
        x1 = xmin ;
    elseif x1 >= xmax 
        x1 = xmax;
    else 
        x1 = x1 ;
    end
    
    if x2 <= xmin
        x2 = xmin ;
    elseif x2 >= xmax 
        x2 = xmax;
    else 
        x2 = x2 ;
    end

    satX = [x1;x2] ;    

end
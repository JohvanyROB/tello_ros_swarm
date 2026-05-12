function pos_con = fast_con2(ie, e, S, dp_d, C1, C2, alpha1, alpha2, K1)

    u_eq = dp_d + (1/(C2*alpha2))*(abs(e)^(2-alpha2)*(1 + alpha1*C1*abs(ie)^(alpha1-1))*tanh(e/0.008));

    u_sw = K1*tanh(S);  %0.01*S

    pos_con = u_eq + u_sw;

end
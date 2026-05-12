function eul_con = back_ter_yaw_con(e_yaw, s_yaw, sigma, beta, C, ks, ke)

    u_eq = 1/(sigma)*(abs(s_yaw-C*e_yaw)^(2-sigma)*(beta)*sign(s_yaw-C*e_yaw) + e_yaw);

    u_sw = ks*tanh(s_yaw) + ke*s_yaw;

    eul_con = u_eq + u_sw;

end
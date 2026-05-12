function s_yaw = manifold_ter_back_yaw(e_yaw, de_yaw, sigma, beta)

    s_yaw = beta*e_yaw + abs(de_yaw)^sigma*tanh(de_yaw);

end
function S_man = manifold_pos_int(ie, e, C1, C2, alpha1, alpha2)

    S_man = ie + C1*tanh(ie)*abs(ie)^(alpha1) + C2*tanh(e)*abs(e)^(alpha2);

end
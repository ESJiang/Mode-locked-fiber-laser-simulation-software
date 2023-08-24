function a = initinal(t,D_t,Shape_factor,Energy)

    if (Shape_factor == 1)
                T_0 = D_t/1.665;
                P0 = Energy/trapz(t,(exp(-0.5*(t/T_0).^2)).^2);
                a = sqrt(P0)*exp(-0.5*(t/T_0).^2);
    end

    if (Shape_factor == 2)
                T_0 = D_t/1.763;
                P0 = Energy/trapz(t,(sech(t/T_0)).^2);
                a = sqrt(P0)*sech(t/T_0);
    end

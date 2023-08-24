function trans = absorber(at,Md,Ps,A_ns)

trans = 1-Md*exp(-at.*conj(at)/Ps)-A_ns;

end 


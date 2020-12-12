function u0 = InitCond()
   indices();
u0(idx.V) = 0;
u0(idx.w) = 0.1;
u0(idx.Fai) = 0 ;
u0(idx.IP3) =0.2;
u0(idx.Ca) =0.1;
u0(idx.q) =0.2;
u0(idx.f) =0.2;
end
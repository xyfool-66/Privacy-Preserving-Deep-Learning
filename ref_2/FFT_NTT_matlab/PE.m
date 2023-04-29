function [out1, out2] = PE(in1, in2, coff, M)
    out1 = MOD(in1+in2*coff, M);
    out2 = MOD(in1-in2*coff, M);
%     out1 = in1+in2*coff;
%     out2 = in1-in2*coff;

end


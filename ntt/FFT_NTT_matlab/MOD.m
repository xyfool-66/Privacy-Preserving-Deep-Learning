function out = MOD(a,M)
    [size1,size2] = size(a);
    a = mod(a, M);
    for i = 1:size1*size2
        if a(i)>M/2
            a(i) = a(i)-M;
        end
    end
    out = a;
end


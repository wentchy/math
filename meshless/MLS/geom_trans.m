function [Tr] = geom_trans(Ori, matrix)
    Orisz = size(Ori);
    assert(Orisz(2) == 3);
    %assert(size(matrix) == [4, 4]);
    
    Tr = zeros(size(Ori));
    
    n_pnt = Orisz(1);
    
    for n = 1 : n_pnt
        pnt = [Ori(n, :)';1];
        tf_pnt = (matrix * pnt)';
        tf_pnt = tf_pnt(1:3);
        Tr(n, :) = tf_pnt;
    end
    

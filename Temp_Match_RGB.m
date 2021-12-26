function [ S ] = temp_match_rgb( I, R )

[Ir , Ic ] = size(I);
[Rr , Rc ] = size(R);
% distance matrix
 D = zeros(Ir-Rr+1, Ic-Rc+1);
%
% window of search image and sum of squared diffs
for ir = 1:Ir-Rr+1,
    for ic = 1:Ic-Rc+1
        Iw = I((1:Rr)+ir-1, (1:Rc)+ic-1);      
        D(ir,ic) = sum(sum((Iw - R).^2));
    end,
end
 
 
% similarity from distance
 
 
 
%maximun and minimum
 mx= max(D(:));
 mn = min(D(:));

% normalized similarity
 S = 1-(D - mn ) ./ (mx - mn);
 
 


end


function mat = imageToMat(img)
% convert an image with 3 channels to a matrix with the same width & height
% channel mapping: R<<16 + G<<8 + B
%
%  arguments:
%   img             image, 3 channels, output from imread()
%
%  return:
%   mat             matrix from img

[m,n,d] = size(img);
if d~=3
    error('can only handle image with 3 channels per pixel!');
end

mat = zeros(m, n);
for j=1:m
    for i=1:n
        mat(j, i) = bitshift(uint32(img(j, i, 1)), 16) ...
            + bitshift(uint32(img(j, i, 2)), 8) + uint32(img(j, i, 3));
    end
end



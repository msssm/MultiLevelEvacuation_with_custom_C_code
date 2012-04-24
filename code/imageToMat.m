function mat = imageToMat(img)
% convert an image with 3 channels to a uint32 matrix with the same width 
% & height
% channel mapping: R<<16 + G<<8 + B
%
%  arguments:
%   img             image, 3 channels, output from imread()
%
%  return:
%   mat             matrix from img

[~,~,d] = size(img);
if d~=3
    error('can only handle image with 3 channels per pixel!');
end

mat = bitshift(uint32(img(:, :, 1)), 16) ...
    + bitshift(uint32(img(:, :, 2)),  8) ...
    + uint32(img(:, :, 3));

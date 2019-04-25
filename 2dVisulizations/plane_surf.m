function [x, y, z] = plane_surf(Normal, Dist, Size)

center   = (Normal * Dist)'/norm(Normal);
tangents = null(Normal) * Size;

res(1,1,:) = center + tangents * [-1;-1]; 
res(1,2,:) = center + tangents * [-1;1]; 
res(2,2,:) = center + tangents * [1;1]; 
res(2,1,:) = center + tangents * [1;-1];

x = squeeze(res(:,:,1));
y = squeeze(res(:,:,2));
z = squeeze(res(:,:,3));

end
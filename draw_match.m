function draw_match(I, R, pos)

% displays image I and rectanges at found locations pos for reference image R.

[h, w] = size(R);
figure, imshow(I)
for i = 1:size(pos, 1)
	x = pos(i,2); y = pos(i,1);
	rectangle('Position', [x, y, w, h], 'EdgeColor', 'r')
end

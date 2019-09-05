function medianinx = median_index(index)
s = [];
for i = 1:size(index,1)
s(i,1) = index(i).MAD;
end
medianinx = median(s);

end
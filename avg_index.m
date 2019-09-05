function avginx = avg_index(index)
sum = 0;
for i = 1:size(index,1)
sum = sum + index(i).MAD;
end
avginx = sum/size(index,1);

end
for i=(len+1):(100+len)
for j=(len+1):(100+len)
if i==(len+1)||j==(len+1)||i==(len+100)||j==(len+100)
S_expand(i,j,20)=255;
end;
end;
end;
imshow(uint8(S_expand(:,:,20)))
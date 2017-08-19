
 load Sandiego.mat
X=Sandiego;
Y=zeros(400,400);
X=X(:,:,1:199);
for i=1:400
    for j=1:400
        for k=1:199
            Y(i,j)=Y(i,j)+X(i,j,k);
        end;
    end;
 end;
M=Y/199;
max_=max(max(M));
min_=min(min(M));
N=(M-min_)/(max_-min_)*255;
figure;
imshow(floor(uint8(N))),title('main ima');
ima=floor(uint8(N));
S_part=ima(1:100,1:100);
figure;
imshow(S_part);
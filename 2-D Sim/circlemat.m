function D = circlemat(r,imgsz,val)
D = zeros(imgsz);
for i=1:(imgsz/2)
    for j=1:imgsz
        if sqrt((i-(imgsz/2)).^2+(j-(imgsz/2)).^2)<=(r)
            D(i,j) = val;
        end
    end
end
D((imgsz/2+1):imgsz,:) = flipud(D(1:(imgsz/2),:));
end
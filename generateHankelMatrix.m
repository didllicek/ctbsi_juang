function H1 = generateHankelMatrix(Y1,alpha,beta,m,r)
    row=[];
    H1=[[]];
    for j=m:m:(alpha*m)
        for i=1:r:(r*beta)
            row=[row, Y1((j+i):(j+m+i-1),:)];
        end
        H1=[H1;row];
        row=[];
    end
end


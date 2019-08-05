function H1 = generateHankelMatrix(Y1,alpha,beta)
    row=[];
    H1=[[]];
    for j=1:(alpha)
        for i=1:(beta)
            row=[row, Y1(i+j,:)];
        end
        H1=[H1;row];
        row=[];
    end
end


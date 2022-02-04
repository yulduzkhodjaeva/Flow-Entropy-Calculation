Atable = readtable('A_UNB_mal.csv');
A = strings(size(Atable));
A(:,1:2) = table2array(Atable(:,1:2));
A(:,6) = table2array(Atable(:,6));
A(:,3:5) = table2array(Atable(:,3:5));

Ctable = readtable('C_UNB_mal.csv');
C = strings(size(Ctable));
C(:,1:2) = table2array(Ctable(:,1:2));
C(:,6) = table2array(Ctable(:,6));
C(:,3:5) = table2array(Ctable(:,3:5));

%Ctest = C;
%for i = 1:size(C,1)
%    payload = "";
%    currentC = C(i,:);
%    for j = 1:size(A,1)
%        currentA = A(j,:);
%        if(isequal(currentA(1:4),currentC(1:4)) && (currentA(5)>= currentC(5)) && (currentA(5) <= currentC(6)))
%            payload = strcat(payload,"", currentA(6));
%        end
%    end
%    Ctest(i,7) = payload;
%    disp(i)
%end

for i = 1:size(C,1)
    currentC = C(i,:);
    match_cnt = 0;
    logicalIndx = ismember(A(:,1:4), currentC(1:4), 'rows');
    contA = A(logicalIndx,:);
    contA = contA(str2double(currentC(5)) <= str2double(contA(:,5)),:);
    contA = contA(str2double(currentC(6)) >= str2double(contA(:,5)),:);
    % C(i,9) = number of packets merged
    % C(i,9) = size(contA,1); % how many packets do we merge
    % C(i,7) = all packets merged into one cell
    % C(i,7) = join(contA(:,6), "");
    % C(i,10) = number of packets equal to six
    %if size(contA,1) > 6
    %    C(i,10) = join(contA(1:6,6),"");
    %else
    %    C(i,10) = join(contA(:,6),"");
    %end
    
    %if size(contA,1) > 5
    %    C(i,11) = join(contA(1:5,6),"");
    %else
    %    C(i,11) = join(contA(:,6),"");
    %end
    
    if size(contA,1) > 4
        C(i,7) = join(contA(1:4,6),"");
    else
        C(i,7) = join(contA(:,6),"");
    end
    disp(i)
end
clear i;
clear currentC;
clear logicalIndx;
clear contA;

for i = 1:1134
   temp_payload = convertStringsToChars(C(i,7));
   H = ComputeEntropy(temp_payload);
   C(i,8) = H;
   % n = 6
   %temp_payload = convertStringsToChars(C(i,10));
   %H = ComputeEntropy(temp_payload);
   %C(i,13) = H;
   % n = 5
   %temp_payload = convertStringsToChars(C(i,11));
   %H = ComputeEntropy(temp_payload);
   %C(i,14) = H;
   % n = 4
   %temp_payload = convertStringsToChars(C(i,12));
   %H = ComputeEntropy(temp_payload);
   %C(i,15) = H;
end
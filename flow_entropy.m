 fname = 'UNB_malicious_1000.json';
 val = jsondecode(fileread(fname));
% 
 fprintf('json read\n');

 val_size = size(val,1);
 A = strings(val_size,6);

 for i = 1:val_size
     %if isfield(val(i).x_source.layers,'text')==1 && isfield(val(i).x_source.layers,'udp_srcport')==1
     if isfield(val(i).x_source.layers,'tcp_payload')==1
         temp_1 = val(i).x_source.layers.ip_src;
         temp_2 = val(i).x_source.layers.ip_dst;
         temp_3 = val(i).x_source.layers.tcp_srcport;
         %temp_3 = val(i).x_source.layers.udp_srcport;
         temp_4 = val(i).x_source.layers.tcp_dstport;
         %temp_4 = val(i).x_source.layers.udp_dstport;
         temp_5 = val(i).x_source.layers.frame_time_epoch;
         temp = val(i).x_source.layers.tcp_payload; % for TCP packets
         %temp = val(i).x_source.layers.text; % for DNS packets
         temp_6 = convertCharsToStrings(temp{1});
         %if size(temp,1)>2
         %    temp_6 = convertCharsToStrings(temp{3});
         %else
         %    temp_6 = '';
         %end
         A(i,1) = convertCharsToStrings(temp_1{1});
         A(i,2) = convertCharsToStrings(temp_2{1});
         A(i,3) = convertCharsToStrings(temp_3{1});
         A(i,4) = convertCharsToStrings(temp_4{1});
         A(i,5) = convertCharsToStrings(temp_5{1});
         A(i,6) = temp_6;
     end
 end
 
 fprintf('Matrix A loaded\n');
 A(all(cellfun('isempty',A),2),:) = [];

 writematrix(A,'A_UNB_mal.csv');

 B = readtable('UNB_malicious_1000.xlsx');
 B_row = size(B,1);
 
 C = strings(B_row,9); 

for i = 1:B_row
    %temp_1 = B{i,13}; % src_ip - Tranalyzer
    temp_1 = B{i,20}; % src_ip - Argus
    %temp_2 = B{i,17}; % dst_ip
    temp_2 = B{i,21}; % dst_ip - Argus
    %temp_3 = B{i,16}; % src_port
    temp_3 = B{i,23}; % src_port - Argus
    %temp_4 = B{i,20}; % dst_port
    temp_4 = B{i,24}; % dst_port - Argus
    %temp_5 = B{i,4};  % timeFirst
    temp_5 = B{i,3}; %timeFirst - Argus
    %temp_6 = B{i,5};  % timeLast
    temp_6 = B{i,4}; % timeLast - Argus
    
    C(i,1) = convertCharsToStrings(temp_1{1});
    C(i,2) = convertCharsToStrings(temp_2{1});
    C(i,3) = sprintf('%d',temp_3);
    C(i,4) = sprintf('%d',temp_4);
    %C(i,3) = convertCharsToStrings(temp_3{1});
    %C(i,4) = convertCharsToStrings(temp_4{1});
    %C(i,5) = convertCharsToStrings(temp_5{1});
    C(i,5) = convertCharsToStrings(temp_5);
    %C(i,6) = convertCharsToStrings(temp_6{1});
    C(i,6) = convertCharsToStrings(temp_6);
end

writematrix(C,'C_UNB_mal.csv');
fprintf('Matrix C loaded\n');

% calculate entropy
%for i = 1:B_row
%    temp_payload = convertStringsToChars(C(i,7));
%    H = ComputeEntropy(temp_payload);
%    C(i,8) = H;
%end

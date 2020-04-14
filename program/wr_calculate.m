function z = wr_calculate(x, y)
% wr_calculate ��������������
% x, yΪ����ƥ��ȶԵ�����ˮӡ����
% zΪƥ��������

n = numel(x); % ˮӡ�������ֽ���
count = 0; % ��¼ƥ��ɹ�����������λ��
for i = 1 : n
    x_bin = dec2bin(x(i), 8); 
    y_bin = dec2bin(y(i), 8);
    for j = 1 : 8
        if x_bin(j) == y_bin(j)
            count = count + 1;
        end
    end
end
% ���������ʣ�����3λ��Ч����
z = vpa((8 * n - count) / count, 3);
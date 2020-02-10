function y = pre_process(x)
% pre_process ˮӡԤ����ģ�飬��ԭʼˮӡͼ�����
% xΪԭʼˮӡ����
% yΪ����Ԥ������ܺ��ˮӡ����

% ͼ�������������Ƿ���ͬ
% [row, col] = size(x);
% if row > col
%     x = padarray(x, [0, row-col], 'post'); % ������չ�ɷ���
% elseif row < col
%     x = padarray(x, [col-row, 0], 'post'); % ������չ�ɷ���
% end

% ����Arnold�任, ����ͼ������е����ص�
[m, n] = size(x);
y = zeros(m, n);
N = n; % ˮӡͼ����������ɵ������ά��
t = 5; % Arnold�任�ĵ�������
for w = 1 : t
    for u = 1 : m
        for v = 1 : n
            tem = [1, 1; 1, 2] * [u; v];
            u1 = mod(tem(1), N);
            if u1 == 0
                u1 = N;
            end
            v1 = mod(tem(2), N);
            if v1 == 0
                v1 = N;
            end
            y(u1, v1) = x(u, v);
        end
    end
    x = y;
end
y = uint8(y);
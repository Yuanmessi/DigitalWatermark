function y = pre_process(x)
% pre_process ˮӡԤ����ģ�飬��ԭʼˮӡͼ�����
% xΪԭʼˮӡ����
% yΪ����Ԥ������ܺ��ˮӡ����

% �ж�ͼ�������������Ƿ���ͬ������ͬ�������0����ֵ����
[row, col] = size(x);
if row > col
    x = padarray(x, [0, row-col], 'post'); % ������չ�ɷ���
elseif row < col
    x = padarray(x, [col-row, 0], 'post'); % ������չ�ɷ���
end

% ����Arnold�任, ����ͼ������е����ص�
n = size(x, 1); % ˮӡͼ����������ɵ������ά��
y = zeros(n);
t = 5; % Arnold�任�ĵ������������������ﵽ������3/4���ָ�ԭͼ��
for w = 1 : t
    for u = 1 : n
        for v = 1 : n
            tem = [1, 1; 1, 2] * [u; v]; % u,v��������ͼ���е�����
            u1 = mod(tem(1), n);
            if u1 == 0
                u1 = n;
            end
            v1 = mod(tem(2), n);
            if v1 == 0
                v1 = n;
            end
            y(u1, v1) = x(u, v);
        end
    end
    x = y;
end

y = uint8(y);
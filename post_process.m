function y = post_process(x)
% post_process ˮӡ����ģ�飬����ȡ����ˮӡͼ�����
% xΪ��ȡ����ˮӡ����
% yΪ����������ܺ��ˮӡ����

% �ж�ͼ���Ƿ���й����䣨�����...��
% ����Arnold���任
[m, n] = size(x);
y = zeros(m, n);
N = n; % ˮӡͼ����������ɵ������ά��
t = 5; % Arnold���任�ĵ�������
for w = 1 : t
    for u = 1 : m
        for v = 1 : n
            tem = [2, -1; -1, 1] * [u; v];
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
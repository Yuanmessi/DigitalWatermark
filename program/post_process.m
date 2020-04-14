function y = post_process(x)
% post_process ˮӡ����ģ�飬����ȡ����ˮӡͼ�����
% xΪ��ȡ����ˮӡ����
% yΪ����������ܺ��ˮӡ����

% ����Arnold���任
n = size(x, 1); % ˮӡͼ����������ɵ������ά��
y = zeros(n);
t = 5; % Arnold���任�ĵ��������������任��������һ�£�
for w = 1 : t
    for u = 1 : n
        for v = 1 : n
            ten = [2, -1; -1, 1] * [u; v];
            u1 = mod(ten(1), n);
            if u1 == 0
                u1 = n;
            end
            v1 = mod(ten(2), n);
            if v1 == 0
                v1 = n;
            end
            y(u1, v1) = x(u, v);
        end
    end
    x = y;
end

% �ж�ͼ���Ƿ���й����䣬��ȥ����������ֵ
s = all(y == 0, 1); % ����ȫ������Ϣ���ж��Ƿ���й�������
j = 0;
for i = 1 : n
    if s(i) == 1, break, end
    j = i;
end
if j ~= i
    y(:, i:n) = []; % ɾ��������
end
[row, col] = size(y);
if row == col
    s = all(y == 0, 2); % ����ȫ������Ϣ���ж��Ƿ���й�������
    for i = 1 : n
        if s(i) == 1, break, end
        j = i;
    end
    if j ~= i
        y(i:n, :) = []; % ɾ��������
    end
end

y = uint8(y);
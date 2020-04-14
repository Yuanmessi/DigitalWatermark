function w = img_extract(x, y, z)
% img_extract DCT�任������ȡˮӡģ��
% xΪ���ܺ��ˮӡ����
% yΪԭʼ����ͼ������
% zΪ��Ƕ��ˮӡ������ͼ������
% wΪ��ȡ����ˮӡ����

% ��ԭʼ����ͼ�����Ƕ��ˮӡ������ͼ���ϵ��������зֿ�
count = 8; % ÿ���СΪ8*8
[M, N] = size(x);
w = zeros(M, N);
alpha = 0.8; % ˮӡǶ��ǿ�����ӣ�������Ƶ��ϵ�����޸ķ��ȣ��ɵ���
for i = 1 : M
    for j = 1 : N
        block1 = z((i-1)*count+1 : i*count, (j-1)*count+1 : j*count);
        block0 = y((i-1)*count+1 : i*count, (j-1)*count+1 : j*count);
        % �Ե�count����Ƕ��ˮӡ������ͼ��ϵ���������DCT�任
        block1 = dct2(block1);
        % �Ե�count��ԭʼ����ͼ��ϵ���������DCT�任
        block0 = dct2(block0);
        % �Ա�����ϵ��������ȡ��ˮӡ����
        w(i, j) = (block1(count/2, count/2) ...
            - block0(count/2, count/2)) / alpha;
    end
end

w = uint8(w);
function z = img_embeb(x, y)
% img_embeb DCT�任����Ƕ��ˮӡģ��
% xΪ���ܺ��ˮӡ����
% yΪԭʼ����ͼ������
% zΪ��Ƕ��ˮӡ������ͼ������

% ��ԭʼ����ͼ��ϵ��������зֿ�
count = 8; % ÿ���СΪ8*8
alpha = 0.8; % ˮӡǶ��ǿ�����ӣ�������Ƶ��ϵ�����޸ķ��ȣ��ɵ���
z = y;
[M, N] = size(x);
for i = 1 : M
    for j = 1 : N
        block = z((i-1)*count+1 : i*count, (j-1)*count+1 : j*count);
        block = dct2(block); % �Ե�count��ͼ��ϵ���������DCT�任
        % ��ÿ��DCTϵ���������Ƶλ��Ƕ��ˮӡ
        block(count/2, count/2) = block(count/2, count/2) + alpha*x(i, j);
        block = idct2(block); % �Ե�count��ͼ��ϵ���������DCT��任
        z((i-1)*count+1 : i*count, (j-1)*count+1 : j*count) = block;
    end
end
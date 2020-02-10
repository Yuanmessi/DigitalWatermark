function z = img_embeb(x, y)
% img_embeb DCT�任����Ƕ��ˮӡģ��
% xΪ���ܺ��ˮӡ����
% yΪǶ��һ��ˮӡ������ͼ������
% zΪǶ�����ˮӡ������ͼ������

% �ж�����ͼ���Ƿ�Ϊ��ɫͼ��
if ndims(y) == 3
    y = rgb2ycbcr(y); % ת����yCbCr��ɫ�ռ�
    y = y(:, :, 3); % ��ȡY����
end
% ������ͼ����зֿ�
count = 8; % ÿ���СΪ8*8
alpha = 0.8; % ˮӡǶ��ǿ������
z = y;
[M, N] = size(x);
for i = 1 : M
    for j = 1 : N
        block = z((i-1)*count+1 : i*count, (j-1)*count+1 : j*count);
        block = dct2(block); % �Ե�count��ͼ�����DCT�任
        block(count/2, count/2) = block(count/2, count/2) + alpha * x(i, j); % ��ÿ��DCTϵ����(4,5)λ��Ƕ��ˮӡ
        block = idct2(block); % �Ե�count��ͼ�����DCT��任
        z((i-1)*count+1 : i*count, (j-1)*count+1 : j*count) = block;
    end
end
% �ж�����ͼ���Ƿ�Ϊ��ɫͼ��
if ndims(y) == 3
    z = y;
    z(:, :, 3) = z; % ��ͼ������д��Y����
    z = ycbcr2rgb(z); % ת����RGB��ɫ�ռ�
end
z = uint8(z);
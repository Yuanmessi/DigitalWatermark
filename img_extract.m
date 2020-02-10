function w = img_extract(x, y, z)
% img_extract DCT�任������ȡˮӡģ��
% xΪ���ܺ��ˮӡ����
% yΪԭʼ����ͼ������
% zΪǶ�����ˮӡ������ͼ������
% wΪ��ȡ����ˮӡ����

% �жϴ���ȡͼ���Ƿ�Ϊ��ɫͼ��
if ndims(z) == 3
    z = rgb2ycbcr(z); % ת����yCbCr��ɫ�ռ�
    z = z(:, :, 3); % ��ȡY����
    y = rgb2ycbcr(y); % ��ԭʼ����ͼ������ͬ����
    y = y(:, :, 3);   
end

% ������ͼ����зֿ�
count = 8; % ÿ���СΪ8*8
[M, N] = size(x);
w = zeros(M, N);
alpha = 0.8; % ˮӡǶ��ǿ������
for i = 1 : M
    for j = 1 : N
        block1 = z((i-1)*count+1 : i*count, (j-1)*count+1 : j*count);
        block0 = y((i-1)*count+1 : i*count, (j-1)*count+1 : j*count);
        block1 = dct2(block1); % �Ե�count��ͼ�����DCT�任
        block0 = dct2(block0);
        w(i, j) = (block1(count/2, count/2) - block0(count/2, count/2)) / alpha;
    end
end
w = uint8(w);
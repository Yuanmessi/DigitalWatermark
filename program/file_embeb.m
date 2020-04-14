function z = file_embeb(x, y)
% file_embed �ļ���ʽ��Ƕ��ˮӡģ��
% xΪ�Զ�������ʽ��ȡ�ļ��ܺ��ˮӡ����
% yΪ�Զ�������ʽ��ȡ��ԭʼ����ͼ����������
% zΪ��Ƕ��ˮӡ������ͼ��Ķ�������������

len = numel(x); % ˮӡ���г���
% bmpͼ���ļ���С��С��ģʽ���㣩
bfSize = double(bitshift(y(6), 24) + bitshift(y(5), 16) ...
        + bitshift(y(4), 8) + y(3)); 
% ͼ��ɫ�����ʾÿ���������õ�λ��
biBitCount = double(bitshift(y(30), 8) + y(29)); 
if len <= 2^biBitCount
    % ֱ���ڵ�ɫ��Ĳ���λ˳�����len�ֽ�ˮӡ����
    i = 0;
    j = 54; % �ļ�ͷ��14B������Ϣͷ��40B������λ��
    z = y;
    while i <= len
        i = i + 1;
        j = j + 4; % ����λΪÿ4���ֽڵ����һ��
        z(j) = x(i);
    end
else
    % ȷ��Ƕ��ˮӡ���ͼ���ļ���С
    bfSize = bfSize + len - 2^biBitCount;
    z = zeros(bfSize, 1);
    colorEnd = 54 + 2^biBitCount * 4; % ��ɫ�����λ��
    z(1 : colorEnd) = y(1 : colorEnd);
    i = 0;
    j = 54;
    % �ڵ�ɫ��Ĳ���λ˳�����2^biBitCount�ֽ�ˮӡ����
    while i <= 2^biBitCount
        i = i + 1;
        j = j + 4;
        z(j) = x(i);
    end
    % �ڵ�ɫ���λͼ����֮��˳�����ʣ��len-2^bitBitCount�ֽ�ˮӡ����
    dataBeg = colorEnd + 1;
    dataEnd = dataBeg + len - 2^biBitCount - 1;
    z(dataBeg : dataEnd) = x(2^biBitCount + 1 : len);
    z(dataEnd + 1 : bfSize) = y(dataBeg : numel(y));
    % �޸��ļ�ͷ�Ĺؼ�ֵ
    for i = 3 : 6 % �ӵ��ֽ�����ȡֵ�޸��ļ���Сֵ
        z(i) = bitshift(bfSize, -8*(i-3));
        z(i) = bitand(z(i), 255);
    end
    % �޸�λͼ���ݵ���ʼ��ַ
    bfOffBits = bitshift(y(14), 24) + bitshift(y(13), 16) ...
        + bitshift(y(12), 8) + y(11);
    bfOffBits = bfOffBits + len - 2^biBitCount;
    for i = 11 : 14
        z(i) = bitshift(bfOffBits, -8*(i-11));
        z(i) = bitand(z(i), 255);
    end
end

z = uint8(z);
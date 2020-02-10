function z = file_embeb(x, y)
% file_embed �ļ���ʽ��Ƕ��ˮӡģ��
% xΪ���ܺ��ˮӡ����
% yΪԭʼ����ͼ�������
% zΪǶ��һ��ˮӡ������ͼ������


% ��ˮӡ���г���
len = numel(x);
bfSize = double(bitshift(y(6), 24) + bitshift(y(5), 16) + bitshift(y(4), 8) + y(3));
% ͨ��ͼ��ɫ���ж�ͼ������
biBitCount = double(bitshift(y(30), 8) + y(29));
if biBitCount == 1 || biBitCount == 4 || biBitCount == 8 || biBitCount == 16 % ��ɫ��ͼ��
    if len <= 2^biBitCount
        % �ڵ�ɫ��Ĳ���λ˳�����len�ֽ�ˮӡ����
        i = 1;
        j = 58;
        z = y;
        while i <= len
            z(j) = x(i); % ����λΪÿ4���ֽڵ����һ��
            i = i + 1;
            j = j + 4;
        end
    else
        bfSize = bfSize + len - 2^biBitCount; % ȷ��Ƕ��ˮӡ���ͼ���ļ���С
        z = zeros(bfSize, 1);
        colorEnd = 54 + 2^biBitCount * 4; % ��ɫ�����λ��
        z(1 : colorEnd) = y(1 : colorEnd);
        i = 1;
        j = 58; % ����λΪÿ4���ֽڵ����һ��
        % �ڵ�ɫ��Ĳ���λ˳�����2^biBitCount�ֽ�ˮӡ����
        while i <= 2^biBitCount
            z(j) = x(i);
            i = i + 1;
            j = j + 4;
        end
        % �ڵ�ɫ���ͼ������֮��˳�����ʣ��len-2^bitBitCount�ֽ�ˮӡ����
        dataBeg = colorEnd + 1;
        dataEnd = dataBeg + len - 2^biBitCount - 1;
        z(dataBeg : dataEnd) = x(2^biBitCount + 1 : len);
        z(dataEnd + 1 : bfSize) = y(dataBeg : numel(y));
        % �޸��ļ�ͷ�Ĺؼ�ֵ
        for i = 3 : 6 % �޸��ļ���С
            z(i) = bitshift(bfSize, -8*(i-3));
            z(i) = bitand(z(i), 255);
        end
         % �޸�ͼ�����ݵ���ʼ��ַ
        bfOffBits = bitshift(y(14), 24) + bitshift(y(13), 16) + bitshift(y(12), 8) + y(11);
        bfOffBits = bfOffBits + len - 2^biBitCount;
        for i = 11 : 14
            z(i) = bitshift(bfOffBits, -8*(i-11));
            z(i) = bitand(z(i), 255);
        end
    end
elseif biBitCount == 24 || biBitCount == 32 % ���ɫͼ��
    bfSize = bfSize + len;
    z = zeros(bfSize, 1);
    z(1 : 54) = y(1 : 54);
    % �ڵ�ɫ���ͼ������֮��˳�����lenλˮӡ����
    dataBeg = 55;
    dataEnd = dataBeg + len - 1;
    z(dataBeg : dataEnd) = x(1 : len);
    z(dataEnd + 1, bfSize) = y(dataBeg : numel(y));
    % �޸��ļ�ͷ�Ĺؼ�ֵ
    for i = 3 : 6
        z(i) = bitshift(bfSize, -8*(i-3));
        z(i) = bitand(z(i), 255);
    end
    bfOffBits = bitshift(y(14), 24) + bitshift(y(13), 16) + bitshift(y(12), 8) + y(11);
    bfOffBits = bfOffBits + len;
    for i = 11 : 14
        z(i) = bitshift(bfOffBits, -8*(i-11));
        z(i) = bitand(z(i), 255);
    end
end
z = uint8(z);
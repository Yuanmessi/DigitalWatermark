function z = file_extract(x, y)
% file_extract �ļ���ʽ����ȡˮӡģ��
% xΪ�Զ�������ʽ��ȡ�ļ��ܺ��ˮӡ����
% yΪ�Զ�������ʽ��ȡ����Ƕ��ˮӡ������ͼ����������
% zΪ��ȡ���Ķ�������ʽ��ˮӡ����

len = numel(x); % ��Ҫ��ȡ��ˮӡ���г���
z = zeros(len, 1);
% ͼ��ɫ�����ʾÿ���������õ�λ��
biBitCount = double(bitshift(y(30), 8) + y(29));
if len <= 2^biBitCount
    % �ڵ�ɫ�岹��λ˳����ȡlen�ֽ�ˮӡ����
    i = 0;
    j = 54;
    while i <= len
        i = i + 1;
        j = j + 4;
        z(i) = y(j);
    end
else
    % �ڵ�ɫ�岹��λ˳����ȡ2^biBitCount�ֽ�ˮӡ����
    i = 0;
    j = 54;
    while i <= 2^biBitCount
        i = i + 1;
        j = j + 4;
        z(i) = y(j);
    end
    % �ڵ�ɫ���˳����ȡ����len - 2^biBitCount�ֽ�ˮӡ����
    dataBeg = 55 + 2^biBitCount * 4;
    dataEnd = dataBeg + len - 2^biBitCount - 1;
    z(2^biBitCount + 1 : len) = y(dataBeg : dataEnd);
end

z = uint8(z);
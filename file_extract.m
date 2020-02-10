function z = file_extract(x, y)
% file_extract �ļ���ʽ����ȡˮӡģ��
% xΪ�Զ�������ʽ��ȡ�ļ��ܺ��ˮӡ����
% yΪ�Զ�������ʽ��ȡ��ԭʼ����ͼ������
% zΪ��ȡ����ˮӡ����

len = numel(x); % ��Ҫ��ȡ��ˮӡ���г���
z = zeros(len, 1);
% ͨ��ͼ��ɫ���ж�ͼ������
biBitCount = double(bitshift(y(30), 8) + y(29));
if biBitCount == 1 || biBitCount == 4 || biBitCount == 8 || biBitCount == 16 % ��ɫ��ͼ��
    if len <= 2^biBitCount
        % �ڵ�ɫ�岹��λ˳����ȡlen�ֽ�ˮӡ����
       i = 1;
       j = 58;
       while i <= len
           z(i) = y(j);
           i = i + 1;
           j = j + 4;
       end
    else
        % �ڵ�ɫ�岹��λ˳����ȡ2^biBitCount�ֽ�ˮӡ����
        i = 1;
        j = 58;
        while i <= 2^biBitCount
            z(i) = y(j);
            i = i + 1;
            j = j + 4;
        end
        % �ڵ�ɫ���˳����ȡ����len - 2^biBitCount�ֽ�ˮӡ����
        dataBeg = 55 + 2^biBitCount * 4;
        dataEnd = dataBeg + len - 2^biBitCount - 1;
        z(2^biBitCount + 1 : len) = y(dataBeg : dataEnd);
    end
elseif biBitCount == 24 || biBitCount == 32 % ���ɫͼ��
    % ���ļ���Ϣͷ֮��˳����ȡlen�ֽ�ˮӡ����
    dataBeg = 55;
    dataEnd = dataBeg + len - 1;
    z(1 : len) = y(dataBeg : dataEnd); 
end
z = uint8(z);
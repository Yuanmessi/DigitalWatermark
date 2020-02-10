function digital_watermark()
clear;
% ��ȡԭʼˮӡͼ������
[file, path] = uigetfile('*.bmp', '��ԭʼˮӡͼ��');
if isequal(file, 0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path, file)]);
end
wmdata = imread(file);
% ��ʾԭʼˮӡͼ��
subplot(3, 3, 1);
imshow(file);
title('ԭʼˮӡͼ��');

% ˮӡԤ�������
wmdata_pre = pre_process(wmdata);
% �õ����ܺ��ˮӡͼ��
file = 'encode_wm.bmp';
imwrite(wmdata_pre, file, 'bmp');
% ��ʾ���ܺ��ˮӡͼ��
subplot(3, 3, 2);
imshow(file);
title('���ܺ��ˮӡͼ��');
% �Զ����Ʒ�ʽ��ȡ���ܺ��ˮӡ����
fileID = -1;
errmsg = '';
while fileID < 0
   disp(errmsg);
   [fileID, errmsg] = fopen(file, 'rb');
end
wmdata_bin = fread(fileID);
fclose(fileID);

% ��ȡ����ͼ������
[file, path] = uigetfile('*.bmp', '������ͼ��');
if isequal(file, 0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path, file)]);
end
data = imread(file);
% ��ʾԭʼ����ͼ��
subplot(3, 3, 3);
imshow(file);
title('ԭʼ����ͼ��');
% �Զ�������ʽ��ȡ����ͼ���ļ�
fileID = -1;
errmsg = '';
while fileID < 0
   disp(errmsg);
   [fileID, errmsg] = fopen(file, 'rb');
end
data_bin = fread(fileID);
fclose(fileID);

% �ļ���ʽ��
[psnr, wr] = file_wm(wmdata_bin, data_bin, data, wmdata);
fprintf('�ļ���ʽ��PSNR: %.3f\n', psnr);
fprintf('�ļ���ʽ��WR: %.3f\n', wr);
% ��ʾǶ��ˮӡ������ͼ��
file = 'embed_wm1.bmp';
subplot(3, 3, 4);
imshow(file);
title('�ļ���ʽ��Ƕ��ˮӡ������ͼ��');
% ��ʾ��ȡ����ˮӡͼ��
file = 'watermark1.bmp';
subplot(3, 3, 5);
imshow(file);
title('�ļ���ʽ����ȡ����ˮӡͼ��');
% ��ʾ���ܺ��ˮӡͼ��
file = 'decode_wm1.bmp';
subplot(3, 3, 6);
imshow(file);
title('�ļ���ʽ����ȡ����ˮӡ���ܺ�ͼ��');

% DCT��������
[psnr, wr] = img_wm(wmdata_pre, data, wmdata);
fprintf('DCT�任����PSNR: %.3f\n', psnr);
fprintf('DCT�任����WR: %.3f\n', wr);
% ��ʾǶ��ˮӡ������ͼ��
file = 'embed_wm2.bmp';
subplot(3, 3, 7);
imshow(file);
title('DCT��������Ƕ��ˮӡ������ͼ��');
% ��ʾ��ȡ����ˮӡͼ��
file = 'watermark2.bmp';
subplot(3, 3, 8);
imshow(file);
title('DCT�任������ȡ����ˮӡͼ��');
% ��ʾ���ܺ��ˮӡͼ��
file = 'decode_wm2.bmp';
subplot(3, 3, 9);
imshow(file);
title('DCT�任������ȡ����ˮӡ���ܺ�ͼ��');

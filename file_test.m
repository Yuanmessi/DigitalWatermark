function file_test()
% �ļ���ʽ��ˮӡ³���Բ���
% data_attackΪ�����������ͼ������
disp('---�ļ���ʽ��ˮӡ³���Բ���---');
clear;

file = 'embed_wm1.bmp';
data_test = imread(file); % �����Ե�����ͼ������
% �Զ����Ʒ�ʽ��ȡ���ܺ��ˮӡ����
file = 'encode_wm.bmp';
fileID = -1;
errmsg = '';
while fileID < 0
   disp(errmsg);
   [fileID, errmsg] = fopen(file, 'rb');
end
wmdata_bin = fread(fileID);
fclose(fileID);

% ��ȡԭʼ����ͼ������
[file, path] = uigetfile('*.bmp', '��ԭʼ����ͼ��');
if isequal(file, 0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path, file)]);
end
data = imread(file);
% ��ʾԭʼ����ͼ��
subplot(1, 3, 1);
imshow(file);
title('ԭʼ����ͼ��');

% % ��ȡԭʼˮӡ����
% [file, path] = uigetfile('*.bmp', '������ͼ��');
% if isequal(file, 0)
%    disp('User selected Cancel');
% else
%    disp(['User selected ', fullfile(path, file)]);
% end
% % ��ʾԭʼˮӡͼ��
% subplot(2, 3, 4);
% imshow(file);
% title('ԭʼˮӡͼ��');

% ��ֵ�˲�����
data_attack = medfilt2(data_test);
% ��ʾ�����������ͼ��
file = 'medfilt_file.bmp';
imwrite(data_attack, file, 'bmp');
subplot(1, 3, 2);
imshow(file);
title('��ֵ�˲������������ͼ��');
% �Զ����Ʒ�ʽ��ȡ�����������ͼ������
fileID = -1;
errmsg = '';
while fileID < 0
   disp(errmsg);
   [fileID, errmsg] = fopen(file, 'rb');
end
data_bin = fread(fileID);
fclose(fileID);
% �����ֵ�����
PSNR = psnr(data_attack, data);
fprintf('��ֵ�˲�������PSNR: %.3f\n', PSNR);
% ��ȡˮӡ
wmdata_bin2 = file_extract(wmdata_bin, data_bin);
file = 'medfilt_file_wm.bmp'; % ��Ч
fileID = fopen(file, 'w');
fwrite(fileID, wmdata_bin2);
fclose(fileID);

% ������������
data_attack = imnoise(data_test, 'salt & pepper', 0.02);
% ��ʾ�����������ͼ��
file = 'noise_file.bmp';
imwrite(data_attack, file, 'bmp');
subplot(1, 3, 3);
imshow(file);
title('�������������������ͼ��');
% �Զ����Ʒ�ʽ��ȡ�����������ͼ������
fileID = -1;
errmsg = '';
while fileID < 0
   disp(errmsg);
   [fileID, errmsg] = fopen(file, 'rb');
end
data_bin = fread(fileID);
fclose(fileID);
% �����ֵ�����
PSNR = psnr(data_attack, data);
fprintf('��������������PSNR: %.3f\n', PSNR);
% ��ȡˮӡ
wmdata_bin2 = file_extract(wmdata_bin, data_bin);
file = 'noise_file_wm.bmp'; % ��Ч
fileID = fopen(file, 'w');
fwrite(fileID, wmdata_bin2);
fclose(fileID);

% ��ת����
% y = imrotate(x, 90);

% �ߴ��С����
% y = imresize(x, 0.5);
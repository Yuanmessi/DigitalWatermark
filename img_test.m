function img_test()
% DCT�任����ˮӡ³���Բ���
% data_attackΪ�����������ͼ������
disp('---DCT�任����ˮӡ³���Բ���---');
clear;

file = 'embed_wm2.bmp';
data_test = imread(file); % �����Ե�����ͼ������

% ��ȡԭʼ����ͼ������
[file, path] = uigetfile('*.bmp', '��ԭʼ����ͼ��');
if isequal(file, 0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path, file)]);
end
data = imread(file);
% ��ʾԭʼ����ͼ��
subplot(2, 3, 1);
imshow(file);
title('ԭʼ����ͼ��');

% ��ȡԭʼˮӡ����
[file, path] = uigetfile('*.bmp', '��ԭʼˮӡͼ��');
if isequal(file, 0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path, file)]);
end
wmdata = imread(file);
% ��ʾԭʼˮӡͼ��
subplot(2, 3, 4);
imshow(file);
title('ԭʼˮӡͼ��');

% ��ֵ�˲�����
data_attack = medfilt2(data_test);
% ��ʾ�����������ͼ��
file = 'medfilt_img.bmp';
imwrite(data_attack, file, 'bmp');
subplot(2, 3, 2);
imshow(file);
title('��ֵ�˲������������ͼ��');
% �����ֵ�����
PSNR = psnr(data_attack, data);
fprintf('��ֵ�˲�������PSNR: %.3f\n', PSNR);
% ��ȡ���ܺ�ˮӡ����
file = 'encode_wm.bmp';
wmdata_pre =imread(file);
% ��ȡ����ԭˮӡ
wmdata_img = img_extract(wmdata_pre, data, data_attack);
wmdata_post = post_process(wmdata_img);
file = 'medfilt_img_wm.bmp';
imwrite(wmdata_post, file, 'bmp');
% ��ʾ��ȡ��ˮӡͼ��
subplot(2, 3, 5);
imshow(file);
title('��ֵ�˲���������ȡ��ˮӡͼ��');
% ��������������
WR = wr_calculate(wmdata, wmdata_post);
fprintf('��ֵ�˲�������WR: %.3f\n', WR);

% ������������
data_attack = imnoise(data_test, 'salt & pepper', 0.02);
% ��ʾ�����������ͼ��
file = 'noise_img.bmp';
imwrite(data_attack, file, 'bmp');
subplot(2, 3, 3);
imshow(file);
title('�������������������ͼ��');
% �����ֵ�����
PSNR = psnr(data_attack, data);
fprintf('��������������PSNR: %.3f\n', PSNR);
% ��ȡ����ԭˮӡ
wmdata_img = img_extract(wmdata_pre, data, data_attack);
wmdata_post = post_process(wmdata_img);
file = 'noise_img_wm.bmp';
imwrite(wmdata_post, file, 'bmp');
% ��ʾ��ȡ��ˮӡͼ��
subplot(2, 3, 6);
imshow(file);
title('����������������ȡ��ˮӡͼ��');
% ��������������
WR = wr_calculate(wmdata, wmdata_post);
fprintf('��������������WR: %.3f\n', WR);

% ��ת����
% y = imrotate(x, 90);

% �ߴ��С����
% y = imresize(x, 0.5);
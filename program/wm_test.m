function wm_test()
% ˮӡ�ӽ��ܲ���ģ��

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
subplot(1, 3, 1);
imshow(file);
title('ԭʼˮӡͼ��');

% ˮӡԤ�������
wmdata_pre = pre_process(wmdata);
% ��ʾ���ܺ��ˮӡͼ��
subplot(1, 3, 2);
imshow(wmdata_pre);
title('���ܺ��ˮӡͼ��');

% ��ˮӡ���к������
wmdata_post = post_process(wmdata_pre);
% ��ʾ���ܺ��ˮӡͼ��
subplot(1, 3, 3);
imshow(wmdata_post);
title('���ܺ��ˮӡͼ��');
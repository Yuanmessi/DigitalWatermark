function  [PSNR, WR] = file_wm(wmdata_bin, data_bin, data, wmdata)
% file_wm �ļ���ʽ��
% wmdata_bin �Զ�������ʽ��ȡ�ļ��ܺ��ˮӡ����
% data_bin �Զ�������ʽ��ȡ��ԭʼ����ͼ����������
% wmdata ԭʼˮӡͼ������
% data ԭʼ����ͼ������
% PSNR ��ֵ�����
% WR ����������

% Ƕ��ˮӡ
data_bin1 = file_embeb(wmdata_bin, data_bin);
% �õ�Ƕ��ˮӡ������ͼ��
file = 'embed_wm1.bmp';
fileID = fopen(file, 'w');
fwrite(fileID, data_bin1);
fclose(fileID);
data_file = imread(file); % ��ȡǶ��ˮӡ������ͼ������

% ��ȡˮӡ
wmdata_bin2 = file_extract(wmdata_bin, data_bin1);
% �õ���ȡ����ˮӡͼ��
file = 'watermark1.bmp';
fileID = fopen(file, 'w');
fwrite(fileID, wmdata_bin2);
fclose(fileID);

% ��ȡ��ȡ��ˮӡͼ������
wmdata_file = imread(file);
% ����ȡ����ˮӡ���к������
wmdata_post = post_process(wmdata_file);
% �õ����ܺ��ˮӡͼ��
file = 'decode_wm1.bmp';
imwrite(wmdata_post, file, 'bmp');

% ˮӡ���ɼ��Բ���
% �����ֵ�����
PSNR = psnr(data_file, data);
% ��������������
WR = wr_calculate(wmdata, wmdata_post);

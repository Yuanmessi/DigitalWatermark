function  [PSNR, WR] = img_wm(wmdata_pre, data, wmdata)
% img_wm DCT��������
% wmdata_pre ���ܺ��ˮӡ����
% data ԭʼͼ������
% wmdata ԭʼˮӡ����
% PSNR ��ֵ�����
% WR ����������

% Ƕ��ˮӡ
data_img = img_embeb(wmdata_pre, data);
% �õ�Ƕ��ˮӡ��ͼ��
file = 'embed_wm2.bmp';
imwrite(data_img, file, 'bmp');

% ��ȡˮӡ
wmdata_img = img_extract(wmdata_pre, data, data_img);
% �õ���ȡ����ˮӡͼ��
file = 'watermark2.bmp';
imwrite(wmdata_img, file, 'bmp');

% ����ȡ����ˮӡ���к������
wmdata_post = post_process(wmdata_img);
% �õ����ܺ��ˮӡͼ��
file = 'decode_wm2.bmp';
imwrite(wmdata_post, file, 'bmp');

% ˮӡ���ɼ��Բ���
% �����ֵ�����
PSNR = psnr(data, data_img);
% ��������������
WR = wr_calculate(wmdata, wmdata_post);

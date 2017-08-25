%==============================================================
% FileName: get_org_wei.m
% Description: Get original gauss weight in 12 gauss integral points
% Author: Changhao Li
% Date created: 18 Jul 2017
% Version: 1.00
% Date last revised: 18 Jul 2017
% Revised by: Changhao Li
%==============================================================
function org_wei = get_org_wei(gauss_filename)
%==============================================================
% input parameter:
% gauss_filename: string, the name of file that contains gauss integral weight information
% output parameter:
% org_wei(12): contains original weight
%==============================================================
org_wei = textread(gauss_filename);
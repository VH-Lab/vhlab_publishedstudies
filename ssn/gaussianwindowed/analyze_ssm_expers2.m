
prefix = '/Volumes/Data1/Ameya/';

dirnames = {'2012-06-27'};
dirnames = {'2012-06-27','2012-07-10','2012-07-24','2012-08-08','2012-08-14','2012-08-23'};

[cells,cellnames] = readcellsfromexperimentlist(prefix,dirnames,1,5);

ssm_param = [];
fft_param = [];

for i=1:length(cells),
	b = ssn_simpleorcomplex(cells{i},cellnames{i});
	if ~isnan(b),
		figure;
		%plot_sharpgauss(cells{i},cellnames{i});
		output = plot_sharpgauss2(cells{i},cellnames{i});
		ssm_param([1 2],end+1,1) = output.ssm_params(:,:,1)';
		ssm_param([1 2],end,2) = output.ssm_params(:,:,2)';
		ssm_param([1 2],end,3) = output.ssm_params(:,:,3)';
		fft_param([1 2],end+1) = output.fft_params';
	end;
end;

figure;
plot(squeeze(ssm_param(1,:,3)).*exp(133*squeeze(ssm_param(1,:,1))),ssm_param(2,:,3).*exp(133*squeeze(ssm_param(2,:,1))),'ko');
A = axis;
hold on
plot([0 0.5],[0 0.5],'k--');
axis(A);
ylabel('Sharp g coefficient');
xlabel('Gauss g coefficient');
box off;

figure;
plot(fft_param(1,:),fft_param(2,:),'ko');
A = axis;
hold on
plot([0 0.5],[0 0.5],'k--');
axis([0 0.25 0 0.25]);
ylabel('Sharp fft average');
xlabel('Gauss fft average');
box off;



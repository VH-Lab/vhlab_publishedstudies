function [DIbglob, DIaglob] = oculartransferDIanalysis(prefix, expernames, traindir)
%refer to unidirectionDIanalysis1.m
prefix = '/users/yeli/documents/Data/minis'; 
expernames = {'2009-12-28'}
traindir = [67.5];


allmycells = {}; allmycellnames = {}; 

for m=1:length(expernames),

	% load cells
	expernames{m},
	ds = dirstruct([prefix filesep expernames{m}]);
	[cells,cellnames]=load2celllist(getexperimentfile(ds),'cell_tp_001*','-mat');
    %	DI_te_pt direction index (DI) for trained eye (te) that orienation (pt) along the training direction
    %   DI_ne_ot direction index (DI)for  non-trained eye (ne) that orienation othogonal (ot) to the training direction 
	DIb_te_pt = [];   DIb_te_ot = []; DIb_ne_pt = [];   DIb_ne_ot = []; DIb_te = []; DIb_ne = [];
    DPb_te_pt = [];   DPb_te_ot = []; DPb_ne_pt = [];   DPb_ne_ot = []; DPb_te = []; DPb_ne = [];
    
    myinds = []; j=0;
 
    for i=1:length(cells),
        dirfi  = findassociate(cells{i},'TP Ach OT Fit Direction index blr','','');
        dirfc = findassociate(cells{i},'TP ME Ach OT Fit Direction index blr','',''); 
        prefdiri  = findassociate(cells{i},'TP Ach OT Fit Pref','','');
        prefdirc = findassociate(cells{i},'TP ME Ach OT Fit Pref','','');
        vpi  = findassociate(cells{i},'TP Ach OT visual response p','',''); 
        vpc = findassociate(cells{i},'TP ME Ach OT visual response p','','');
        %pthreshold_assoc={'TP Ach OT visual response p','TP Ach OT vet varies p'};
       
        if ~isempty(dirfi)& vpi.data<0.05,
            myinds(end+1) = i; j=j+1;
            mydpi = prefdiri.data; 
            DIb_ne(end+1) = dirfi.data; DPb_ne(end+1) = prefdiri.data;
            if angdiffwrap(mydpi-traindir(m),360)<45 | angdiffwrap(mydpi-traindir(m),360)>135, 
                DIb_ne_pt(end+1) = dirfi.data; DPb_ne_pt(end+1) = prefdiri.data;
            else DIb_ne_ot(end+1) = dirfi.data; DPb_ne_ot(end+1) = prefdiri.data; 
            end;            
        end;
        if ~isempty(dirfc)& vpc.data<0.05,
            myinds(end+1) = i; j=j+1;
            mydpc = prefdirc.data;
            DIb_te(end+1) = dirfc.data; DPb_te(end+1) = prefdirc.data;
            if angdiffwrap(mydpc-traindir(m),360)<45 | angdiffwrap(mydpc-traindir(m),360)>135, 
                DIb_te_pt(end+1) = dirfc.data; DPb_te_pt(end+1) = prefdirc.data;
            else DIb_te_ot(end+1) = dirfc.data; DPb_te_ot(end+1) = prefdirc.data; 
            end;
        end;
    end;
    %keyboard;
    [cells,cellnames]=load2celllist(getexperimentfile(ds),'cell_tp_005*','-mat');
    DIa_te_pt = [];   DIa_te_ot = []; DIa_ne_pt = [];   DIa_ne_ot = []; DIa_te = []; DIa_ne = [];
    DPa_te_pt = [];   DPa_te_ot = []; DPa_ne_pt = [];   DPa_ne_ot = []; DPa_te = []; DPa_ne = [];
    myinds = []; j=0;

    for i=1:length(cells),
        dirfi  = findassociate(cells{i},'TP Ach OT Fit Direction index blr','','');
        dirfc = findassociate(cells{i},'TP ME Ach OT Fit Direction index blr','',''); 
        prefdiri  = findassociate(cells{i},'TP Ach OT Fit Pref','','');
        prefdirc = findassociate(cells{i},'TP ME Ach OT Fit Pref','','');
        vpi  = findassociate(cells{i},'TP Ach OT vec varies p','',''); 
        vpc = findassociate(cells{i},'TP ME Ach OT vec varies p','','');
        %pthreshold_assoc={'TP Ach OT visual response p','TP FE Ach OT visual response p'};
       
        if ~isempty(dirfi)& vpi.data<0.05,
            %myinds(end+1) = i; j=j+1;
            mydpi = prefdiri.data; 
            DIa_ne(end+1) = dirfi.data; DPa_ne(end+1) = prefdiri.data;
            if angdiffwrap(mydpi-traindir(m),360)<45 | angdiffwrap(mydpi-traindir(m),360)>135, 
                DIa_ne_pt(end+1) = dirfi.data; DPa_ne_pt(end+1) = prefdiri.data;
            else DIa_ne_ot(end+1) = dirfi.data; DPa_ne_ot(end+1) = prefdiri.data;
            end;            
        end;
        if ~isempty(dirfc)& vpc.data<0.05,
            %myinds(end+1) = i; j=j+1;
            mydpc = prefdirc.data;
            DIa_te(end+1) = dirfc.data; DPa_te(end+1) = prefdirc.data;
            if angdiffwrap(mydpc-traindir(m),360)<45 | angdiffwrap(mydpc-traindir(m),360)>135, 
                DIa_te_pt(end+1) = dirfc.data; DPa_te_pt(end+1) = prefdirc.data;
            else DIa_te_ot(end+1) = dirfc.data; DPa_te_ot(end+1) = prefdirc.data;
            end;
        end;
    end;
%     mycells = cells(myinds);
%     mycellnames = cellnames(myinds);
%     allmycells = cat(2,allmycells,mycells); allmycellnames = cat(1,allmycellnames,mycellnames);
    
%     figure(DSIbafig);
%     subplot(2,length(expernames),m);
%     h1=plot(DItb, DIta, 'or'); hold on;
%     h2=plot(DIrntb,DIrnta,'+r'); axis([0 1 -1 1]);
%     plot([0 1],[0 1],'k--');hold on;plot([0 1],[0 0],'k--');hold on;plot([0 1],[0 -1],'k--');
%     ylabel('Dir index after'); xlabel('Dir index before'); title ('DirBefore = TrainDir, DirAfter = TrainDir');
%     subplot(2,length(expernames),length(expernames)+m);
%     h1=plot(DIntb, DInta, 'og');  hold on;
%     h2=plot(DIrtb, DIrta, '+g'); axis([0 1 -1 1]);
%     plot([0 1],[0 1],'k--');hold on;plot([0 1],[0 0],'k--');hold on;plot([0 1],[0 -1],'k--');
%     ylabel('Dir index after'); xlabel('Dir index before'); title ('DirBefore = oppTrainDir, DirAfter = oppTrainDir');
%     
%     figure(DSIchangefig);
%     subplot(1,length(expernames),m);
%     h1=plot(DPtb,DIta-DItb, 'ro');hold on; 
%     h2=plot(DPrntb,DIrnta-DIrntb, 'r+'); hold on;
%     h3=plot(DPntb,DInta-DIntb, 'go'); hold on;
%     h4=plot(DPrtb,DIrta-DIrtb, 'g+'); hold on;
%     plot([-45 225],[0 0],'k--');axis([-45 225 -1 0.6]); 
%     ylabel('Dir index change'); xlabel('DPb(\circ)'); title ('Change in DI vs. DirPbefore');
    
    bins = [-Inf 0:0.01:1 Inf];
    xax = 0:0.01:1-0.01 + 0.01/2; 
%     DIb_te_pt = [];   DIb_te_ot = []; DIb_nt_pt = [];   DIb_nt_ot = []; 
%     DIa_te_pt = [];   DIa_te_ot = []; DIa_nt_pt = [];   DIa_nt_ot = []; 
    
    figure;

    subplot(2,2,1);
    plot([-100 100],[50 50],'--k'); hold on;
    Nb = histc(DIb_te_pt, bins); Na = histc(DIa_te_pt, bins);
    CSb = 100*cumsum(Nb) / sum(Nb); CSa = 100*cumsum(Na) / sum(Na);
    plot(xax,CSb(2:end-2),'-.','color',[0.33 0.33 0.33],'linewidth',2); hold on;
    plot(xax,CSa(2:end-2),':','color',[0.66 0.66 0.66],'linewidth',2); 
    xlabel('DI'); ylabel('Percent'); title('trained eye, cells prefer train angle');
    axis ([0 1 0 100]);
    
    subplot(2,2,2);
    plot([-100 100],[50 50],'--k'); hold on;
    Nb = histc(DIb_te_ot, bins); Na = histc(DIa_te_ot, bins);
    CSb = 100*cumsum(Nb) / sum(Nb); CSa = 100*cumsum(Na) / sum(Na);
    plot(xax,CSb(2:end-2),'-.','color',[0.33 0.33 0.33],'linewidth',2); hold on;
    plot(xax,CSa(2:end-2),':','color',[0.66 0.66 0.66],'linewidth',2); 
    xlabel('DI'); ylabel('Percent'); title('trained eye, cells orthogonal train angle');
    axis ([0 1 0 100]);
    
    subplot(2,2,3);
    plot([-100 100],[50 50],'--k'); hold on;
    Nb = histc(DIb_ne_pt, bins); Na = histc(DIa_ne_pt, bins);
    CSb = 100*cumsum(Nb) / sum(Nb); CSa = 100*cumsum(Na) / sum(Na);
    plot(xax,CSb(2:end-2),'-.','color',[0.33 0.33 0.33],'linewidth',2); hold on;
    plot(xax,CSa(2:end-2),':','color',[0.66 0.66 0.66],'linewidth',2); 
    xlabel('DI'); ylabel('Percent'); title('non-trained eye, cells prefer train angle');
    axis ([0 1 0 100]);
    
    subplot(2,2,4);
    plot([-100 100],[50 50],'--k'); hold on;
    Nb1 = histc(DIb_ne_ot, bins); Na1 = histc(DIa_ne_ot, bins);
    CSb1 = 100*cumsum(Nb1) / sum(Nb1); CSa1 = 100*cumsum(Na1) / sum(Na1);
    Nb2 = histc(DIb_te_ot, bins); CSb2 = 100*cumsum(Nb2) / sum(Nb2); CSb = (CSb1+CSb2)/2;
    Na2 = histc(DIa_te_ot, bins); CSa2 = 100*cumsum(Na2) / sum(Na2); CSa = (CSa1+CSa2)/2;
    
    plot(xax,CSb(2:end-2),'-.','color',[0.33 0.33 0.33],'linewidth',2); hold on;
    plot(xax,CSa(2:end-2),':','color',[0.66 0.66 0.66],'linewidth',2); 
    xlabel('DI'); ylabel('Percent'); title('non-trained eye, cells orthogonal train angle');
    axis ([0 1 0 100]);
%     subplot(2,2,2);
%     plot([-100 100],[50 50],'--k'); hold on;
%     Nb = histc([DIntb DIrtb], bins); Na = histc([DInta DIrta], bins);
%     CSb = 100*cumsum(Nb) / sum(Nb); CSa = 100*cumsum(Na) / sum(Na);
%     plot(xax,CSb(2:end-2),'-.','color',[0.33 0.33 0.33],'linewidth',2); hold on;
%     plot(xax,CSa(2:end-2),':','color',[0.66 0.66 0.66],'linewidth',2); 
%     xlabel('DI'); ylabel('Percent'); title('Initial against TrainDir');
%     axis ([0 1 0 100]);
    
%     for J=1:2,
%         subplot(2,1,plotnum(J)); cla; hold off;
%         plot([-100 100],[50 50],'--k'); hold on;
%         for k=1:2,
%             N = histc(mydata{dataI(k),dataJ(J),dataK(2)},bins{J});
%             CS = 100*cumsum(N) / sum(N);
%             plot(xax{J},CS(2:end-2),codes{k},'color',thecolors(k,:),'linewidth',2);
%             xlabel(xlab{J}); ylabel(ylab{J}); title(titles{J});
%         end;
%         axis(ax{J}); 
%     end;  
 keyboard;   
    DIball = [DIball DIb];  DIaall = [DIaall DIa];
    DPballglob = [DPballglob DPbglob]; DPaallglob = [DPaallglob DPaglob];
        
    DItball = [DItball DItb];  DItaall = [DItaall DIta]; DIntball = [DIntball DIntb];  DIntaall = [DIntaall DInta];
    DIrntball = [DIrntball DIrntb]; DIrntaall = [DIrntaall DIrnta]; DIrtball = [DIrtball DIrtb]; DIrtaall = [DIrtaall DIrta]; 
    
    DPtball = [DPtball DPtb];  DPtaall = [DPtaall DPta]; DPntball = [DPntball DPntb];  DPntaall = [DPntaall DPnta];
    DPrntball = [DPrntball DPrntb]; DPrntaall = [DPrntaall DPrnta]; DPrtball = [DPrtball DPrtb]; DPrtaall = [DPrtaall DPrta]; 
    
end;

figure(allDSIbafig);
subplot(2,1,1);
h1=plot(DItball, DItaall, 'or'); hold on;
h2=plot(DIrntball, DIrntaall, '+r'); axis([0 1 -1 1]);
plot([0 1],[0 1],'k--');hold on;plot([0 1],[0 0],'k--');hold on;plot([0 1],[0 -1],'k--');        
ylabel('Dir index after'); xlabel('Dir index before'); title ('DirBefore = TrainDir, DirAfter = TrainDir');
subplot(2,1,2);
h1=plot(DIntball, DIntaall, 'og');  hold on;
h2=plot(DIrtball, DIrtaall, '+g'); axis([0 1 -1 1]);
hold on
plot([0 1],[0 1],'k--');hold on;plot([0 1],[0 0],'k--');hold on;plot([0 1],[0 -1],'k--');
ylabel('Dir index after'); xlabel('Dir index before'); title ('DirBefore = oppTrainDir, DirAfter = oppTrainDir');

figure(allDSIchangefig);
h1=plot(DPtball,DItaall-DItball, 'ro'); hold on; 
h2=plot(DPrntball,DIrntaall-DIrntball, 'r+'); hold on;
h3=plot(DPntball,DIntaall-DIntball, 'go'); hold on;
h4=plot(DPrtball,DIrtaall-DIrtball, 'g+'); hold on;
plot([-45 225],[0 0],'k--');axis([-45 225 -1 0.6]); axis([-45 225 -1 0.6]); 
ylabel('Dir index change'); xlabel('DPb(\circ)'); title ('Change in DI vs. DirPbefore');   

figure(allDSIcumfig);
bins = [-Inf -1:0.01:1 Inf];
xax = -1:0.01:1-0.01 + 0.01/2;
subplot(2,1,1);
plot([-100 100],[50 50],'--k'); hold on;
Nb = histc([DItball DIrntball], bins); Na = histc([DItaall DIntaall-0.05], bins);
%Nb = histc(DItball, bins); Na = histc(DItaall, bins);
CSb = 100*cumsum(Nb) / sum(Nb); CSa = 100*cumsum(Na) / sum(Na);
plot(xax,CSb(2:end-2),'-.','color',[0.33 0.33 0.33],'linewidth',2); hold on;
plot(xax,CSa(2:end-2),':','color',[0.66 0.66 0.66],'linewidth',2); 
xlabel('DI'); ylabel('Percent'); title('Initial prefer TrainDir');
axis ([-1 1 0 100]);
subplot(2,1,2);
plot([-100 100],[50 50],'--k'); hold on;
Nb = histc([DIntball DIrtball], bins); Na = histc([DIntaall DIrtaall], bins);
%Nb = histc(DIntball, bins); Na = histc(DIntaall, bins);
CSb = 100*cumsum(Nb) / sum(Nb); CSa = 100*cumsum(Na) / sum(Na);
plot(xax,CSb(2:end-2),'-.','color',[0.33 0.33 0.33],'linewidth',2); hold on;
plot(xax,CSa(2:end-2),':','color',[0.66 0.66 0.66],'linewidth',2); 
xlabel('DI'); ylabel('Percent'); title('Initial against TrainDir');
axis ([-1 1 0 100]);

figure;
plot([-100 100],[50 50],'--k'); hold on;
Nball = histc([DItball DIntball], bins); Nta = histc(DItaall, bins); Nnta = histc(DIntaall, bins);
CSball = 100*cumsum(Nball)*1 / sum(Nball); CSta = 100*cumsum(Nta) / sum(Nta)*1.05; CSnta = 100*cumsum(Nnta) / sum(Nnta);
plot(xax,CSball(2:end-2),'-.','color',[0.33 0.33 0.33],'linewidth',2); hold on;
plot(xax,CSta(2:end-2),':','color',[0.66 0.66 0.66],'linewidth',2); hold on;
plot(xax,CSnta(2:end-2)*1,'-','color',[0 0 0],'linewidth',2); 
xlabel('DI'); ylabel('Percent'); title('Initial prefer TrainDir');
axis ([0 1 0 100]);

figure;
plot([-100 100],[50 50],'--k'); hold on;
Nball = histc([DItball DIntball DIrntball], bins); Nta = histc([DItaall DIntaall], bins); Nnta = histc([DIntaall DIrtaall], bins);
CSball = 100*cumsum(Nball) / sum(Nball); CSta = 100*cumsum(Nta) / sum(Nta); CSnta = 100*cumsum(Nnta) / sum(Nnta);
plot(xax,CSball(2:end-2)*1,'-.','color',[0.33 0.33 0.33],'linewidth',2); hold on;
plot(xax,CSta(2:end-2),':','color',[0.66 0.66 0.66],'linewidth',2); hold on;
plot(xax,CSnta(2:end-2),'-','color',[0 0 0],'linewidth',2); 
xlabel('DI'); ylabel('Percent'); title('Initial prefer TrainDir');
axis ([0 1 0 100]);

figure;
h1=plot(DItball,DItaall-DItball, 'ro'); hold on; 
h2=plot(DIrntball,DIrntaall-DIrntball, 'r+'); hold on;
h3=plot(-DIntball,DIntaall-DIntball, 'go'); hold on;
h4=plot(-DIrtball,DIrtaall-DIrtball, 'g+'); hold on;
%plot([-45 225],[0 0],'k--');axis([-45 225 -1 0.6]); axis([-45 225 -1 0.6]); 
ylabel('Dir index change'); xlabel('DI before'); title ('Change in DI vs. DI before'); 



keyboard;
% figure;
% for i = 1: length(DIa),
%     plot([1,2],[DIb(i),DIa(i)],'-b'); hold on;
%     plot([1,2],[DIb(i),DIa(i)],'o'); hold on;
% end;
% axis([0 3 -1 1]);
% set (gca, 'xticklabel', {'Before','After'})
% set (gca, 'xtick',[1 2])
% ylabel('DSI'); title('UnidirectionMotion training');

% m=0;n=0;
% for k = 1:length(myinds),
%     if abs(traindir-prefb(k))<45, m = m+1; else n = n+1;end;
%     k = k+1;
% end;
% m,n,

figure;
h1=plot(DItball, DItaall, 'or'); hold on;
h2=plot(DIrntball, DIrntaall, 'or');
h3=plot(-DIntball, -DIntaall, 'og');  hold on;
h4=plot(-DIrtball, -DIrtaall, 'og'); axis([-1 1 -1 1]);
hold on
plot([-1 1],[-1 1],'k--');hold on;plot([-1 1],[0 0],'k--');hold on;plot([-1 1],[1 -1],'k--');hold on;plot([0 0],[1 -1],'k--');
ylabel('Dir index after'); xlabel('Dir index before'); title ('DirBefore = oppTrainDir, DirAfter = oppTrainDir');  

function [DIbglob, DIaglob] = oculartransferDIanalysis3(prefix, expernames, traindir)

%  OCULARTRANSFERDIANALYSIS3(PREFIX, EXPERNAMES, TRAINDIR) - Analysis of
%  training effect of ocular transfter experiment, e.g. whether training
%  effect (change in DI) is tranferred to the untrained eye (cumulative histograph of direction selectivity,DI)
%  whether the training effect dependent upon ocular dominace index (ODI), 
%   groups:
%   trained eye, nontrained eye, 
%   cells that prefered the train angle and cells that orthogonal to the trained angle
%  
%  PREFIX, the file path of ocular transfer data is stored, (e.g., 'E:\2photon\ferretdirection\oculartransfer'; 
%
%  expernames, (e.g., {'2010-01-07'}) 
%  
%  traindir, train angle,(e.g., [22.5]), 
%  
%  features to add: should be able to analysize groups of experiments as well as individual experiment
%  see also  unidirectionDIanalysis1.m
%


allmycells = {}; allmycellnames = {}; 
% DSIbafig = figure; 
% DSIchangefig = figure; 
%DSIcumfig = figure;
% allDSIbafig = figure; 
% allDSIchangefig = figure; 
% allDSIcumfig = figure;
% 
% DPballglob = []; DPaallglob = [];
% DIball = []; DIaall = [];  
% DItball  = []; DIntball = [];  DIrtball = []; DIrntball = [];  
% DItaall  = []; DIntaall = []; DIrtaall  = []; DIrntaall = [];
% DPtball  = []; DPntball = [];  DPrtball = []; DPrntball = [];  
% DPtaall  = []; DPntaall = []; DPrtaall  = []; DPrntaall = [];

for m=1:length(expernames),

	% load cells
	expernames{m},
	ds = dirstruct([prefix filesep expernames{m}]);
	[cells,cellnames]=load2celllist(getexperimentfile(ds),'cell*','-mat');
    %	DI_te_pt direction index (DI) for trained eye (te) that orienation (pt) along the training direction
    %   DI_ne_ot direction index (DI)for  non-trained eye (ne) that orienation othogonal (ot) to the training direction 
	DIb_te_pt = [];   DIb_te_ot = []; DIb_ne_pt = [];   DIb_ne_ot = []; DIb_te = []; DIb_ne = [];
    DPb_te_pt = [];   DPb_te_ot = []; DPb_ne_pt = [];   DPb_ne_ot = []; DPb_te = []; DPb_ne = [];
    ODb_pt = [];   ODb_ot = []; 
    DIa_te_pt = [];   DIa_te_ot = []; DIa_ne_pt = [];   DIa_ne_ot = []; DIa_te = []; DIa_ne = [];
    DPa_te_pt = [];   DPa_te_ot = []; DPa_ne_pt = [];   DPa_ne_ot = []; DPa_te = []; DPa_ne = [];
    ODa_pt = [];   ODa_ot = []; 
    
    myinds = []; j=0;
    pthresh_assoc={'visual response p','vec varies p'};
    
    for i=1:length(cells),
        dirfib  = findassociate(cells{i},'TP IPSI Ach OT Fit Direction index blr','','');
        dirfcb = findassociate(cells{i},'TP CONT Ach OT Fit Direction index blr','',''); %TP CONT Ach OT Fit Orientation index blr
        prefdirib  = findassociate(cells{i},'TP IPSI Ach OT Fit Pref','','');
        prefdircb = findassociate(cells{i},'TP CONT Ach OT Fit Pref','','');
        
        vpib  = findassociate(cells{i},['TP IPSI Ach OT ' pthresh_assoc{1}],'',''); 
        vpcb = findassociate(cells{i},['TP CONT Ach OT ' pthresh_assoc{1}],'','');
        dirfia  = findassociate(cells{i},'TP IPSI ME Ach OT Fit Direction index blr','','');
        dirfca = findassociate(cells{i},'TP CONT ME Ach OT Fit Direction index blr','',''); 
        prefdiria  = findassociate(cells{i},'TP IPSI ME Ach OT Fit Pref','','');
        prefdirca = findassociate(cells{i},'TP CONT ME Ach OT Fit Pref','','');
        vpia  = findassociate(cells{i},['TP IPSI ME Ach OT ' pthresh_assoc{1}],'',''); 
        vpca = findassociate(cells{i},['TP CONT ME Ach OT ' pthresh_assoc{1}],'',''); 
                
%        if ~isempty(vpib)& ~isempty(vpcb)& vpcb.data<0.05&~isempty(vpia)& ~isempty(vpca)& vpca.data<0.05, 
        property = {'CONT ','IPSI ','CONT ME ','IPSI ME'};%2010-01-07: 
        [OD,locinds,loc,ODdata] = newferretOD(cells{i}, property);
        if ~isempty(vpib)& vpib.data<0.05 &~isempty(vpcb)& vpcb.data<0.05 &~isempty(vpia)& vpia.data<0.05 &~isempty(vpca)& vpca.data<0.05,
         if 1,%OD(6)>0, 
            myinds(end+1) = i; j=j+1;
            
           
            mydpi = prefdircb.data; 

            if angdiffwrap(mydpi-traindir(m),360)<45 | angdiffwrap(mydpi-traindir(m),360)>135, 
                ODb_pt(end+1) = OD(6);
                DIb_te_pt(end+1) = dirfib.data; DPb_te_pt(end+1) = prefdirib.data;
                DIb_ne_pt(end+1) = dirfcb.data; DPb_ne_pt(end+1) = prefdircb.data;
                DIa_te_pt(end+1) = dirfia.data; DPa_te_pt(end+1) = prefdiria.data;
                DIa_ne_pt(end+1) = dirfca.data; DPa_ne_pt(end+1) = prefdirca.data;
            else ODb_ot(end+1) = OD(6);
                i,
                 DIb_te_ot(end+1) = dirfib.data; DPb_te_ot(end+1) = prefdirib.data;
                 DIb_ne_ot(end+1) = dirfcb.data; DPb_ne_ot(end+1) = prefdircb.data;
                 DIa_te_ot(end+1) = dirfia.data; DPa_te_ot(end+1) = prefdiria.data; 
                 DIa_ne_ot(end+1) = dirfca.data; DPa_ne_ot(end+1) = prefdirca.data; 
            end;      
         end;
        end;
        % all the cells that response to untrained eye, contral eye in case
        % 2010-01-07;2010-01-28;2010-02-23
%         if ~isempty(vpib)& ~isempty(vpcb)& vpcb.data<0.05 & ~isempty(vpia)& ~isempty(vpca)& vpca.data<0.05,
%             myinds(end+1) = i; %j=j+1;
%             property = {'CONT ','IPSI ','CONT ME ','IPSI ME'};%2010-01-07: 
%             [OD,locinds,loc,ODdata] = newferretOD(cells{i}, property);
%             mydpi = prefdircb.data; 
%             if angdiffwrap(mydpi-traindir(m),360)<45 | angdiffwrap(mydpi-traindir(m),360)>135, 
%                 ODb_pt(end+1) = OD(6);
%                 DIb_te_pt(end+1) = dirfib.data; DPb_te_pt(end+1) = prefdirib.data;
%                 DIb_ne_pt(end+1) = dirfcb.data; DPb_ne_pt(end+1) = prefdircb.data;
%                 DIa_te_pt(end+1) = dirfia.data; DPa_te_pt(end+1) = prefdiria.data;
%                 DIa_ne_pt(end+1) = dirfca.data; DPa_ne_pt(end+1) = prefdirca.data;
%             else ODb_ot(end+1) = OD(6);
%                 i,
%                  DIb_te_ot(end+1) = dirfib.data; DPb_te_ot(end+1) = prefdirib.data;
%                  DIb_ne_ot(end+1) = dirfcb.data; DPb_ne_ot(end+1) = prefdircb.data;
%                  DIa_te_ot(end+1) = dirfia.data; DPa_te_ot(end+1) = prefdiria.data; 
%                  DIa_ne_ot(end+1) = dirfca.data; DPa_ne_ot(end+1) = prefdirca.data; 
%             end;            
%         end;
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
    Nb = histc(DIb_ne_ot, bins); Na = histc(DIa_ne_ot, bins);
    CSb = 100*cumsum(Nb) / sum(Nb); CSa = 100*cumsum(Na) / sum(Na);
    plot(xax,CSb(2:end-2),'-.','color',[0.33 0.33 0.33],'linewidth',2); hold on;
    plot(xax,CSa(2:end-2),':','color',[0.66 0.66 0.66],'linewidth',2); 
    xlabel('DI'); ylabel('Percent'); title('non-trained eye, cells orthogonal train angle');
    axis ([0 1 0 100]);
    
    ODb = ODb_pt-.05;
    Bino = [];
    for i = 1: length(ODb_pt)
        if ODb(i)<=.5, Bino(i) = ODb(i);
        else Bino(i) = 1-ODb_pt(i);
        end;
    end;
    keyboard;
    figure;
    subplot(1,2,1)
    plot(ODb,DIa_te_pt-DIb_te_pt,'k.');
    xlabel('OD index'); ylabel('Change in Direction Index'); title('untrained eye vs OD index')
    hold on; plot([0 1],[0 0],'k--');axis([0,1,-.6,.6]);
    
    subplot(1,2,2)
    plot(Bino,DIa_te_pt-DIb_te_pt,'k.');
    xlabel('Binocularity'); ylabel('Change in Direction Index'); title('untrained eye vs Binocularity')
    hold on; plot([0 1],[0 0],'k--');
    [slope,offset,slope_confinterval,resid,residint,stats] = quickregression(Bino',(DIa_te_pt-DIb_te_pt)',0.05);
    slope_confinterval,
    hold on; h=plot([-100 100],[-100 100]*slope+offset,'k--'); set(h,'color',[1 1 1]*0)
    axis([0,.5,-.6,.6]);
    
    figure;
    subplot(1,2,1)
    plot(ODb,DIa_ne_pt-DIb_ne_pt+.1,'k.');
    xlabel('OD index'); ylabel('Change in Direction Index'); title('trained eye vs OD index')
    hold on; plot([0 1],[0 0],'k--');axis([0,1,-.6,.6]);
    
    subplot(1,2,2)
    plot(Bino,DIa_ne_pt-DIb_ne_pt+.1,'k.');
    xlabel('Binocularity'); ylabel('Change in Direction Index'); title('trained eye vs Binocularity')
    hold on; plot([0 1],[0 0],'k--');
    [slope,offset,slope_confinterval,resid,residint,stats] = quickregression(Bino',(DIa_ne_pt-DIb_ne_pt+.1)',0.05);
    slope_confinterval,
    hold on; h=plot([-100 100],[-100 100]*slope+offset,'k--'); set(h,'color',[1 1 1]*0)
    axis([0,.5,-.6,.6]);
    
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

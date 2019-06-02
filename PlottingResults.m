function p = PlottingResults(y1,y2, vectChangePoint)

 col1 = [1 0 0];
 col2 = [0 0.5 1];

lineProps1.width = 2;
lineProps2.width = 2;

figure; hold on 
col{1} = col1; lineProps1.col = col; y_mean1 = mean(y1,1); p = plot(y_mean1,'-o','color',col1,'linewidth',2);
col{1} = col2; lineProps2.col = col; y_mean2 = mean(y2,1); plot(y_mean2,'color',col2,'linewidth',2); 

scatter(vectChangePoint,vectChangePoint,'ko','filled','MarkerEdgeColor',[0 0.7 0.7],...
              'MarkerFaceColor',[0 0.5 0], 'LineWidth',1) %Optimal = Newly

grid on 

xlabel('\textbf{Time step $$t$$}','Interpreter','latex'); xlim([1,length(y_mean1)])
ylabel('\textbf{Change-point estimation $$\hat{\tau}_t$$}','Interpreter','latex')

labelsX = {'\fontsize{14}\color[rgb]{0 0.5 0}1','\fontsize{14}\color[rgb]{0 0.5 0}301',...
    '\fontsize{14}\color[rgb]{0 0.5 0}701','\fontsize{14}\color[rgb]{0 0.5 0}1051','1251'};

labelsY = {'\fontsize{14}\color[rgb]{0 0.5 0}1','\fontsize{14}\color[rgb]{0 0.5 0}301',...
    '\fontsize{14}\color[rgb]{0 0.5 0}701','\fontsize{14}\color[rgb]{0 0.5 0}1051'};

set(gca,'XTickLabels',labelsX)
set(gca,'YTickLabels',labelsY )
set(gca,'XTick',[vectChangePoint length(y_mean1)] ); set(gca,'YTick',vectChangePoint );
set(gca,'FontSize',14,'fontWeight','bold', 'fontName','georgia')
lgd = legend('BOCDm','BOCD','Change-point');

y_std1 = std(y1,[],1); mseb([],y_mean1, y_std1, lineProps1, 1.5)
y_std2 = std(y2,[],1); mseb([],y_mean2, y_std2, lineProps2, 1.5)

lgd.Location = 'northwest';

p.MarkerSize = 4;
%p.MarkerIndices = 1:100:length(y_mean1);







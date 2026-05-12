
load('data_real.mat');
%%    
%------------------------------------
%       PLOTS 
%------------------------------------
lw=2.8; lw2=1.8;  
%horizontal motion

figure(1) ;
subplot(3,1,1) ;
plot(out.time(:,1), out.states1(:,1), 'LineWidth',1) ;
hold on;
plot(out.time(:,1), out.states2(:,1), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), out.states3(:,1), 'LineWidth',1) ;
hold on ;
grid on;
plot(out.time(:,1), out.states4(:,1), 'LineWidth',1) ;
legend('{$x_{1}$}','{$x_{2}$}','{$x_{3}$}','{$x_{4}$}','interpreter', 'latex', 'FontSize', 12);
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', 14) ;
ylabel('{$x_{i}$} [m]', 'interpreter', 'latex', 'FontSize', 14) ;

subplot(3,1,2) ;
plot(out.time(:,1), out.states1(:,2), 'LineWidth',1) ;
hold on;
plot(out.time(:,1), out.states2(:,2), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), out.states3(:,2), 'LineWidth',1) ;
hold on ;
grid on;
plot(out.time(:,1), out.states4(:,2), 'LineWidth',1) ;
legend('{$y_{1}$}','{$y_{2}$}','{$y_{3}$}','{$y_{4}$}','interpreter', 'latex', 'FontSize', 12);
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', 14) ;
ylabel('{$y_{i}$} [m]', 'interpreter', 'latex', 'FontSize', 14) ;

subplot(3,1,3) ;
plot(out.time(:,1), out.states1(:,3), 'LineWidth',1) ;
hold on;
plot(out.time(:,1), out.states2(:,3), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), out.states3(:,3), 'LineWidth',1) ;
hold on ;
grid on ;
plot(out.time(:,1), out.states4(:,3), 'LineWidth',1) ;
legend('{$z_{1}$}','{$z_{2}$}','{$z_{3}$}','{$z_{4}$}','interpreter', 'latex', 'FontSize', 12);
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', 14) ;
ylabel('{$z_{i}$} [m]', 'interpreter', 'latex', 'FontSize', 14) ;


figure(2) ;

p1 = plot(out.states1(:,1), out.states1(:,2), '-', 'LineWidth',1.5) ;
hold on ;
p2 = plot(out.states2(:,1), out.states2(:,2), '-', 'LineWidth',1.5) ;
hold on ;
p3 = plot(out.states3(:,1), out.states3(:,2), '-', 'LineWidth',1.5) ;
hold on ;
p4 = plot(out.states4(:,1), out.states4(:,2), '-', 'LineWidth',1.5) ;
grid on ;
legend([p1 p2 p3 p4],'Robot 1', 'Robot 2', 'Robot 3', 'Robot 4', 'Location', 'southeast', 'interpreter', 'latex') ; 
xlabel('{$x$ [m]}','interpreter', 'latex', 'FontSize', 14) ;
ylabel('{$y$ [m]}','interpreter', 'latex', 'FontSize', 14) ;


%% Plotting interdistances
N = size(table(out.states1(:,1), out.states1(:,2)));
xy1 = table2array(table(out.states1(:,1), out.states1(:,2)));
xy2 = table2array(table(out.states2(:,1), out.states2(:,2)));
xy3 = table2array(table(out.states3(:,1), out.states3(:,2)));
xy4 = table2array(table(out.states4(:,1), out.states4(:,2)));

d12 = zeros(N(1),1) ;
d13 = zeros(N(1),1) ;
d14 = zeros(N(1),1) ;
%d15 = zeros(N(1),1) ;
d23 = zeros(N(1),1) ;
d24 = zeros(N(1),1) ;
%d25 = zeros(N(1),1) ;
d34 = zeros(N(1),1) ;
%d35 = zeros(N(1),1) ;

for i=1:N(1)
    d12(i,1) = norm(xy1(i,:) - xy2(i,:)) ;
    d13(i,1) = norm(xy1(i,:) - xy3(i,:)) ;
    d14(i,1) = norm(xy1(i,:) - xy4(i,:)) ;
    %d15(i,1) = norm(xy1(i,:) - xy5(i,:)) ;
    d23(i,1) = norm(xy2(i,:) - xy3(i,:)) ;
    d24(i,1) = norm(xy2(i,:) - xy4(i,:)) ;
    %d25(i,1) = norm(xy2(i,:) - xy5(i,:)) ;
    d34(i,1) = norm(xy3(i,:) - xy4(i,:)) ;
    %d35(i,1) = norm(xy3(i,:) - xy5(i,:)) ;
end

T3 = squeeze(out.sensor4).';  %Transform 1x3xn to 3xn
figure(3) ;
subplot(2,1,1)
plot(out.time(:,1), d12, 'LineWidth',1) ;
hold on;
plot(out.time(:,1), d13, 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), d14, 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), d23, 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), d24, 'LineWidth',1) ;
grid on ; 
plot(out.time(:,1), d34, 'LineWidth',1) ;
grid on ; 
legend('{$d_{12}$}','{$d_{13}$}','{$d_{14}$}','{$d_{23}$}','{$d_{24}$}','{$d_{34}$}','interpreter', 'latex', 'FontSize', 12);
%legend('d12', 'd13', 'd23') ;
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', 14) ;
ylabel('interdistance [m]', 'interpreter', 'latex', 'FontSize', 14) ;

%% AVT Action 
%figure(4) ;
subplot(2,1,2) ;
plot(out.time(:,1), T3(:,1), 'LineWidth',1) ;
hold on;
plot(out.time(:,1), out.AVT4(:,1), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), T3(:,2), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), out.AVT4(:,2), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), T3(:,3), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), out.AVT4(:,3), 'LineWidth',1) ;
grid on ; 
legend('{$d_{41}$}','{$\hat{d}_{41}$}','{$d_{42}$}','{$\hat{d}_{42}$}','{$d_{43}$}','{$\hat{d}_{43}$}','interpreter', 'latex', 'FontSize', 12);
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', 14) ;
ylabel('{$d_{i}$} [m]', 'interpreter', 'latex', 'FontSize', 14) ;


figure(4) ;
subplot(3,1,1)
plot(out.time(:,1), out.control1(:,1), 'LineWidth',1) ;
hold on;
plot(out.time(:,1), out.control2(:,1), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), out.control3(:,1), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), out.control4(:,1), 'LineWidth',1) ;
grid on ; 
legend('{$u_{1x}$}','{$u_{2x}$}','{$u_{3x}$}','{$u_{4x}$}','interpreter', 'latex', 'FontSize', 12);
%legend('d12', 'd13', 'd23') ;
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', 14) ;
ylabel('control $u_{ix}$', 'interpreter', 'latex', 'FontSize', 14) ;

subplot(3,1,2)
plot(out.time(:,1), out.control1(:,2), 'LineWidth',1) ;
hold on;
plot(out.time(:,1), out.control2(:,2), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), out.control3(:,2), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), out.control4(:,2), 'LineWidth',1) ;
grid on ; 
legend('{$u_{1y}$}','{$u_{2y}$}','{$u_{3y}$}','{$u_{4y}$}','interpreter', 'latex', 'FontSize', 12);
%legend('d12', 'd13', 'd23') ;
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', 14) ;
ylabel('control $u_{iy}$', 'interpreter', 'latex', 'FontSize', 14) ;

subplot(3,1,3)
plot(out.time(:,1), out.control1(:,3), 'LineWidth',1) ;
hold on;
plot(out.time(:,1), out.control2(:,3), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), out.control3(:,3), 'LineWidth',1) ;
hold on ;
plot(out.time(:,1), out.control4(:,3), 'LineWidth',1) ;
grid on ; 
legend('{$u_{1z}$}','{$u_{2z}$}','{$u_{3z}$}','{$u_{4z}$}','interpreter', 'latex', 'FontSize', 12);
%legend('d12', 'd13', 'd23') ;
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', 14) ;
ylabel('control $u_{iz}$', 'interpreter', 'latex', 'FontSize', 14) ;
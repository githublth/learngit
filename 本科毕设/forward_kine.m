% 2018.07.03 by Lth
%正运动学求解和验证
function y=forward_kine()

%定义符号变量
syms alpha1 alpha2 alpha3 alpha4 alpha5 alpha6
syms a1 a2 a3 a4 a5 a6
syms theta1 theta2 theta3 theta4 theta5 theta6
syms d1 d2 d3 d4 d5 d6

%组成元胞方便循环遍历
alpha={alpha1 alpha2 alpha3 alpha4 alpha5 alpha6};
a={a1 a2 a3 a4 a5 a6};
theta={theta1 theta2 theta3 theta4 theta5 theta6};
d={d1 d2 d3 d4 d5 d6};

% alpha={0 -pi/2 0 -pi/2 pi/2 -pi/2};
% a={0 a1 a2 -a3 0 0};
% theta={theta1 theta2 theta3 theta4 theta5 theta6};
% d={d1 0 0 d4 0 0};


%连杆变换矩阵
A={};
for i=1:6
    A{i}=[cos(theta{i}) -sin(theta{i}) 0 a{i};
        sin(theta{i})*cos(alpha{i}) cos(theta{i})*cos(alpha{i}) -sin(alpha{i}) -sin(alpha{i})*d{i};
        sin(theta{i})*sin(alpha{i}) cos(theta{i})*sin(alpha{i}) cos(alpha{i}) cos(alpha{i})*d{i};
        0 0 0 1]   
end

%subs函数替换值
for i=1:6
    A{i}=subs(A{i},{alpha1 alpha2 alpha3 alpha4 alpha5 alpha6},{0 pi/2 0 pi/2 -pi/2 pi/2});
    A{i}=subs(A{i},{a1 a2 a3 a4 a5 a6},{0 a2 a3 0 0 0});
    A{i}=subs(A{i},{d1 d2 d3 d4 d5 d6},{d1 0 0 d4 0 0});
    A{i}=subs(A{i},{theta1 theta2 theta3 theta4 theta5 theta6},{0 pi/2 0 0 0 0});
end

%disp显示各个连杆的变换矩阵
for i=1:6
disp(A{i})
end

%正运动学
T13=simplify(A{2}*A{3})
T03=A{1}*T13
T04=T03*A{4}
T05=T04*A{5}
T06=T05*A{6}

% B={};
% for i=1:6
% B{i}=simplify(diff([T06(1,4);T06(2,4);T06(3,4)],theta{i}));
% end
% C=[B{1} B{2} B{3} B{4} B{5} B{6}]

T=simplify(T06)
sprintf('completed')

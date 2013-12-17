%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rewrite derivatives in terms of few basic derivatives
% written by Matthis Thorade
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;

% independent vars and base props
syms D T P;
% three basic first-order derivatives (wrt d and T)
syms dP_D dP_T dU_T;
% four basic second-order derivatives (wrt d and T)
syms d2P_D2 d2P_T2 d2P_TD d2U_T2;

% step 1: rewrite the first-order derivatives (wrt d and T)
dU_D = -T/D^2*dP_T+P/D^2
dS_T = 1/T*dU_T
dS_D = -1/D^2*dP_T
dH_T = dU_T+1/D*dP_T
dH_D = 1/D*dP_D - T/D^2*dP_T

% step 2: rewrite the second-order derivatives (wrt d and T)
d2S_T2 = 1/T*d2U_T2 - 1/T^2*dU_T
d2S_D2 = -1/D^2*d2P_TD + 2/D^3*dP_T
d2S_TD = -1/D^2*d2P_T2


%% engineering derivs
dH_P_T = dH_D/dP_D
dH_P_T = simplify(dH_P_T)
dH_P_T = expand(dH_P_T)

dH_T_P = dH_T -dH_D*dP_T/dP_D
dH_T_P = simplify(dH_T_P)
dH_T_P = expand(dH_T_P)

dP_D_S = dP_D-dP_T*dS_D/dS_T
dP_D_S = simplify(dP_D_S)
dP_D_S = expand(dP_D_S)


%% dynamic derivs (first)
dT_P_H = 1/(dP_T - dP_D*dH_T/dH_D)
dT_P_H = simplify(dT_P_H)
dT_P_H = expand(dT_P_H)

dT_H_P = 1/(dH_T - dH_D*dP_T/dP_D)
dT_H_P = simplify(dT_H_P)
dT_H_P = expand(dT_H_P)

dD_P_H = 1/(dP_D - dP_T*dH_D/dH_T)
dD_P_H = simplify(dD_P_H)
dD_P_H = expand(dD_P_H)

dD_H_P = 1/(dH_D - dH_T*dP_D/dP_T)
dD_H_P = simplify(dD_H_P)
dD_H_P = expand(dD_H_P)


%% PVT second order derivatives
d2T_D2_P = -(d2P_D2*dP_T - dP_D*d2P_TD)/dP_T^2 ...
           +(d2P_TD*dP_T - dP_D*d2P_T2)*dP_D/dP_T^3
d2T_D2_P = simplify(d2T_D2_P)
d2T_D2_P = expand(d2T_D2_P)

d2D_T2_P = -(d2P_T2*dP_D - dP_T*d2P_TD)/dP_D^2 ...
           +(d2P_TD*dP_D - dP_T*d2P_D2)*dP_T/dP_D^3
d2D_T2_P = simplify(d2D_T2_P)
d2D_T2_P = expand(d2D_T2_P)


%% derivative for fundamental derivative of gas dynamics
d2P_D2_S = d2P_D2 -(dP_T*d2S_D2   + 2*d2P_TD*dS_D)/dS_T ...
                  +(d2P_T2*dS_D^2 + 2*dP_T*dS_D*d2S_TD)/dS_T^2 ...
                  -(dP_T  *dS_D^2*d2S_T2)/dS_T^3
d2P_D2_S = simplify(d2P_D2_S)
d2P_D2_S = expand(d2P_D2_S)

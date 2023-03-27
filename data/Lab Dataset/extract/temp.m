close all;
clear;
clc;

T = [338 1 0 0 0 0;
        1 292 2 0 0 0;
        0 0 265 0 0 0;
        1 0 0 323 31 1;
        0 0 0 23 364 0;
        0 0 0 0 0 418]

Accuracy = (T(1,1) + T(2,2) + T(3,3) + T(4,4) + T(5,5) +  T(6,6)) / (sum(sum(T))) % percent

A = sum(T);
P1 = T(1,1) / A(1)
P2 = T(2,2) / A(2)
P3 = T(3,3) / A(3)
P4 = T(4,4) / A(4)
P5 = T(5,5) / A(5)
P6 = T(6,6) / A(6)
close all;
clear;
clc;

%% Folders to process
train = ["DA1_WC", "DA2_AS", "DA3_CP", "DA4_JC", "DA5_UU", "DA6_AR", "DA9_NR", "SA10_CP", "SA11_UU", "SA12_AS", "SA13_WC", "SA14_AR", "SA15_NR", "SA16_JC"];
test = ["DA8_EP", "SA17_EP"];
id_train = [0 1 2 3 4 5 6 2 4 1 0 5 6 3];
id_test = [7 7];
state_train = [1 1 1 1 1 1 1 2 2 2 2 2 2 2];
state_test = [1 2];

%% Train
extraction(train, "train");
transform(train, id_train, state_train);
combining_files(train, "train");

%% Test
extraction(test, "test");
transform(test, id_test, state_test);
combining_files(test, "test");

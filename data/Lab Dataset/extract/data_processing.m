close all;
clear;
clc;

%% Folders to process
train = ["DA1_WC", "DA2_NS", "DA3_CP", "DA4_JC", "DA7_RF", "SA9_CP"];
test = ["DA8_EP"];
id_train = [0 1 2 3 4 2];
id_test = [5];
state_train = [1 1 1 1 1 2];
state_test = [1];

%% Train
extraction(train, "train");
transform(train, id_train, state_train);
combining_files(train, "train");

%% Test
extraction(test, "test");
transform(test, id_test, state_test);
combining_files(test, "test");

%% Normalize
normalize

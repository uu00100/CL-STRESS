function normalize
    fprintf('Beginning of File normalization!\n')
    data = ["body_acc_x", "body_acc_y", "body_acc_z", "bvp", "eda", "hr", "ibi", "temp"];
    train = "..\train\Inertial Signals\";
    test = "..\test\Inertial Signals\";
    endTrain = "_train.txt";
    endTest = "_test.txt";
    
    for n = 1:length(data)
        fprintf('\nThe current DATATYPE being normalized: %s\n', data(n))
        
        file = data(n);
        fileTrain = train + file + endTrain;
        fileTest = test + file + endTest;
        
        holdTrain = readmatrix(fileTrain);
        holdTest = readmatrix(fileTest);
        
        max1 = max(holdTrain);
        max2 = max(holdTest);
        maxA = max([max1 max2]);
        
        min1 = min(holdTrain);
        min2 = min(holdTest);
        minA = min([min1 min2]);
        
        m = (1 - (-1)) / (maxA - minA);
        c = 1 - (m * maxA);
        
        holdTrain = (m .* holdTrain) + c;
        holdTest = (m .* holdTest) + c;
        
        writematrix(holdTrain, fileTrain, 'Delimiter', '\t', 'WriteMode', 'overwrite')
        writematrix(holdTest, fileTest, 'Delimiter', '\t', 'WriteMode', 'overwrite')
        fprintf('End of normalization of %s!\n', data(n))
    end
    
    fprintf('\nEnd of File normalization!\n\n')
end
function combining_files(list, fType)
    %% loading data files
    %list = ["DA1_WC", "DA2_NS", "DA3_CP", "DA4_JC", "DA5_UU", "DA6_WR", "DA7_RF", "DA8_EP"]

    fprintf('Beginning of File combination!\n')
    
    check = "..\" + fType + "\Inertial Signals";
    if exist(check, 'dir')
        rmdir(check, 's')
    end

    mkdir(check)
    
    sub = "..\" + fType + "\subject_" + fType + ".txt";
    if exist(sub, 'file')
        delete(sub);
    end
    
    st = "..\" + fType + "\y_" + fType + ".txt";
    if exist(st, 'file')
        delete(st);
    end

    for n = 1:length(list)
        folder = append(list(n), '\v2\');
        end_path = ".txt";

        acc_x = readmatrix(append(folder, append("body_acc_x", end_path)));
        acc_x = normalize_v2(acc_x);
        acc_y = readmatrix(append(folder, append("body_acc_y", end_path)));
        acc_y = normalize_v2(acc_y);
        acc_z = readmatrix(append(folder, append("body_acc_z", end_path)));
        acc_z = normalize_v2(acc_z);
        bvp = readmatrix(append(folder, append("bvp", end_path)));
        bvp = normalize_v2(bvp);
        eda = readmatrix(append(folder, append("eda", end_path)));
        eda = normalize_v2(eda);
        hr = readmatrix(append(folder, append("hr", end_path)));
        hr = normalize_v2(hr);
        ibi = readmatrix(append(folder, append("ibi", end_path)));
        ibi = normalize_v2(ibi);
        temp = readmatrix(append(folder, append("temp", end_path)));
        temp = normalize_v2(temp);
        subject = readmatrix(append(folder, append("subject", end_path)));
        state = readmatrix(append(folder, append("y", end_path)));

        %% Arrays to txt files
        dir = check + "\";
        end_path = "_" + fType + ".txt";

        % Acceleration X
        file = append(dir, append('body_acc_x', end_path));
        writematrix(acc_x, file,'Delimiter', '\t', 'WriteMode', 'append')

        % Acceleration Y
        file = append(dir, append('body_acc_y', end_path));
        writematrix(acc_y, file,'Delimiter', '\t', 'WriteMode', 'append')

        % Acceleration Z
        file = append(dir, append('body_acc_z', end_path));
        writematrix(acc_z, file,'Delimiter', '\t', 'WriteMode', 'append')

        % Blood Volume Pulse
        file = append(dir, append('bvp', end_path));
        writematrix(bvp, file,'Delimiter', '\t', 'WriteMode', 'append')

        % Electrodermal Activity
        file = append(dir, append('eda', end_path));
        writematrix(eda, file,'Delimiter', '\t', 'WriteMode', 'append')

        % Heart Rate
        file = append(dir, append('hr', end_path));
        writematrix(hr, file,'Delimiter', '\t', 'WriteMode', 'append')

        % Inter Beat Intervals
        file = append(dir, append('ibi', end_path));
        writematrix(ibi, file,'Delimiter', '\t', 'WriteMode', 'append')

        % Temperature
        file = append(dir, append('temp', end_path));
        writematrix(temp, file,'Delimiter', '\t', 'WriteMode', 'append')
        
        % Subject
        file = append("..\" + fType + "\", append('subject', end_path));
        writematrix(subject, file,'Delimiter', '\t', 'WriteMode', 'append')
        
        % State
        file = append("..\" + fType + "\", append('y', end_path));
        writematrix(state, file,'Delimiter', '\t', 'WriteMode', 'append')
    end
    
    fprintf('End of File combination!\n\n')
end

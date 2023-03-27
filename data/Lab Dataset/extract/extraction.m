function extraction(list, fType)
    fprintf('List of DATASETS for %sing:', fType)
    
    for n = 1:length(list)
        fprintf(' %s', list(n))

        if (n ~= length(list))
            fprintf(',')
        end
    end

    fprintf('\n')

    fprintf('\nBeginning of Extraction!\n')

    for n = 1:length(list)
        fprintf('\nThe current DATASET being extracted: %s\n', list(n))
        folder = list(n) + "\";

        % Acceleration (X, Y, Z)
        hold = append(folder, "ACC.csv");
        opts = detectImportOptions(hold);
        opts.DataLines = [3, Inf];
        acc = readmatrix(hold, opts);
        acc = acc .* (2 ./ 128) .* 9.81;

        % Blood Volume Pulse
        hold = append(folder, "BVP.csv");
        opts = detectImportOptions(hold);
        opts.DataLines = [3, Inf];
        bvp = readmatrix(hold, opts);

        % Electrodermal Activity
        hold = append(folder, "EDA.csv");
        opts = detectImportOptions(hold);
        opts.DataLines = [3, Inf];
        eda = readmatrix(hold, opts);

        % Heart Rate
        hold = append(folder, "HR.csv");
        opts = detectImportOptions(hold);
        opts.DataLines = [2, Inf];
        hr = readmatrix(hold, opts);

        % Temperature
        hold = append(folder, "TEMP.csv");
        opts = detectImportOptions(hold);
        opts.DataLines = [3, Inf];
        temp = readmatrix(hold, opts);

        % Inter Beat Intervals
        hold = append(folder, "IBI.csv");
        opts = detectImportOptions(hold);
        opts.DataLines = [2, Inf];
        ibi = readmatrix(hold, opts);

        %% Modifing Acceleration
        acc_X = acc(:, 1);
        acc_Y = acc(:, 2);
        acc_Z = acc(:, 3);

        %% Modifing  Inter Beat Intervals
        ibi = ibi(:, 2);

        %% Matching the lengths of arrays
        len = length(bvp);

        % Modifiying Acceleration
        al = length(acc);
        repeat = ceil(len / al);
        hold = zeros(len, 3);
        element_X = acc_X(1, 1);
        element_Y = acc_Y(1, 1);
        element_Z = acc_Z(1, 1);
        dx = (acc_X(2, 1) - element_X) / repeat;
        dy = (acc_Y(2, 1) - element_Y) / repeat;
        dz = (acc_Z(2, 1) - element_Z) / repeat;

        for i = 1 : len
            hold(i, 1) = element_X;
            hold(i, 2) = element_Y;
            hold(i, 3) = element_Z;
            element_X = element_X + dx;
            element_Y = element_Y + dy;
            element_Z = element_Z + dz;

            if ((mod(i, repeat) == 0) && (i ~= len))
                i = (i / repeat) + 1;
                element_X = acc_X(i, 1);
                element_Y = acc_Y(i, 1);
                element_Z = acc_Z(i, 1);

                if (i ~= al)
                    dx = (acc_X(i + 1, 1) - element_X) / repeat;
                    dy = (acc_Y(i + 1, 1) - element_Y) / repeat;
                    dz = (acc_Z(i + 1, 1) - element_Z) / repeat;
                else
                    dx = 0;
                    dy = 0;
                    dz = 0;
                end
            end
        end

        acc_X = hold(:, 1);
        acc_Y = hold(:, 2);
        acc_Z = hold(:, 3);

        % Modifiying Electrodermal Activity
        el = length(eda);
        repeat = ceil(len / el);
        hold = zeros(len, 1);
        element = eda(1, 1);
        de = (eda(2, 1) - element) / repeat;

        for i = 1 : len
            hold(i, 1) = element;
            element = element + de;

            if ((mod(i, repeat) == 0) && (i ~= len))
                i = (i / repeat) + 1;
                element = eda(i, 1);

                if (i ~= el)
                    de = (eda(i, 1) - element) / repeat;
                else
                    de = 0;
                end
            end
        end

        eda = hold(:, 1);

        % Modifiying Heart Rate
        hl = length(hr);
        repeat = ceil(len / hl);
        hold = zeros(len, 1);
        element = hr(1, 1);
        dh = (hr(2, 1) - element) / repeat;

        for i = 1 : len
            hold(i, 1) = element;
            element = element + dh;

            if ((mod(i, repeat) == 0) && (i ~= len))
                i = (i / repeat) + 1;
                element = hr(i, 1);

                if (i ~= hl)
                    dh = (hr(i, 1) - element) / repeat;
                else
                    dh = 0;
                end
            end
        end

        hr = hold(:, 1);

        % Modifiying Temperature
        tl = length(temp);
        repeat = ceil(len / tl);
        hold = zeros(len, 1);
        element = temp(1, 1);
        dt = (temp(2, 1) - element) / repeat;

        for i = 1 : len
            hold(i, 1) = element;
            element = element + dt;

            if ((mod(i, repeat) == 0) && (i ~= len))
                i = (i / repeat) + 1;
                element = temp(i, 1);

                if (i ~= tl)
                    dt = (temp(i, 1) - element) / repeat;
                else
                    dt = 0;
                end
            end
        end

        temp = hold(:, 1);

        % Modifiying Inter Beat Intervals
        il = length(ibi);
        repeat = ceil(len / il);
        hold = zeros(len, 1);
        element = ibi(1, 1);
        di = (ibi(2, 1) - element) / repeat;

        for i = 1 : len
            hold(i, 1) = element;
            element = element + di;

            if ((mod(i, repeat) == 0) && (i ~= len))
                i = (i / repeat) + 1;
                element = ibi(i, 1);

                if (i ~= il)
                    di = (ibi(i, 1) - element) / repeat;
                else
                    di = 0;
                end
            end
        end

        ibi = hold(:, 1);

        %% Arrays to txt files
        %dir = '..\test\Inertial Signals\'; % '..\train\Inertial Signals\' or '..\test\Inertial Signals\'
        folder = folder + "v2";
        dir = folder + "\";

        if exist(folder, 'dir')
            rmdir(folder, 's')
        end

        mkdir(folder)

        end_path = '.txt'; % train.txt or test.txt

        % Acceleration X
        file = append(dir, append('body_acc_x', end_path));
        writematrix(acc_X, file,'Delimiter', '\t')

        % Acceleration Y
        file = append(dir, append('body_acc_y', end_path));
        writematrix(acc_Y, file,'Delimiter', '\t')

        % Acceleration Z
        file = append(dir, append('body_acc_z', end_path));
        writematrix(acc_Z, file,'Delimiter', '\t')

        % Blood Volume Pulse
        file = append(dir, append('bvp', end_path));
        writematrix(bvp, file,'Delimiter', '\t')

        % Electrodermal Activity
        file = append(dir, append('eda', end_path));
        writematrix(eda, file,'Delimiter', '\t')

        % Heart Rate
        file = append(dir, append('hr', end_path));
        writematrix(hr, file,'Delimiter', '\t')

        % Inter Beat Intervals
        file = append(dir, append('ibi', end_path));
        writematrix(ibi, file,'Delimiter', '\t')

        % Temperature
        file = append(dir, append('temp', end_path));
        writematrix(temp, file,'Delimiter', '\t')

        fprintf('End of Extraction of %s!\n', list(n))
    end

    fprintf('\nEnd of Extraction!\n\n')
end
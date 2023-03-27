function transform(list, id, state)
    %% loading data files
    %list = ["DA1_WC", "DA2_NS", "DA3_CP", "DA4_JC", "DA7_RF", "DA8_EP"]; % , "DA5_UU", "DA6_WR"
    data = ["body_acc_x", "body_acc_y", "body_acc_z", "bvp", "eda", "hr", "ibi", "temp"];
    fprintf('Beginning of Transformation!\n')
    
    for outer = 1:length(list)
        fprintf('\nThe current DATASET being transformed: %s\n', list(outer))
        
        cData = list(outer) + "\v2\";

        for inner = 1:length(data)
            file = cData + data(inner) + ".txt";
            curFile = readmatrix(file);

            % Transformation
            len = length(curFile);
            beginI = 1;
            endI = 128;
            count = 0;

            while (1)
                count = count + 1;

                if (endI < len)
                    hold(count,:) = curFile(beginI:endI,1)';
                else
                    temp = curFile(beginI:end,1);
                    alen = length(temp);

                    if (128 > alen)
                        temp = cat(1, temp, zeros((128-alen), 1));
                    end

                    hold(count,:) = temp';
                    break
                end

                beginI = beginI + 64;
                endI = endI + 64;
            end

            writematrix(hold, file, 'Delimiter', '\t')
        end

        subject = id(outer) .* ones(length(hold(:,1)), 1);
        sFile = cData + "subject.txt";
        writematrix(subject, sFile, 'Delimiter', '\t')
        
        stateD = state(outer) .* ones(length(hold(:,1)), 1);
        sFile = cData + "y.txt";
        writematrix(stateD, sFile, 'Delimiter', '\t')
        fprintf('End of Transformation of %s!\n', list(outer))
    end
    
    fprintf('\nEnd of Transformation!\n\n')
end
classdef utility_functions
    
    methods (Static)
        
        % common functions
        function [X_train, X_test, y_train, y_test] = train_test_split(X, y, test_size)
            
            if (nargin<3) || (test_size>=1)
                % If no test_size is determined, assign the test_size as
                % 0.2
                % 20% of the whole data will be used as test
                test_size = 0.2;
            end
            
            N = length(y);
            shuffle_index = randperm(N);
            X = X(shuffle_index, :);       % shuffle the data
            y = y(shuffle_index, :);       % shuffle the data
            test_N = round(N*test_size);
            train_index = 1:N-test_N;
            test_index = N-test_N+1:N;
            
            X_train = X(train_index, :);
            y_train = y(train_index, :);
            X_test = X(test_index, :);
            y_test = y(test_index, :);
            
        end
        
        function [augmented_x,augmented_y] = augment_data(x, y, augmentation_size)

            if (nargin<3)
                augmentation_size = 150e3;
            end
            
            [N,M] = size(x);
            if N<augmentation_size
                % concat necessary
                concat_time = ceil(augmentation_size/N);
                augmented_x = zeros(concat_time*N, M);
                augmented_y = zeros(concat_time*N, 1);
                for i=1:concat_time
                    start_i = (i-1)*N+1;
                    end_i = i*N;
                    shuffle_i = randperm(length(y));
                    augmented_x(start_i:end_i, :) = x(shuffle_i, :);
                    augmented_y(start_i:end_i, :) = y(shuffle_i, :);
                end
            else
                % no concat
                augmented_x = x;
                augmented_y = y;
            end

        end
        
        function ret = deriv_sigmoid_loss(z, h)
            sigmoid_loss_x = utility_functions.sigmoid_loss(z, h);
            ret = h*(1-sigmoid_loss_x)*sigmoid_loss_x;
        end

        function ret = sigmoid_loss(z,h)
            ret = 1/(1+exp(-h*z));
        end
        
        % plot_decision_boundaries
        function plot_decision_boundary(w, b, x, y)
            
            figure();
            
            numPtsInGrid = 100;
            x1_min = min(x(:,1));
            x1_max = max(x(:,1));
            x2_min = min(x(:,2));
            x2_max = max(x(:,2));

            % determine space steps
            x1_steps = linspace(x1_min, x1_max, numPtsInGrid);
            x2_steps = linspace(x2_min, x2_max, numPtsInGrid);

            % create the space
            [X1, X2] = meshgrid(x1_steps, x2_steps(end:-1:1));
            Z = zeros(numPtsInGrid, numPtsInGrid);

            for i=1:numPtsInGrid
                for j=1:numPtsInGrid
                    xt = [X1(i,j), X2(i,j)];
                    y_discriminant_tmp = xt*w+b;
                    yt_predict = sign(y_discriminant_tmp);
                    if yt_predict==0
                        yt_predict=-1;
                    end
                    Z(i,j) = yt_predict;
                end
            end

            % store the predictions
            sub_i = randi([1 length(y)], round(length(y)/2), 1);
            y_ = y(sub_i);
            x_ = x(sub_i, :);
            y_pred = zeros(length(y_), 1);
            for i=1:length(y_)
                xt=x_(i,:);
                y_discriminant_tmp = xt*w+b;
                y_pred(i) = sign(y_discriminant_tmp);
            end
            
            y_label = cell(length(y_),1);
            y_label(y_<0) = {'Class -1'};
            y_label(y_>0) = {'Class 1'};
            y_label((y_<0) & (y_pred>0)) = {'False alarm'};

            % plot the decision boundary
            % plot the main data
            gscatter(x_(:,1),x_(:,2),y_label, 'brg', 'xo*');
            xlabel('X_1');
            ylabel('X_2');
            grid on
            hold on

            % plot the decision boundaries
            hc = [];
            hLegend = findobj(gcf, 'Type', 'Legend');
            set(hc,'EdgeColor','none')
            contour(X1,X2,Z,1,'LineWidth',2,'LineColor','k');
            legend('Location','northeast');
            hold off
            new_legend = hLegend.String;
            new_legend{length(new_legend)} = 'Decision Boundary';
            legend(new_legend);

        end
        
    end
    
end
close
clear
clc

tfprs = [5e-2];
tfpr_index = 1;
MC = 16;
data_name = 'banana';
out_data = sprintf('./output/%s/res_%03d.mat', data_name, tfpr_index);
out_hyper = sprintf('./output/%s/res_hyper_%03d.mat', data_name, tfpr_index);

tpr_train_array_all = cell(1, MC);
fpr_train_array_all = cell(1, MC);
neg_class_weight_train_array_all = cell(1, MC);
pos_class_weight_train_array_all = cell(1, MC);
tpr_test_array_all = cell(1, MC);
fpr_test_array_all = cell(1, MC);

% cross validation part
tfpr = tfprs(tfpr_index);
if ~isfile(out_hyper)
    % no hyperparameters available, run
    test_repeat = 1;
    model = single_experiment(tfpr, data_name, test_repeat, []);
    % get the hyperparameters
    eta_init = model.eta_init_;
    beta_init = model.beta_init_;
    gamma = model.gamma_;
    sigmoid_h = model.sigmoid_h_;
    lambda = model.lambda_;
    % save hyper-parameters
    save(out_hyper, 'eta_init', 'beta_init', 'gamma', 'sigmoid_h', 'lambda');
end
   

% hyperparameter is available
hyper_params = load(out_hyper);
% run the model with hyperparams
test_repeat = 100;

% run MCs
parfor i=1:MC
    % run the model
    model = single_experiment(tfpr, data_name, test_repeat, hyper_params);
    % save the results
    tpr_train_array_all{i} = model.tpr_train_array_;
    fpr_train_array_all{i} = model.fpr_train_array_;
    neg_class_weight_train_array_all{i} = model.neg_class_weight_train_array_;
    pos_class_weight_train_array_all{i} = model.pos_class_weight_train_array_;
    tpr_test_array_all{i} = model.tpr_test_array_;
    fpr_test_array_all{i} = model.fpr_test_array_;
end

save(sprintf('./output/%s/res_%03d',data_name, tfpr_index),...
    'tpr_train_array_all',...
    'fpr_train_array_all',...
    'neg_class_weight_train_array_all',...
    'pos_class_weight_train_array_all',...
    'tpr_test_array_all',...
    'fpr_test_array_all');

% run 1 last time for for generating the output figures
% note that the results generated at this point is not saved, this is only
% for generating decision boundaries and transient outputs
model = single_experiment(tfpr, data_name, test_repeat, hyper_params);
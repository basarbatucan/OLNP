# A Neural Network Approach for Online Nonlinear Neyman-Pearson Classification
This is the repository for Online Neyman Pearson (NP) Classifier described in [1]: https://dl.acm.org/doi/pdf/10.1145/1961189.1961200?casa_token=wkfMmSngkWAAAAAA:WwjFomI3GmEUVX8uYJ03C4252X6xGW6wB0tCFBkVk6X_aS7CZXUgiEE4RS3BSMiwWiShPjfNsxprTAk.<br/>
The only difference within the implementation is is the estimation of FPR of the perceptron in the training phase. Similar approach is also used in [2].<br/>

This implementation also contains cross-validation of the hyper-parameters. Best set of hyper-parameters are selected based on NP-score with grid search.<br/>

# Evaluating and Using the results
Running the model will generate 4 different graphs.<br/>
These graphs correspond to transient behaviour of the model during training.<br/>
In order to look at the final results, use the latest element of each array for the corresponding metric.<br/>
Graphs of the 4 different arrays are shown below.<br/>
<img src="figures/code_output.png"><br/>

Top and bottom figures are related to train and test, respectively. The number of samples in training is related to the augmentation (explained in model parameters).<br/>
In current case, the number of training samples is ~150k. Similarly, for test figures, there are 100 data points, where each point is an individual test of the existing<br/>
model at different stages of the training. Please refer to the paper for more detailed explanation.<br/>

# Running the Model with a new data set
In order to run the full pipeline with a new dataset
* Make sure downloaded data has the same fields with ./data/banana.mat
* Make sure the downloaded data is located under the data folder.
* Update the pipeline parameter showing the directory for the input data
* Include additional hyperparameters for better performance

# Expected Decision Boundaries
When input data is 2D, it is possible to visualize decision boundaries. I included 2 decision boundaries for target false alarms 0.05 and 0.2.<br/>
<img src="figures/db_005.png">
<img src="figures/db_020.png">

Thanks!
Basarbatu Can

# References
[1] Gasso, Gilles, et al. "Batch and online learning algorithms for nonconvex Neyman-Pearson classification." ACM transactions on intelligent systems and technology (TIST) 2.3 (2011): 1-19. <br/>
[2] Can, Basarbatu, and Huseyin Ozkan. "A Neural Network Approach for Online Nonlinear Neyman-Pearson Classification." IEEE Access 8 (2020): 210234-210250.
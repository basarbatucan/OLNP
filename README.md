# A Neural Network Approach for Online Nonlinear Neyman-Pearson Classification
This is the repository for Online Neyman Pearson (NP) Classifier described in [1]: https://dl.acm.org/doi/pdf/10.1145/1961189.1961200?casa_token=wkfMmSngkWAAAAAA:WwjFomI3GmEUVX8uYJ03C4252X6xGW6wB0tCFBkVk6X_aS7CZXUgiEE4RS3BSMiwWiShPjfNsxprTAk.
The only difference within the implementation is is the estimation of FPR of the perceptron in the training phase. Same approach is also used in [2].

This implementation also contains cross-validation of the hyper-parameters. Best set of hyper-parameters are selected based on NP-score with grid search.<br/>

Thanks!
Basarbatu Can

# References
[1] Gasso, Gilles, et al. "Batch and online learning algorithms for nonconvex Neyman-Pearson classification." ACM transactions on intelligent systems and technology (TIST) 2.3 (2011): 1-19. <br/>
[2] Can, Basarbatu, and Huseyin Ozkan. "A Neural Network Approach for Online Nonlinear Neyman-Pearson Classification." IEEE Access 8 (2020): 210234-210250.
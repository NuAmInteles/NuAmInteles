from bayes_opt import BayesianOptimization

def optimize():
    gp_params = {"alpha": 1e-5}
    BO = BayesianOptimization(
        train_nn,
        {'hidden_layers': (3, 5),
        'hidden_size': (128, 800),
         'lr': (0.0001, 0.9),
        'epochs': (10, 70),
        'batch_size': (4,20),}
    )

    BO.explore({'hidden_layers': [3, 5],
        'hidden_size': [128, 384, 800],
         'lr': [0.0003, 0.001, 0.01, 0.1],
        'epochs': [15, 70],
        'batch_size': [4,8,16,20],})
    BO.maximize(n_iter=10, **gp_params)

    print('RFC: %f' % BO.res['max']['max_val'])

    #train_nn(hidden_layers=None, hidden_size=None, lr=None, epochs=None, batch_size=None, augment=None): 
    #train_nn(hidden_layers=3, hidden_size=384, lr=None, epochs=20, batch_size=10, augment=False)

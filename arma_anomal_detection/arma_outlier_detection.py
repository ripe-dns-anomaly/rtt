import sys
import pandas as pd
import time
import random
import numpy as np
import pickle

import predict_ts
import train_model

def train_arma(ts, predictions):
  
    with open('arma_mod.pkl', 'wb') as output:
        arma_mod = train_model.train_arma_model(ts[:-predictions],(2,0))
        pickle.dump(arma_mod, output, pickle.HIGHEST_PROTOCOL)
    
    return arma_mod

def main():

    # Define how many values we need to predict
    predictions = 10

    # Read in Data
    y = []
    f = open('testdata.csv')
    for line in f:
        print(line[:-1])
        y.append(float(line[:-1]))
    
    # Dummy data

    print(y)

    # Read in model
    try:
        with open('arma_mod.pkl', 'rb') as input:
            arma_mod = pickle.load(input)
    except:
        print('Create a new model')
        arma_mod = train_arma(y, predictions)
  
    print(arma_mod.params)

    # Retrain model every h hours 
    # ignore last x-'predictions' for retraining
    

    # Predict the next values

    #predicted_vals = predict_ts.predict_ts(arma_mod, ts.iloc[-1].name, ts.iloc[-1].name)
    predicted_vals = predict_ts.predict_ts(arma_mod, len(y)-predictions-1, len(y)-1)
    print(y[-predictions:])
    print()
    print(predicted_vals)
    

if __name__ == "__main__":
    sys.exit(main())

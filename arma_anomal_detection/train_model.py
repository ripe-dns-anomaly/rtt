import pandas as pd
import statsmodels.api as sm

def train_arma_model(ts, pq):
    """Get a timeseries as a list and return a ARMA model"""
    arma_mod = sm.tsa.ARMA(ts, pq).fit()
    return arma_mod 

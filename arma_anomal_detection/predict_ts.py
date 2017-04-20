def predict_ts(arma_mod, start, end):
    ''' expects a statsmodel.tsa.arma model, a start date for prediction the values and an end date'''
    return arma_mod.predict(start, end)


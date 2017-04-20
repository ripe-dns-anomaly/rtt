def predict_ts(arma_mod, start, end):
    ''' expects a statsmodel.tsa.arma model, a start index for prediction the values and an end index'''
    print(start, end)
    return arma_mod.predict(start, end)


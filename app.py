from flask import Flask, render_template
import pandas as pd
import numpy as np

app = Flask(__name__)

@app.route('/')
def main():
    return render_template('index.html')


@app.route("/data")
def large_payload():
    df = pd.DataFrame(np.zeros(shape=(7000, 5000)))
    return df.to_json(orient='records')
    

if __name__ == "__main__":
    app.run(debug=True, port=8081)

from flask import Flask, render_template
app = Flask(__name__)

@app.route('/')
def hello():
    message = "Hello World.. It\'s been fun!"
    return render_template('index.html', message=message)
BAD TEXT TO FAIL LINT
app.run(host='0.0.0.0', port=80)


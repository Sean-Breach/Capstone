from flask import Flask, render_template
app = Flask(__name__)

@app.route('/')
def hello():
    message = "Hello Udacity.. It\'s been fun!"
    return render_template('index.html', message=message)

app.run(host='0.0.0.0', port=80)


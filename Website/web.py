from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/')
def helloIndex():
    message = "Hello Udacity.. It's been fun!"
    return render_template('index.html', message=message)

app.run(host='0.0.0.0', port=80)


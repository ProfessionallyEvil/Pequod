from flask import Flask
import os
app = Flask(__name__)

@app.route('/')
def index():
	return 'Check the status of your docker containers.'

if __name__ == '__main__':
	app.run(debug=True,host='0.0.0.0')
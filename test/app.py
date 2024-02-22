from os import environ
import psycopg2
from dotenv import load_dotenv
from flask import Flask
from flask_sqlalchemy import SQLAlchemy


load_dotenv()
  
app = Flask(__name__)

url=environ.get('DATABASE_URL') #url=os.getenv('DATABASE_URL') 
#conn = psycopg2.connect(url) #is used without SQLAlchemy

app.config['SQLALCHEMY_DATABASE_URI'] = url
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)


@app.route('/')
def home():
    return 'Hello, Flask!'

if __name__ == '__main__':
   app.run(port=7100,debug=True)
from flask import Flask,jsonify,request

app = Flask(__name__)

books=[
     {'id':1,"title":"Book 1",'author':'Author 1'},
     {'id':2,"title":"Book 2",'author':'Author 2'},
     {'id':3,"title":"Book 3",'author':'Author 3'}
]
@app.route('/books',methods=['GET'])
def get_books():
     return  books

@app.route('/books/<int:book_id>', methods=['GET'])
def get_book(book_id):
      for book in books:
            if book['id']==book_id:
                  return book
      return {'message':'Book not found'}
            
if __name__ == '__main__':
      app.run(port=7100,debug=True)

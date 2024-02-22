from flask import Flask,jsonify,request,json
from flask_sqlalchemy import SQLAlchemy
from flask_mysqldb import MySQL
from marshmallow import Schema,fields 
from os import environ
# from dotenv import load_dotenv
# load_dotenv()
# print(environ.get('DbMySQLServer'))

app = Flask(__name__)

db=SQLAlchemy()

mysql=MySQL(app)

class Product(db.Model):
    id=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(100),nullable=False)
    price=db.Column(db.Float,nullable=False)
    category=db.Column(db.String(100), nullable=False)

    def __init__(self,name,price,category):
        self.name=name
        self.price=price
        self.category=category
class ProductSchema(Schema):
    class Meta:
        fields=('id','name','price','category')

product_schema=ProductSchema()
products_schema=ProductSchema(many=True)

app.config['SQLALCHEMY_DATABASE_URI'] = environ.get('DbMySQLUser')+'@'+ environ.get('DbMySQLServer')   #os.environ.get 'mysql://root:1Password$@127.0.0.1/dbForTest'
print(app.config['SQLALCHEMY_DATABASE_URI'])
db.init_app(app)

with app.app_context():
    db.create_all()

@app.route('/products', methods=['POST'])
def add_product():
    _json=request.json
    name=_json['name']  
    price=_json['price']
    category=_json['category']
    new_product=Product(name, price, category)
    db.session.add(new_product)
    db.session.commit()
    return jsonify({'message':'Product added successfully'})

@app.route('/products', methods=['GET'])
def get_products():
    all_products=Product.query.all()
    result=products_schema.dump(all_products)
    return jsonify(result)

@app.route('/products/<id>', methods=['GET'])
def get_product(id):
    if str.isdigit(id):
        product=Product.query.get(id)
        if product is None:
            return jsonify({'message':'Invalid ID'})
        result=product_schema.dump(product)
        return jsonify(result)
    else:   
        return jsonify({'message':'Invalid ID'})
   
@app.route('/products/<id>', methods=['DELETE'])
def delete_product(id):
    if str.isdigit(id):
        product=Product.query.get(id)
        if product is None:
            return jsonify({'message':'Invalid ID'})
        db.session.delete(product)
        db.session.commit()
        return jsonify({'message':'Product deleted successfully'})
    else:
        return jsonify({'message':'Invalid ID'})
    
@app.route('/products/<id>', methods=['PUT'])
def update_product(id):
    if str.isdigit(id):
        product=Product.query.get(id)
        if product is None:
            return jsonify({'message':'Invalid ID'})
        _json=request.json
        product.name=_json['name']
        product.price=_json['price']
        product.category=_json['category']
        db.session.commit()
        return jsonify({'message':'Product updated successfully'})
    else:
        return jsonify({'message':'Invalid ID'})
    
if __name__ == '__main__':
    app.run(port=7000)


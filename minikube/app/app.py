from flask import Flask, render_template, request, redirect, url_for 
import psycopg2 
import os
  
app = Flask(__name__) 

user = os.environ['POSTGRES_USER']
password = os.environ['POSTGRES_PASSWORD']
host = os.environ['POSTGRES_HOST']
dbname = os.environ['POSTGRES_DB']
port = os.environ['POSTGRES_PORT']

@app.route('/') 
def index(): 
    # Connect to the database 
    conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)
  
    # create a cursor 
    cur = conn.cursor() 
  
    # Select all products from the table 
    cur.execute('''SELECT * FROM products''') 
  
    # Fetch the data 
    data = cur.fetchall() 
  
    # close the cursor and connection 
    cur.close() 
    conn.close() 
  
    return render_template('index.html', data=data) 

@app.route('/create', methods=['POST']) 
def create(): 
    conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)
  
    cur = conn.cursor() 
  
    # Get the data from the form 
    name = request.form['name'] 
    price = request.form['price'] 
  
    # Insert the data into the table 
    cur.execute( 
        '''INSERT INTO products (name, price) VALUES (%s, %s)''', 
        (name, price)) 
  
    # commit the changes 
    conn.commit() 
  
    # close the cursor and connection 
    cur.close() 
    conn.close() 
  
    return redirect(url_for('index')) 
  
  
@app.route('/update', methods=['POST']) 
def update(): 
    
    conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)
  
    cur = conn.cursor() 
  
    # Get the data from the form 
    name = request.form['name'] 
    price = request.form['price'] 
    id = request.form['id'] 
  
    # Update the data in the table 
    cur.execute( 
        '''UPDATE products SET name=%s, price=%s WHERE id=%s''',
        (name, price, id)) 
  
    # commit the changes 
    conn.commit() 
    return redirect(url_for('index')) 
  
  
@app.route('/delete', methods=['POST']) 
def delete(): 
    
    conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)

    cur = conn.cursor() 
  
    # Get the data from the form 
    id = request.form['id'] 
  
    # Delete the data from the table 
    cur.execute('''DELETE FROM products WHERE id=%s''', (id,)) 
  
    # commit the changes 
    conn.commit() 
  
    # close the cursor and connection 
    cur.close() 
    conn.close() 
  
    return redirect(url_for('index'))      

# for health checks
@app.route('/app_health_check')
def health_chech():
    return "seccess"

if __name__ == "__main__": 
    app.run(host='0.0.0.0', port=5000, debug=True)   
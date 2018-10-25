# import the Flask class from the flask module
from flask import Flask, render_template

# create the application object
app = Flask(__name__)

@app.route('/')
@app.route('/welcome')
@app.route('/home')
def welcome():
    return render_template('home.html')  # render a template

@app.route('/login')
def login():
    return render_template('login.html')  

@app.route('/register')
def register():
    return render_template('home.html') 

@app.route('/about')
def about():
    return render_template('about.html') 


@app.route("/logout")
def logout():
    session['logged_in'] = False
    return home()

# start the server with the 'run()' method
if __name__ == '__main__':
    app.run(debug=True)
    TEMPLATES_AUTO_RELOAD = True
    app.secret_key = 'super_secret_key'
    
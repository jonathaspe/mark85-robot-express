from robot.api.deco import keyword
from pymongo import MongoClient

client = MongoClient('mongodb+srv://qa:iBxy9HXGCkdy703l@cluster0.tlfpgnu.mongodb.net/?retryWrites=true&w=majority')

db = client['markdb']

#cadastro de um método para a remoção de usuários do db
@keyword('Remove user from database')
def remove_user(email):
        users = db['users']
        users.delete_many({'email': email})
        print('Removing user by ' + email)
        
        
@keyword('Insert user in database')
def insert_user(name, email, password):
    #documento json segue a mesma modelagem do MongoDB
    doc = {
        'name': name,
        'email': email,
        'password': password
    }
    
    users = db['users']
    users.insert_one(doc)
    print(doc)
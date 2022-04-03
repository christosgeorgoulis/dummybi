from tooling.dummyapitopostgres import DummyapiToPostgres

LOAD_QUERY = './sql/upsert_users.sql'
COLUMNS = {
    'dateOfBirth'       : 'dateofbirth', 
    'email'             : 'email', 
    'firstName'         : 'firstname', 
    'gender'            : 'gender', 
    'id'                : 'id', 
    'lastName'          : 'lastname', 
    'location.city'     : 'city', 
    'location.country'  : 'country', 
    'location.state'    : 'state',
    'location.street'   : 'street', 
    'location.timezone' : 'timezone', 
    'phone'             : 'phone', 
    'picture'           : 'picture', 
    'registerDate'      : 'registerdate', 
    'title'             : 'title', 
    'updatedDate'       : 'updateddate',
    }

def users_pipeline():
    # api to postgres
    fetcher = DummyapiToPostgres(model='user', fetching_type='full', columns=COLUMNS)
    fetcher.execute()
from tooling.dummyapitopostgres import DummyapiToPostgres

LOAD_QUERY = './sql/upsert_users.sql'
COLUMNS = {
    'id'            : 'id', 
    'message'       : 'message', 
    'owner.id'      : 'owner', 
    'post'          : 'post', 
    'publishDate'   : 'publishdate',
    }

def comments_pipeline():
    # api to postgres
    fetcher = DummyapiToPostgres(model='comment', columns=COLUMNS)
    fetcher.execute()
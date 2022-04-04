from tooling.dummyapitopostgres import DummyapiToPostgres

LOAD_QUERY = './sql/upsert_users.sql'
COLUMNS = {
    'id'            : 'id', 
    'text'          : 'text', 
    'image'         : 'image', 
    'likes'         : 'likes', 
    'link'          : 'link',
    'tags'          : 'tags', 
    'publishDate'   : 'publishdate', 
    'owner.id'      : 'owner'
}

def main():
    # api to postgres
    fetcher = DummyapiToPostgres(model='post', fetching_type='full', columns=COLUMNS)
    fetcher.execute()

if __name__ == '__main__':
    main()
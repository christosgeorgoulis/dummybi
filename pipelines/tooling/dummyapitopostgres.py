from .helpers import fetch
from sqlalchemy import create_engine

STAGE = 'postgresql://dummy:dummy@0.0.0.0/dummyproject'
  
class DummyapiToPostgres():

    def __init__(self,columns, model :str, fetching_type :str = 'preview', connn_string :str = STAGE):
        self.model = model
        self.fetching_type = fetching_type 
        self.db = create_engine(connn_string)
        self.columns = columns
    
    def execute(self):
        # fetch data out of dummyapi
        data = fetch.dummyapi(model=self.model, fetching_type=self.fetching_type)
        data.rename(columns = self.columns, inplace=True)
        data = data[list(self.columns.values())]

        # Data validation, only indicated validation rules have been applyed
        data.drop_duplicates(subset=['id'])
        if ('owners' in [col for col in data]):
            data = data[data.owner.notnull()]
        if ('likes' in [col for col in data]):
            data = data[data.likes>=0]

        # Load data into dw
        with self.db.connect() as connection:
            data.to_sql(self.model, con=connection, schema='dw', if_exists='append', index=False)

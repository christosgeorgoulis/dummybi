import requests
import pandas as pd
from pandas.io.json import json_normalize


APP_ID = '6249679fc01f65f193457ec8'

DUMMYAPI_BASE = "https://dummyapi.io/data/v1/"
HEADERS = {
  'app-id': APP_ID
}
PAYLOAD={}


def dummyapi(model :str, fetching_type :str = 'preview') -> list():
    """
    Fetch data from dammy api and return as normalized dataframe.

    Args:
        model (str): Name of the model e.g. 'user', 'post', 'comment'
        fetching_type (str): 'full' stands for all model's columns asked, so fetching by id is needed.

    Returns:
        List[tuple]: The nomralized data of the wanted model.
    """

    preview = requests.request(
        "GET", 
        f"{DUMMYAPI_BASE}/{model}?page=1&limit=3", 
        headers=HEADERS, data=PAYLOAD
        )
    print(preview.json())
    
    if fetching_type == 'full':
        is_first_iteretion = True
        for row in preview.json()['data']:
            response = requests.request(
                "GET",
                f"{DUMMYAPI_BASE}/{model}/{row['id']}",
                headers=HEADERS, data=PAYLOAD
                )
            print(response.json())
            
            row_df = json_normalize(response.json())

            if is_first_iteretion:
                data = pd.DataFrame(columns=[col for col in row_df])
                is_first_iteretion = False

            data = data.append(row_df)
    else:
        data = json_normalize(preview.json()['data'])
      
    return data


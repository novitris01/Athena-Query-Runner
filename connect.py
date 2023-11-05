import boto3
import time

## Setup boto3 client
profile = 'document'
boto3.setup_default_session(profile_name=profile)
athena_client = boto3.client(
    'athena'
)

## Read the sql files and store it into list of strings
sql_file_path = 'updated_analysis.sql'
list_of_sqls = []
database = "prededup_enriched"

try:
    with open(sql_file_path, 'r') as sql_file:
        sql_content = sql_file.read()
        list_of_sqls = sql_content.split(";")
    print(sql_content)
except FileNotFoundError:
    print(f"File not found: {sql_file_path}")
except Exception as e:
    print(f"An error occurred: {str(e)}")

# Loop inside the list of sqls and execute each sql
totalQuery = 0

for idx, sql in enumerate(list_of_sqls):
    sql = sql.strip()
    if len(sql) < 1:
        continue

    print(f"{idx}:")
    print(sql + "\n\n")

    query_response = athena_client.start_query_execution(
        QueryString=sql,
        QueryExecutionContext={"Database": database}
    )

    while True:
        try:
            athena_client.get_query_results(
                QueryExecutionId=query_response["QueryExecutionId"]
            )
            break
        except Exception as err:
            if "not yet finished" in str(err):
                print("not yet finished")
                time.sleep(10)
            else:
                print(query)
                raise err
        totalQuery += 1

print(f"Total succesfull queries: {totalQuery}")


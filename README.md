# Athena Query Runner

The Athena Query Runner is a Python script that enables you to execute SQL queries in AWS Athena, a serverless interactive query service. This script reads SQL files, splits them into individual queries, and submits them to Athena for execution. It handles query execution, status polling, and tracks the number of successful queries.

## Prerequisites

Before running the script, make sure you have the following prerequisites in place:

- **AWS Account**: You need an AWS account with the necessary permissions to run Athena queries.

- **Boto3 Configuration**: Ensure that you have configured Boto3 with your AWS credentials and profile. You can set up your AWS credentials in the AWS CLI or use environment variables.

## Usage

1. **Clone the Repository**: Clone this repository to your local machine.

2. **Install Dependencies**: Install the required Python libraries using `pip`:

   ```bash
   pip install boto3
   ```

3. **AWS Profile Configuration and Login**:

   ```bash
   aws sso login --profile=document
   ```
4. Update the `profile` and `sql_file_path` variables as needed.
   - `profile`: AWS profile name that you want to use for accessing Athena.
   - `sql_file_path`: The path to the SQL file containing your queries.
   
5. **Execute the `generate_sql_script.py`**:

   - The script will read the SQL query template (`analysis.sql`) and generate new SQL scripts with updated parameters (`updated_analysis.sql`), such as the posting date and table name.

   - Update these parameters accordingly:

     - `@partition_1`
     - `@table_name`
     - `@date_range_start`
     - `@date_range_end`

   - Execute the script:

     ```bash
     python generate_sql_script.py
     ```

6. **Execute `connect.py`**:

   - After generating a file named `updated_analysis.sql`, ensure that the file is in the same directory. Each SQL query should be separated by a semicolon (`;`).

   - The script will read the SQL queries from the file, execute each query one by one, and provide progress updates.

   ```bash
   python connect.py
   ```

**Results**: The total number of successfully executed queries will be displayed at the end of execution.

Feel free to modify and adapt this script according to your needs. Happy querying!

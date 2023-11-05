def replace_parameters_in_sql_file(input_sql_file_path, output_sql_file_path, parameters):
    try:

        with open(input_sql_file_path, 'r') as input_file:
            sql_content = input_file.read()

        updated_sql_content = sql_content
        for parameter_name, new_value in parameters.items():
            updated_sql_content = updated_sql_content.replace(parameter_name, new_value)

        with open(output_sql_file_path, 'w') as output_file:
            output_file.write(updated_sql_content)

        print(f"Parameters replaced and saved in '{output_sql_file_path}':")
        for parameter_name, new_value in parameters.items():
            print(f"{parameter_name}: '{new_value}'")

    except Exception as e:
        print(f"An error occurred: {str(e)}")

# Example usage:
input_sql_file_path = 'analysis.sql'  # Replace with the path to your input SQL file
output_sql_file_path = 'updated_analysis.sql'  # Replace with the desired output file path

# Define the parameters and their new values
parameters = {
    '@partition_1': '\'2023-10-10-2023-21\'',
    '@table_name': '2023_10_10',
    '@date_range_start': '\'2023-09-10\'',
    '@date_range_end': '\'2023-10-10\''
}

replace_parameters_in_sql_file(input_sql_file_path, output_sql_file_path, parameters)
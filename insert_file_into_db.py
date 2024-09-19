import os
import subprocess


def load_db_from_file(db_name, db_user, db_password, db_host, db_port, file_path):
    os.environ['PGPASSWORD'] = db_password
    drop_db_command = f'dropdb -U {db_user} -h {db_host} -p {db_port} {db_name}'
    subprocess.run(drop_db_command, shell=True)
    create_db_command = f'createdb -U {db_user} -h {db_host} -p {db_port} {db_name}'
    subprocess.run(create_db_command, shell=True)
    load_data_command = f'psql -U {db_user} -h {db_host} -p {db_port} -d {db_name} < {file_path}'
    subprocess.run(load_data_command, shell=True)


load_db_from_file('postgres', 'postgres', 'fixremontadmin', 'localhost', '5432', 'dump.sql')

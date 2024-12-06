import os
import subprocess
from dotenv import load_dotenv

load_dotenv()


def load_db_from_file(db_name, db_user, db_password, db_host, db_port, file_path):
    os.environ['PGPASSWORD'] = db_password
    drop_db_command = f'dropdb -U {db_user} -h {db_host} -p {db_port} {db_name}'
    subprocess.run(drop_db_command, shell=True)
    create_db_command = f'createdb -U {db_user} -h {db_host} -p {db_port} {db_name}'
    subprocess.run(create_db_command, shell=True)
    load_data_command = f'psql -U {db_user} -h {db_host} -p {db_port} -d {db_name} < {file_path}'
    subprocess.run(load_data_command, shell=True)


db_name = os.getenv('DB_NAME')
db_user = os.getenv('DB_USERNAME')
db_password = os.getenv('DB_PASSWORD')
db_host = os.getenv('DB_HOST', 'localhost')
db_port = os.getenv('DB_PORT', '5432')

load_db_from_file(db_name, db_user, db_password, db_host, db_port, 'dump.sql')

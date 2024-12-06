import os
import subprocess
from dotenv import load_dotenv

load_dotenv()


def dump_db_to_file(db_name, db_user, db_password, db_host, db_port, file_path):
    os.environ['PGPASSWORD'] = db_password
    command = f'pg_dump -U {db_user} -h {db_host} -p {db_port} {db_name} > {file_path}'
    subprocess.run(command, shell=True)


db_name = os.getenv('DB_NAME')
db_user = os.getenv('DB_USERNAME')
db_password = os.getenv('DB_PASSWORD')
db_host = os.getenv('DB_HOST', 'localhost')
db_port = os.getenv('DB_PORT', '5432')

dump_db_to_file(db_name, db_user, db_password, db_host, db_port, 'dump.sql')

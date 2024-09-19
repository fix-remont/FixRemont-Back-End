import os
import subprocess


def dump_db_to_file(db_name, db_user, db_password, db_host, db_port, file_path):
    os.environ['PGPASSWORD'] = db_password
    command = f'pg_dump -U {db_user} -h {db_host} -p {db_port} {db_name} > {file_path}'
    subprocess.run(command, shell=True)


dump_db_to_file('postgres', 'postgres', 'fixremontadmin', 'localhost', '5432', 'dump.sql')

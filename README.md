# FixRemont-Back-End

## Description

This is a back-end part of the FixRemont project.

## Installation

1. Clone the repository
2. Run ```pip install -r requirements.txt``` to install all the dependencies
3. Create ```.env``` file in the root directory of the project
4. Add the following variables to the ```.env``` file:
    - ```DATABASE_NAME``` - name of the database
    - ```DATABASE_USER``` - username for the database
    - ```DATABASE_PASSWORD``` - password for the database
    - ```DATABASE_HOST``` - host of the database (default: ```localhost```)
    - ```DATABASE_PORT``` - port of the database (default: ```5432```)
    - ```JWT_SECRET``` - secret key for JWT (not implemented yet)
    - ```JWT_EXPIRES_IN``` - expiration time for JWT (not implemented yet)
    - ```JWT_COOKIE_EXPIRES_IN``` - expiration time for JWT cookie (not implemented yet)

## IMPORTANT NOTE:

For now, ```.env``` file must be created in the root directory of the project (not on top level).

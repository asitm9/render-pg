# Download docker compose file
wget https://raw.githubusercontent.com/prest/prest/main/docker-compose-prod.yml -O docker-compose.yml

# Up (run) PostgreSQL and prestd
docker-compose up
# Run data migration to create user structure for access (JWT)
docker-compose exec prest prestd migrate up auth

# Create user and password for API access (via JWT)
## user: prest
## pass: prest
docker-compose exec postgres psql -d prest -U prest -c "INSERT INTO prest_users (name, username, password) VALUES ('pREST Full Name', 'prest', MD5('prest'))"
# Check if the user was created successfully (by doing a select on the table)
docker-compose exec postgres psql -d prest -U prest -c "select * from prest_users"

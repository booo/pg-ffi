should = require "should"

describe "pg-ffi", ->
  pq = require ".."

  describe "PQconnectdb", ->
    it "should connect to a database without error", ->
      conn = pq.PQconnectdb "postgres://postgres@localhost"
    it "should return a PQconnection pointer", ->
      conn = pq.PQconnectdb "postgres://postgres@localhost"
      status = pq.PQstatus conn
      status.should.equal pq.CONNECTION_OK

  describe "PQstatus", ->
    it "should return a status code when connection string is bad", ->
      conn = pq.PQconnectdb "this is foo bar"
      status = pq.PQstatus conn
      status.should.equal pq.CONNECTION_BAD

  describe "PQerrorMessage", ->
    it "should return a proper error message on error", ->
      conn = pq.PQconnectdb "this is foo bar"
      message = pq.PQerrorMessage conn
      message.should.equal(
        'missing "=" after "this" in connection info string\n'
      )

  describe "PQlibVersion", ->
    it "should return an integer as version", ->
      pq.PQlibVersion().should.equal 90203

  describe "PQexec", ->
    it "should execute a SQL statement", ->
      conn = pq.PQconnectdb "postgres://postgres@localhost"
      result = pq.PQexec conn, "SELECT 'foo'"
      status = pq.PQresultStatus result
      status.should.equal pq.PGRES_TUPLES_OK
      (pq.PQresStatus status).should.equal "PGRES_TUPLES_OK"
      (pq.PQgetvalue result, 0, 0).should.equal "foo"

  describe "PQntuples", ->
    it "should return the number of tuples", ->
  describe "PQnfields", ->
    it "should return the number of columns (fields)", ->
  describe "PQfname", ->
    it "should return the name of a column", ->
  describe "PQfnumber", ->
    it "should return the index of a column", ->
  describe "PQgetvalue", ->
    it "should return the value of a index i, j", ->
  describe "PQexecParams", ->
    it "should exec a SQL and pass parameters separately from SQL", ->

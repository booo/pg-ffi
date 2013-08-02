should = require "should"

describe "pg-ffi", ->

  pq = require ".."
  conn = null
  result = null

  beforeEach ->
    conn = pq.PQconnectdb "postgres://postgres@localhost"
  afterEach ->
    if conn then pq.PQfinish conn
    if result then pq.PQclear result

  describe "PQconnectdb", ->
    it "should connect to a database without error", ->
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

  describe.skip "PQlibVersion", ->
    it "should return an integer as version", ->
      pq.PQlibVersion().should.equal 90203

  describe "PQexec", ->
    it "should execute a SQL statement", ->
      result = pq.PQexec conn, "SELECT 'foo'"
      status = pq.PQresultStatus result
      status.should.equal pq.PGRES_TUPLES_OK
      (pq.PQresStatus status).should.equal "PGRES_TUPLES_OK"
      (pq.PQgetvalue result, 0, 0).should.equal "foo"

  describe "functions working with PGresult", ->

    beforeEach ->
      result = pq.PQexec conn, "SELECT 'foo' AS foo, 'bar' AS bar"

    describe "PQntuples", ->
      it "should return the number of tuples", ->
    describe "PQnfields", ->
      it "should return the number of columns (fields)", ->
        (pq.PQnfields result). should.equal 2
    describe "PQfname", ->
      it "should return the name of a column", ->
        (pq.PQfname result, 0).should.equal "foo"
    describe "PQfnumber", ->
      it "should return the index of a column", ->
        (pq.PQfnumber result, "bar").should.equal 1
      it "should return -1 if column does not exist", ->
        (pq.PQfnumber result, "baz").should.equal -1
    describe "PQgetvalue", ->
      it "should return the value of a index i, j", ->
        (pq.PQgetvalue result, 0, 0).should.equal "foo"

  describe "PQexecParams", ->
    it "should exec a SQL and pass parameters separately from SQL", ->
      result = pq.PQexecParams conn,
        "SELECT $1::text, $2::text, $3::text;",
        3,
        [],
        ["foo", "bar", "baz"],
        [],
        [],
        0
      (pq.PQresultStatus result).should.equal pq.PGRES_TUPLES_OK

  describe "PQprepare", ->
    it "should prepare a statement for execution", ->
      result = pq.PQprepare conn,
        "prepared_test_statement",
        "SELECT $1::text AS foo, $2::text AS bar;",
        2,
        null
      (pq.PQresultStatus result).should.equal pq.PGRES_COMMAND_OK

  describe "PQexecPrepared", ->
    it "should execute a prepared statement", ->
      result = pq.PQprepare conn,
        "prepared_test_statement",
        "SELECT $1::text AS foo, $2::text AS bar;",
        2,
        null
      (pq.PQresultStatus result).should.equal pq.PGRES_COMMAND_OK

      result = pq.PQexecPrepared conn,
        "prepared_test_statement",
        2,
        ["foo", "bar"],
        [],
        []
        0
      (pq.PQresultStatus result).should.equal pq.PGRES_TUPLES_OK

ffi = require "ffi"
ref = require "ref"
refArray = require "ref-array"

functions =
  PQconnectdb: ["pointer", ["string"]]
  PQstatus: ["int", ["pointer"]]
  PQtransactionStatus: ["int", ["pointer"]]
  PQparameterStatus: ["string", ["pointer", "string"]]
  PQfinish: ["void", ["pointer"]]
  PQreset: ["void", ["pointer"]]
  PQping: ["pointer", ["string"]]
  PQdb: ["string", ["pointer"]]
  PQerrorMessage: ["string", ["pointer"]]
  PQexec: ["pointer", ["pointer", "string"]]
  PQresultStatus: ["pointer", ["pointer"]]
  PQresStatus: ["string", ["pointer"]]
  PQclear: ["void", ["pointer"]]
  PQntuples: ["int", ["pointer"]]
  PQnfields: ["int", ["pointer"]]
  PQfname: ["string", ["pointer", "int"]]
  PQfnumber: ["int", ["pointer", "string"]]
  PQgetvalue: ["string", ["pointer", "int", "int"]]
  PQexecParams: ["pointer", [
    "pointer", # PGconn *conn
    "string", # const char *command,
    "int" # int nParams,
    refArray("int"), # const Oid *paramTypes
    refArray("string"), # char * const *paramValues
    refArray("int"), # const int * paramLengths
    refArray("int"), #const int *papramFormats
    "int", # int resultFormat
    ]
  ]
  PQprotocolVersion: ["int", ["pointer"]]
  PQserverVersion: ["int", ["pointer"]]
  PQlibVersion: ["int", []]

pq = ffi.Library "libpq", functions

(require "./enums")(pq)

module.exports = pq


#conn = pq.PQconnectdb "postgresql://postgres@localhost:5432/postgres"
#status = pq.PQstatus conn
#console.log "PQerrorMessage: #{pq.PQerrorMessage conn}"
#result = pq.PQexec conn, "SELECT NOW() as then;"
#console.log "PQresultStatus: #{pq.PQresStatus pq.PQresultStatus result}"
#console.log "Number of rows (tuples): #{ pq.PQntuples result }"
#console.log "Number of columns (fields): #{ pq.PQnfields result }"
#console.log "Columns: " + (pq.PQfname result, i for i in [0...(pq.PQnfields result)]).join ", "
#console.log "Number of column 'then' is " + pq.PQfnumber result, "then"
#for i in [0...(pq.PQntuples result)]
#  console.log (pq.PQgetvalue result, i, j for j in [0...(pq.PQnfields result)]).join ", "
#pq.PQclear result
#
#result = pq.PQexec conn, "CREATE TEMP TABLE foo (name text, age int, birthday date)"
#console.log "PQresultStatus: #{pq.PQresStatus pq.PQresultStatus result}"
#pq.PQclear result
#
#pq.PQexecParams conn,
#  "INSERT INTO foo (name, age, birthday) VALUES ($1, $2, $3);",
#  3,
#  [],
#  ["foo", "42", new Date().toISOString()],
#  [],
#  [],
#  0
#
#console.log "PQresultStatus: #{pq.PQresStatus pq.PQresultStatus result}"
#console.log "PQerrorMessage: #{pq.PQerrorMessage conn}"
#pq.PQclear result
#
#result = pq.PQexec conn, "SELECT * FROM foo;"
#console.log "PQerrorMessage: #{pq.PQerrorMessage conn}"
#console.log "PQresultStatus: #{pq.PQresStatus pq.PQresultStatus result}"
#console.log "Number of rows (tuples): #{ pq.PQntuples result }"
#console.log "Number of columns (fields): #{ pq.PQnfields result }"
#console.log "Columns: " + (pq.PQfname result, i for i in [0...(pq.PQnfields result)]).join ", "
#for i in [0...(pq.PQntuples result)]
#  console.log (pq.PQgetvalue result, i, j for j in [0...(pq.PQnfields result)]).join ", "
#pq.PQclear result
#pq.PQfinish conn

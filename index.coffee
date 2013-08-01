ffi = require "ffi"
ref = require "ref"
refArray = require "ref-array"

functions =
  PQconnectStart: ["pointer", ["string"]]
  PQconnectStartParams: ["pointer", [
    refArray("string"),
    refArray("string"),
    "int"
    ]
  ]
  PQconnectPoll: ["int", ["pointer"]]
  PQconnectdb: ["pointer", ["string"]]
  PQconnectdbParams: ["pointer", [
    refArray("string"),
    refArray("string"),
    "int"
    ]
  ]
  PQsetdbLogin: ["pointer", ["string", "string", "string", "string", "string",
    "string", "string"]]
  #PQsetdb: ["pointer", ["string", "string", "string", "string", "string"]]
  PQfinish: ["void", ["pointer"]]
  PQconndefaults: ["pointer", []]
  PQconninfoParse: ["pointer", ["string", refArray("string")]] # TODO check char **errmsg type
  PQconninfoFree: ["void", ["pointer"]]
  PQresetStart: ["int", ["pointer"]]
  PQresetPoll: ["int", ["pointer"]]
  PQreset: ["void", ["pointer"]]
  PQgetCancel: ["pointer", ["pointer"]]
  PQfreeCancel: ["void", ["pointer"]]
  PQcancel: ["int", ["pointer", "string", "int"]] # TODOcheck char *errbuf tpye
  PQrequestCancel: ["int", ["pointer"]]
  PQdb: ["string", ["pointer"]]
  PQuser: ["string", ["pointer"]]
  PQpass: ["string", ["pointer"]]
  PQhost: ["string", ["pointer"]]
  PQport: ["string", ["pointer"]]
  PQtty: ["string", ["pointer"]]
  PQoptions: ["string", ["pointer"]]
  PQstatus: ["int", ["pointer"]]
  PQtransactionStatus: ["int", ["pointer"]]
  PQparameterStatus: ["string", ["pointer", "string"]]
  PQprotocolVersion: ["int", ["pointer"]]
  PQserverVersion: ["int", ["pointer"]]
  PQerrorMessage: ["string", ["pointer"]]
  PQsocket: ["int", ["pointer"]]
  PQbackendPID: ["int", ["pointer"]]
  PQconnectionNeedsPassword: ["int", ["pointer"]]
  PQconnectionUsedPassword: ["int", ["pointer"]]
  PQclientEncoding: ["int", ["pointer"]]
  PQsetClientEncoding: ["int", ["pointer", "string"]]
  PQgetssl: ["void", ["pointer"]]
  PQinitSSL: ["void", ["int"]]
  PQinitOpenSSL: ["void", ["int", "int"]]
  PQsetErrorVerbosity: ["int", ["pointer", "int"]]
  PQtrace: ["void", ["pointer", "int"]] #TODO check type of FILE *debug_port
  PQuntrace: ["void", ["pointer"]]
  #TODO PQnoticeReceiver
  #TODO PQnoticeProcessor
  #TODO PQregisterThreadLock
  PQexec: ["pointer", ["pointer", "string"]]
  PQexecParams: ["pointer", [
    "pointer", # PGconn *conn
    "string", # const char *command,
    "int" # int nParams,
    refArray("int"), # const Oid *paramTypes
    refArray("string"), # char * const *paramValues
    refArray("int"), # const int * paramLengths
    refArray("int"), #const int *papramFormats
    "int" # int resultFormat
    ]
  ]
  PQprepare: ["pointer", ["string", "string", "int", refArray("int")]]
  PQexecPrepared: ["pointer", [
    "pointer", "string", "int",
    refArray("string"), refArray("int"), refArray("int"), "int"
    ]
  ]
  PQsendQuery: ["int", ["string"]]
  PQping: ["pointer", ["string"]]
  PQresultStatus: ["pointer", ["pointer"]]
  PQresStatus: ["string", ["pointer"]]
  PQclear: ["void", ["pointer"]]
  PQntuples: ["int", ["pointer"]]
  PQnfields: ["int", ["pointer"]]
  PQfname: ["string", ["pointer", "int"]]
  PQfnumber: ["int", ["pointer", "string"]]
  PQgetvalue: ["string", ["pointer", "int", "int"]]
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

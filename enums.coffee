module.exports = (pq) ->
  for e, v of enums
    for constant, i in v
      pq[constant] = i

enums =
  ConnStatusType: [
    "CONNECTION_OK",
    "CONNECTION_BAD",
    "CONNECTION_STARTED",
    "CONNECTION_MADE",
    "CONNECTION_AWAITING_RESPONSE",
    "CONNECTION_AUTH_OK",
    "CONNECTION_SETENV",
    "CONNECTION_SSL_STARTUP",
    "CONNECTION_NEEDED"
  ]
  PostgresPollingStatusType: [
    "PGRES_POLLING_FAILED",
    "PGRES_POLLING_READING",
    "PGRES_POLLING_WRITING",
    "PGRES_POLLING_OK",
    "PGRES_POLLING_ACTIVE"
  ]
  ExecStatusType: [
    "PGRES_EMPTY_QUERY",
    "PGRES_COMMAND_OK",
    "PGRES_TUPLES_OK",
    "PGRES_COPY_OUT",
    "PGRES_COPY_IN",
    "PGRES_BAD_RESPONSE",
    "PGRES_NONFATAL_ERROR",
    "PGRES_FATAL_ERROR",
    "PGRES_COPY_BOTH",
    "PGRES_SINGLE_TUPLE"
  ]
  PGTransactionStatusType: [
    "PQTRANS_IDLE",
    "PQTRANS_ACTIVE",
    "PQTRANS_INTRANS",
    "PQTRANS_INERROR",
    "PQTRANS_UNKNOWN"
  ]
  PGVerbosity: [
    "PQERRORS_TERSE",
    "PQERRORS_DEFAULT",
    "PQERRORS_VERBOSE"
  ]
  PGPing: [
    "PQPING_OK",
    "PQPING_REJECT",
    "PQPING_NO_RESPONSE",
    "PQPING_NO_ATTEMPT"
  ]

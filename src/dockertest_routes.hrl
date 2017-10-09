-define(ROUTES,
  [
    {'_', [
      { "/v1/dockertest/test", dockertest_handler, []}
    ]}
  ]
).

### Cloudwatch Logs error logs filter notify

<https://www.google.com/search?q=block+fields+webhook+slack&oq=block+fields+webhook+slack&aqs=chrome..69i57.5353j0j1&sourceid=chrome&ie=UTF-8>

### Add Pattern

```
{
  Pattern: "**match**",
  URL:     "https://hooks.slack.com/services/xxxxxxxxxxxxxxx",
},
```

Refreence match pattern: handler_test.go TestGlobMatchExample

### Build function for lambda

```
GOOS=linux go build -o main
```

### Testing

```
WEBHOOK_TEST_URL=https://hooks.slack.com/services/xxxxxxxxxxxxxxxxx
cd handler; go test -v .
```

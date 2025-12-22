import http from "node:http";

const port = Number(process.env.PORT || "5050");

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader("content-type", "application/json");
  res.end(JSON.stringify({ ok: true, path: req.url, ts: new Date().toISOString() }));
});

server.listen(port, () => {
  console.log(`Example service listening on :${port}`);
});

const express = require("express");
const path = require("path");

const PORT = 3000;
const STATIC_ASSETS_PATH = path.resolve(`${__dirname}/../../static`);

const app = express();

const startTime = process.hrtime();

// Serve front end assets which have been built by webpack
app.use("/static", express.static(STATIC_ASSETS_PATH));

app.get("/", (request, response) => {
	response.send(`
<!DOCTYPE html>
<html>
	<body>
		<div id="container"></div>
		<script src="/static/bundle.js"></script>
	</body>
</html>
	`);
});

app.listen(PORT, '0.0.0.0', () => {
	const diff = process.hrtime(startTime);
	const startupTime = (diff[0] * 1e9 + diff[1]) / 1e6; // Convert to milliseconds
	console.log(`Server started in ${startupTime.toFixed(2)}ms`);
	console.log(`Example app listening on port ${PORT}.\n\nLoad it in your browser at http://localhost:${PORT}`);
});

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chroogle</title>

<style>
body {
  font-family: sans-serif;
  text-align: center;
  margin-top: 120px;
}

h1 {
  font-size: 36px;
  margin-bottom: 20px;
}

input {
  width: 80%;
  padding: 14px;
  font-size: 18px;
  border-radius: 8px;
  border: 1px solid #ccc;
}

button {
  padding: 12px 20px;
  font-size: 18px;
  margin-top: 12px;
  border-radius: 8px;
  border: none;
  background: black;
  color: white;
}
</style>
</head>

<body>

<h1>Chroogle</h1>

<input id="search" placeholder="検索またはURL入力">
<br>
<button onclick="go()">検索</button>

<script>
function go() {
  let input = document.getElementById("search").value;

  if (!input.includes(".")) {
    window.location.href =
      "https://www.google.com/search?q=" +
      encodeURIComponent(input);
  } else {
    if (!input.startsWith("http")) {
      input = "https://" + input;
    }
    window.location.href = input;
  }
}
</script>

</body>
</html>

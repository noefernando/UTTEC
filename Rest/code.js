const nuevoPost = {
  title: "Mi primer post",
  body: "Contenido del post",
  userId: 1
};

fetch("https://jsonplaceholder.typicode.com/posts", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    "Authorization": "Bearer 12345abcde"
  },
  body: JSON.stringify(nuevoPost)
})
.then(res => res.json())
.then(data => {
    console.log("Respuesta del servidor:", data);
    document.getElementById("lista").innerHTML = `<li>${JSON.stringify(data)}</li>`;
})
.catch(err => console.error(err));
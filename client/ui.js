document.addEventListener("DOMContentLoaded", () => {
  App.init();
});

const mintForm = document.querySelector("#mintForm");
mintForm.addEventListener("submit", (e) => {  
  e.preventDefault();
  const nombre = mintForm["nombre"].value;
  const cant = mintForm["cant"].value;
  App.createRandomLip(nombre, cant);  
});

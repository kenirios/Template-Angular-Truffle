document.addEventListener("DOMContentLoaded", () => {
  App.init();
});

/**
 * Task form
 */
const mintForm = document.querySelector("#mintForm");

mintForm.addEventListener("submit", (e) => {
  e.preventDefault();
  const title = mintForm["title"].value;
  const description = mintForm["description"].value;
  App.createTask(title, description);
});

window.addEventListener("DOMContentLoaded", (event) => {
    getVisitCount();
});

const localfunctionApi = "http://localhost:7071/api/todoitems/Counter/Counter";
const functionApi = "https://getresumecountercelleray.azurewebsites.net/api/todoitems/Counter/Counter?code=64YWdFazRDDMXV7jJssYpez2tJ13saDcxkDHREspOEniAzFuifw18Q%3D%3D"

const getVisitCount = () => {
    let count = "gello";
    fetch(functionApi)
        .then((response) => {
            return response.json();
        })
        .then(response => {
            count = response;
            //response.Body.count;
            document.getElementById('counter').innerText = count;
        })
    return count;
}


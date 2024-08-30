window.addEventListener("DOMContentLoaded", (event) => {
  getVisitCount();
});

const functionApi = "http://localhost:7071/api/todoitems/Counter/Counter";


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
    
    
    
      
//       document.getElementById("counter").innerText = count;
//     })
    
//   return count;
// }



// const getVisitCount = () => {
//     let count = 30;
//     fetch(functionApi)
//       .then((response) => {
//         return response.json;
//       })
//       .then((response) => {
//         console.log("Website called function API.");
//         count = response.Body;
//         document.getElementById("counter").innerText = count;
//       })
//       .catch(function (error) {
//         console.log(error);
//       });
//     return count;
//   }
  
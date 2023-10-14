document.getElementById("signupForm").addEventListener("submit", function (e) {
    e.preventDefault(); // Prevent the default form submission
  
    // Get the form data
    const userName = document.getElementById("userName").value;
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
  
    // Create an object with the form data
    const formData = {
      name: userName,
      email: email,
      password: password,
    };
  
    // Make a POST request to the API
    fetch(`http://127.0.0.1:8000/register/`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(formData),
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data.message);
        if (data.message == "Added Successfully!!") {
          window.location.href = `http://127.0.0.1:5500/index.html`;
        } else {
          alert(data.message);
        }
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  });
  
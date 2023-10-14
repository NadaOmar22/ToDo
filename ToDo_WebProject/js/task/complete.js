export function completeTask(taskId, email) {
    fetch("http://127.0.0.1:8000/complete_task/", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ email: email, id: taskId }),
    })
        .then((response) => response.json())
        .then((data) => {
            console.log("Task completed:", data);
            const cardTitle = document.getElementById(taskId);
            cardTitle.classList.add("card-title-completed-task");
        })
        .catch((error) => {
            console.error("Error:", error);
        });
}
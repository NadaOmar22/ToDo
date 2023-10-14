export function deleteTask(taskId, email) {
    fetch("http://127.0.0.1:8000/delete_task/", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ email: email, id: taskId }),
    })
        .then((response) => response.json())
        .then((data) => {
            console.log("Task deleted:", data);

            const currentCard = document.getElementById(`card${taskId}`);
            currentCard.style.display = "none";

            // Update the total task count
            const todoCountElement = document.querySelector(".todo-count span");
            todoCountElement.textContent = parseInt(todoCountElement.textContent) - 1;
        })
        .catch((error) => {
            console.error("Error:", error);
        });
}
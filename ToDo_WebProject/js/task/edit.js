export function editTask(taskId, title, description, email) {
    fetch("http://127.0.0.1:8000/edit_task/", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            email: email,
            id: taskId,
            title: title,
            description: description
        }),
    })
        .then((response) => response.json())
        .then((data) => {
            console.log("Task edited:", data);
            const cardTitle = document.getElementById(taskId);
            const cardDescription = document.getElementById(`${taskId}description`);

            cardTitle.textContent = title;
            cardDescription.textContent = description;
        })
        .catch((error) => {
            console.error("Error:", error);
        });
}
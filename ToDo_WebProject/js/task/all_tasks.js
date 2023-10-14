import { completeTask } from './complete.js';
import { deleteTask } from './delete.js';
import { editTask } from './edit.js';

function fetchUserTasks() {
    const urlParams = new URLSearchParams(window.location.search);
    const email = urlParams.get('email');

    fetch("http://127.0.0.1:8000/all_tasks/", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({ email: email }),
    })
        .then((response) => response.json())
        .then((data) => {
            const tasks = data;
            const todoCountElement = document.querySelector(".todo-count span");
            todoCountElement.textContent = tasks.length;

            tasks.forEach((task) => {
                createCard(task, email);
            });
        })
        .catch((error) => {
            console.error("Error:", error);
        });
}

document.addEventListener("DOMContentLoaded", function () {
    fetchUserTasks();
});

document.querySelector('.add-button').addEventListener("click", function () {
    const addDialog = document.getElementById("addDialog");
    const saveButton = document.getElementById("saveNewTask");
    const cancelAddButton = document.getElementById("cancelAddButton");
    const titleInput = document.getElementById("title");
    const descriptionInput = document.getElementById("description");

    addDialog.style.display = "block";
    saveButton.addEventListener("click", () => {
        const title = titleInput.value;
        const description = descriptionInput.value;

        const urlParams = new URLSearchParams(window.location.search);
        const email = urlParams.get('email');

        // Call the create task API endpoint with user email, title, and description
        fetch("http://127.0.0.1:8000/create_task/", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                email: email,
                title: title,
                description: description
            }),
        })
            .then((response) => response.json())
            .then((data) => {
                // Handle the response accordingly
                console.log("Task created:", data);

                fetchUserTasks();

                // Reset the input fields and close the dialog
                titleInput.value = "";
                descriptionInput.value = "";
                
                addDialog.style.display = "none";
            })
            .catch((error) => {
                console.error("Error:", error);
            });
    });

    cancelAddButton.addEventListener("click", () => {
        // Reset the input fields and close the dialog
        titleInput.value = "";
        descriptionInput.value = "";
        addDialog.style.display = "none";
    });
});

function createCard(task, email) {
    const cardContainer = document.querySelector(".card-container");

    const card = document.createElement("div");
    card.classList.add("card");
    card.setAttribute("id", `card${task.id}`);

    const cardTitle = document.createElement("div");
    cardTitle.classList.add("card-title");
    cardTitle.setAttribute("id", task.id);
    cardTitle.textContent = task.title;

    const cardDescription = document.createElement("div");
    cardDescription.classList.add("card-description");
    cardDescription.setAttribute("id", `${task.id}description`);
    cardDescription.innerHTML = `<p>${task.description}</p>`;

    const cardIcons = document.createElement("div");
    cardIcons.classList.add("card-icons");

    const editIcon = document.createElement("i");
    editIcon.classList.add("fas", "fa-edit");
    editIcon.addEventListener("click", () => {
        const editDialog = document.getElementById("editDialog");
        const saveChangesButton = document.getElementById("saveChangesButton");
        const cancelButton = document.getElementById("cancelButton");
        const editTitleInput = document.getElementById("editTitle");
        const editDescriptionInput = document.getElementById("editDescription");
        editDialog.style.display = "block";
        saveChangesButton.addEventListener("click", () => {
            editTask(task.id, editTitleInput.value, editDescriptionInput.value, email);
            editDialog.style.display = "none";
        });
        cancelButton.addEventListener("click", () => {
            editDialog.style.display = "none";
        });
    });

    const deleteIcon = document.createElement("i");
    deleteIcon.classList.add("fas", "fa-trash");
    deleteIcon.addEventListener("click", () => {
        deleteTask(task.id, email);
    });

    const completeIcon = document.createElement("i");
    completeIcon.classList.add("fas", "fa-check");
    completeIcon.addEventListener("click", () => {
        completeTask(task.id, email);
    });

    cardIcons.append(editIcon, deleteIcon, completeIcon);
    card.append(cardTitle, cardDescription, cardIcons);
    cardContainer.appendChild(card);

}

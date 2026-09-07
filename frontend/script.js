const API_URL = "http://4.224.6.128";

const form = document.getElementById("userForm");
const message = document.getElementById("message");
const usersTable = document.getElementById("usersTable");


form.addEventListener("submit", async function (event) {

    event.preventDefault();

    const name = document.getElementById("name").value;
    const age = Number(document.getElementById("age").value);

    try {

        const response = await fetch(`${API_URL}/users`, {
            method: "POST",

            headers: {
                "Content-Type": "application/json"
            },

            body: JSON.stringify({
                name: name,
                age: age
            })
        });

        if (!response.ok) {
            throw new Error("Failed to create user");
        }

        const data = await response.json();

        message.textContent = data.message;

        form.reset();

        loadUsers();

    } catch (error) {

        message.textContent = "Failed to create user";
        console.error(error);

    }

});


async function loadUsers() {

    try {

        const response = await fetch(`${API_URL}/users`);

        if (!response.ok) {
            throw new Error("Failed to fetch users");
        }

        const users = await response.json();

        usersTable.innerHTML = "";

        users.forEach(user => {

            const row = document.createElement("tr");

            row.innerHTML = `
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.age}</td>
            `;

            usersTable.appendChild(row);

        });

    } catch (error) {

        console.error(error);

    }

}


loadUsers();
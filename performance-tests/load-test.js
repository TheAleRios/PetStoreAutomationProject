import http from 'k6/http';
import { check, sleep } from 'k6';
import { ENDPOINTS } from './config.js';

const env = __ENV.ENV || 'prod';
let baseUrl = '';

const imageData =  open('./images/cat.jpg','b');

if (env === 'prod') {
    baseUrl = __ENV.BASE_URL_PROD;
} else if (env === 'staging') {
    baseUrl = __ENV.BASE_URL_STAGING;
} else if (env === 'local') {
    baseUrl = __ENV.BASE_URL_LOCAL;
} else {
    console.error(`Unknown environment: ${env}`);
    sleep(1); 
}

const petData = {
    id: "11",
    name: "doggie",
    category: {
        id: 1,
        name: "Dogs",
    },
    photoUrls: [
        "string",
    ],
    tags: [
        {
            id: 0,
            name: "string",
        }
    ],
    status: "available",
};

const orderData = {
    "id": 5,
    "petId": 5,
    "quantity": 7,
    "shipDate": "2025-01-08T02:05:53.673Z",
    "status": "approved",
    "complete": true
  }

  const usersListData = [
    {
      "id": 20,
      "username": "Emma",
      "firstName": "Emma",
      "lastName": "Bunton",
      "email": "ema@email.com",
      "password": "12345",
      "phone": "12345",
      "userStatus": 1
    },
    {
      "id": 21,
      "username": "MelB",
      "firstName": "Mel",
      "lastName": "B",
      "email": "melb@email.com",
      "password": "12345",
      "phone": "12345",
      "userStatus": 1
    },
    {
      "id": 22,
      "username": "MelC",
      "firstName": "Melanie",
      "lastName": "C",
      "email": "melc@email.com",
      "password": "12345",
      "phone": "12345",
      "userStatus": 1
    }
  ]

  const userData =   {
    "id": 22,
    "username": "theUserAle",
    "firstName": "Ale",
    "lastName": "Rios",
    "email": "ale@email.com",
    "password": "12345",
    "phone": "12345",
    "userStatus": 1
    }

export let options = {
    vus: 100, // Number of virtual users
    duration: '20s', // Test duration
};

export function getPetByStatus(status) {
    let res = http.get(`${baseUrl}${ENDPOINTS.findPetByStatus.replace('{status}', status)}`);
    check(res, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function addPet() {
    let res = http.post(`${baseUrl}${ENDPOINTS.addPet}`,JSON.stringify(petData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function findPetById(petId) {
    let res = http.get(`${baseUrl}${ENDPOINTS.findPetById.replace('{id}', petId)}`);
    check(res, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function updatePet() {
    let res = http.put(`${baseUrl}${ENDPOINTS.updatePet}`,JSON.stringify(petData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function deletePet() {
    let res1 = http.post(`${baseUrl}${ENDPOINTS.addPet}`,JSON.stringify(petData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res1, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);

    let res2 = http.del(`${baseUrl}${ENDPOINTS.deletePet}/${petData.id}`,{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res2, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function updatePetWithForm() {
    let res1 = http.post(`${baseUrl}${ENDPOINTS.addPet}`,JSON.stringify(petData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res1, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);

    let res2 = http.post(`${baseUrl}${ENDPOINTS.updatePetWithForm}/${petData.id}`,{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res2, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);

}

export function uploadImage() {

    let res1 = http.post(`${baseUrl}${ENDPOINTS.addPet}`,JSON.stringify(petData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res1, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);


    let res2 = http.post(
        `${baseUrl}${ENDPOINTS.uploadPetImage.replace('{id}',petData.id)}`,
        imageData,
        {
            headers:{
                'accept': 'application/json',
                'Content-Type': 'application/octet-stream',
            },
        }
    );
    check(res2, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function findByTags(tag) {
    let res = http.get(`${baseUrl}${ENDPOINTS.findPetByTags.replace('{tag}', tag)}`);
    check(res, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function storeInventory() {
    let res = http.get(`${baseUrl}${ENDPOINTS.storeInventory}`);
    check(res, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function getOrderById(orderId) {
    let res = http.get(`${baseUrl}${ENDPOINTS.getOrderById.replace('{id}',orderId)}`);
    check(res, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function addOrder() {
    let res = http.post(`${baseUrl}${ENDPOINTS.addOrder}`,JSON.stringify(orderData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function deleteOrder() {
    let res1 = http.post(`${baseUrl}${ENDPOINTS.addOrder}`,JSON.stringify(orderData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res1, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);

    let res2 = http.del(`${baseUrl}${ENDPOINTS.deleteOrder}/${orderData.id}`,{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res2, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
    
}

export function createUserWithList() {
    let res = http.post(`${baseUrl}${ENDPOINTS.createUserWithList}`,JSON.stringify(usersListData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function createUser() {
    let res = http.post(`${baseUrl}${ENDPOINTS.createUser}`,JSON.stringify(userData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function getUserByName() {
    let res1 = http.post(`${baseUrl}${ENDPOINTS.createUser}`,JSON.stringify(userData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res1, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);

    let res2 = http.get(`${baseUrl}${ENDPOINTS.getUserByName}/${userData.username}`,{
        headers: { 'Content-Type': 'application/json'},
    });       
    check(res2, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function updateUser() {
    let res1 = http.post(`${baseUrl}${ENDPOINTS.createUser}`,JSON.stringify(userData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res1, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);

    let res2 = http.put(`${baseUrl}${ENDPOINTS.updateUser}/${userData.username}`,JSON.stringify(userData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res2, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function deleteUser() {
    let res1 = http.post(`${baseUrl}${ENDPOINTS.createUser}`,JSON.stringify(userData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res1, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);

    let res2 = http.del(`${baseUrl}${ENDPOINTS.deleteUser}/${userData.username}`,{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res2, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function login() {
    let res1 = http.post(`${baseUrl}${ENDPOINTS.createUser}`,JSON.stringify(userData),{
        headers: { 'Content-Type': 'application/json'},
    });
    check(res1, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);

    let res2 = http.get(`${baseUrl}${ENDPOINTS.login.replace('{username}',userData.username).replace('{password}',userData.password)}`);
    check(res2, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export function logout() {
    let res = http.get(`${baseUrl}${ENDPOINTS.logout}`);
    check(res, {
        'status is 200': (r) => r.status === 200,
    });
    sleep(1);
}

export default function () {
  
getPetByStatus('available');
getPetByStatus('pending');
getPetByStatus('sold');
addPet();
findPetById(5);
updatePet();
deletePet();
updatePetWithForm();
uploadImage();
findByTags('tag2');
storeInventory();
addOrder();
deleteOrder();
createUserWithList();
createUser();
getUserByName();
updateUser();
deleteUser();
login();
logout();

}
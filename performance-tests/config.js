export const ENDPOINTS = {
    findPetByStatus: '/pet/findByStatus?status={status}',
    addPet: '/pet',
    findPetById: '/pet/{id}',
    updatePet: '/pet',
    deletePet: '/pet/{id}',
    updatePetWithForm: '/pet/{petId}',
    uploadPetImage: '/pet/{petId}/uploadImage',
    findPetByTags: '/pet/findByTags?tags={tag}',
    
    storeInventory: '/store/inventory',
    getOrderById: '/store/order/{orderId}',
    addOrder: 'store/order',
    deleteOrder: '/store/order/{orderId}',
    
    createUserWithList: '/user/createWithList',
    getUserByName: '/user/{username}',
    updateUser: ' /user/{username}',
    deleteUser: '/user/{username}',
    login: '/user/login?username={user}}&password={password}',
    logout: '/user/logout',
    createUser: '/user',
};
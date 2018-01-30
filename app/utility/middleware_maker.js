module.exports = (name, description, priority, action) => {
    const middleware = Object.create(null);
    middleware.name = name;
    middleware.description = description;
    middleware.priority = priority;
    middleware.action = action;

    return middleware;
};

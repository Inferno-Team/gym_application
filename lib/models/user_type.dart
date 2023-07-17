enum UserType { admin, manager, customer, trainer }

UserType typeResolver(String? type) => UserType.values.byName(type??'customer');

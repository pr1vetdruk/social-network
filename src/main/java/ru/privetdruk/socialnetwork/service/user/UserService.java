package ru.privetdruk.socialnetwork.service.user;

import ru.privetdruk.socialnetwork.domain.user.User;

public interface UserService {
    void save(User user);
    User findByLogin(String login);
    User findById(Long id);
    boolean isExist(String login);
}

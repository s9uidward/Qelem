package com.qelem.api.controller;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;
import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.methodOn;

import java.util.List;
import java.util.Optional;

import com.qelem.api.Repo.UserRepository;
import com.qelem.api.file.FileStorageConfiguration;
import com.qelem.api.file.StorageService;
import com.qelem.api.model.ChangePasswordModel;
import com.qelem.api.model.RegistrationForm;
import com.qelem.api.model.UserModel;
import com.qelem.api.model.UserModel.ROLE;
import com.qelem.api.resources.UserResources;
import com.qelem.api.resources.UserResourcesAssembler;
import com.qelem.api.util.PasswordException;
import com.qelem.api.util.UnauthorizedAccess;
import com.qelem.api.util.UserAlreadyExists;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.hateoas.CollectionModel;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.server.mvc.WebMvcLinkBuilder;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.minidev.json.parser.ParseException;

@RestController
@RequestMapping(path = "/api/v1/users", produces = "application/json")
@CrossOrigin(origins = "*")
@RequiredArgsConstructor
@Slf4j
public class UserRestController {
    private final UserRepository userRepository;
    @Autowired
    private final PasswordEncoder passwordEncoder;
    @Autowired
    private final StorageService storageService;
    @Autowired
    FileStorageConfiguration configuration;

    private UserModel loggedInUser() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username;
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        } else {
            username = principal.toString();
        }

        // finding the user from the user database based on the principal's name
        UserModel user = userRepository.findByUsername(username);
        return user;
    }

    /**
     * lists all the users in the system.
     * 
     * @param model
     * @return
     */
    @GetMapping(params = "all")
    public CollectionModel<UserResources> allUsers() {
        PageRequest pageable = PageRequest.of(0, 12,
                Sort.by("id").descending());
        List<UserModel> userModels = userRepository.findAll(pageable).getContent();
        CollectionModel<UserResources> userResources = new UserResourcesAssembler()
                .toCollectionModel(userModels);
        userResources.add(
                linkTo(methodOn(UserRestController.class).allUsers())
                        .withRel("all"));
        return userResources;

    }

    @GetMapping("/{id}")
    public EntityModel<UserModel> userById(@PathVariable("id") Long id) {
        Optional<UserModel> optUser = userRepository.findById(id);
        if (!optUser.isPresent()) {
            return null;
        }
        EntityModel<UserModel> userResource = EntityModel.of(optUser.get());
        WebMvcLinkBuilder linkTo = linkTo(methodOn(this.getClass()).userById(id));
        userResource.add(linkTo.withRel(String.format("Users  with id %s", id)));

        return userResource;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public UserModel postUser(@RequestBody RegistrationForm registrationForm) throws ParseException {
        log.debug("Register user with user form : {}", registrationForm);

        UserModel user = registrationForm.toUser(passwordEncoder);
        user.setProfilePicture(null);
        user.setRole("MEMBER");

        if (userRepository.existsByUsername(user.getUsername())) {
            log.error("User with username {} already exists", user.getUsername());
            throw new UserAlreadyExists();
        }

        log.debug("Saving user : {}", user);
        return userRepository.save(user);
    }

    @PutMapping(path = "/{id}", consumes = "application/json")
    public UserModel putUser(
            @PathVariable("id") Long id,
            @RequestBody UserModel userModel) {
        var isAuthorized = loggedInUser().getId().equals(id) || loggedInUser().getRole().equals("ADMIN");

        if (!isAuthorized) {
            log.error("User with id {} is not authorized to update user with id {}", loggedInUser().getId(), id);
            throw new UnauthorizedAccess("User is not authorized to update user");
        }

        userModel.setId(id);
        return userRepository.save(userModel);
    }

    @PatchMapping(path = "/changePassword/{id}", consumes = "application/json")
    public UserModel changePassword(@PathVariable("id") Long id,
            @RequestBody ChangePasswordModel user) {

        UserModel userModel = userRepository.findById(id).get();
        System.out.println("from database: " + userModel.getPassword());

        if ( passwordEncoder.encode(user.getOldPassword()).matches(userModel.getPassword()) ) {
            throw new PasswordException("Password doesn't match!");
        }
        userModel.setPassword(passwordEncoder.encode(user.getNewPassword()));
        return userRepository.save(userModel);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(code = HttpStatus.NO_CONTENT)
    public void deleteUser(@PathVariable("id") Long id) {
        var isAuthorized = loggedInUser().getId().equals(id) || loggedInUser().getRole().equals("ADMIN");

        if (!isAuthorized) {
            log.error("User with id {} is not authorized to update user with id {}", loggedInUser().getId(), id);
            throw new UnauthorizedAccess("User is not authorized to delete user");
        }

        try {
            userRepository.deleteById(id);
        } catch (EmptyResultDataAccessException e) {
        }
    }


    @PatchMapping(path="/{id}", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    public UserModel updateUser(
        @PathVariable("id") Long id,
        @RequestParam(value = "firstName", required = false) String firstName,
        @RequestParam(value = "lastName", required = false) String lastName,
        @RequestPart(value = "profile", required = false) MultipartFile file) {

            UserModel user = new UserModel();
            user.setId(id);
            user.setFirstName(firstName);
            user.setLastName(lastName);

            return updateUserHelper(id, user, file);

        }


    public UserModel updateUserHelper(Long id, UserModel user, MultipartFile file) {
        var isAuthorized = loggedInUser().getId().equals(id) || loggedInUser().getRole().equals("ADMIN");

        if (!isAuthorized) {
            log.error("User with id {} is not authorized to update user with id {}", loggedInUser().getId(), id);
            throw new UnauthorizedAccess("User is not authorized to update user");
        }

        if (file != null && !file.isEmpty()) {
            var fileName = storageService.store(file);
            user.setProfilePicture(fileName);
        }

        UserModel userModel = userRepository.findById(id).get();

        if (user.getFirstName() != null && !user.getFirstName().isEmpty()) {
            userModel.setFirstName(user.getFirstName());
        }
        if (user.getLastName() != null && !user.getLastName().isEmpty()) {
            userModel.setLastName(user.getLastName());
        }
        if (user.getRole() != null && !user.getRole().isEmpty()) {
            userModel.setRole(user.getRole());
        }
        if (user.getProfilePicture() != null && !user.getProfilePicture().isEmpty()) {
            userModel.setProfilePicture(user.getProfilePicture());
        }
        if (user.getVote() != null && !user.getVote().isEmpty()) {
            userModel.setVote(user.getVote());
        }

        UserModel res = userRepository.save(userModel);
        res.setPassword(null);
        return res;
    }
}
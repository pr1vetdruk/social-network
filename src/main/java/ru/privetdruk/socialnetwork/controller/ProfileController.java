package ru.privetdruk.socialnetwork.controller;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import ru.privetdruk.socialnetwork.domain.Publication;
import ru.privetdruk.socialnetwork.domain.PublicationDto;
import ru.privetdruk.socialnetwork.domain.user.User;
import ru.privetdruk.socialnetwork.service.ProfileService;
import ru.privetdruk.socialnetwork.util.ControllerUtils;
import ru.privetdruk.socialnetwork.util.ResponseStatusUtils;
import ru.privetdruk.socialnetwork.util.UriUtils;

import javax.validation.Valid;

@Controller
@RequestMapping("/id{user}")
public class ProfileController {
    private final ProfileService profileService;

    public ProfileController(ProfileService profileService) {
        this.profileService = profileService;
    }

    @GetMapping
    public String showProfile(@AuthenticationPrincipal User authorizedUser,
                              @RequestParam(required = false, defaultValue = "") String tag,
                              @PathVariable User user,
                              Model model,
                              @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) {
        ResponseStatusUtils.pageExistenceForObject(user);

        model.addAttribute("url", "/id" + user.getId());
        model.addAttribute("filter", tag);
        model.addAttribute("pagePublications", profileService.userPublicationList(user.getId(), authorizedUser.getId(), tag, pageable));
        model.addAttribute("pageOwner", user);
        model.addAttribute("isPageOwnerOnline", profileService.isUserOnline(user.getLogin()));

        return "profile";
    }

    @PostMapping("/publication/delete/")
    public String deletePublication(@AuthenticationPrincipal User authorizedUser, @RequestParam("id") Publication publication) {
        if (authorizedUser.equals(publication.getAuthor()))
            profileService.deletePublication(publication);
        return "redirect:/id" + publication.getAuthor().getId();
    }

    @GetMapping("/publications/{publication}/like")
    public String like(
            @AuthenticationPrincipal User authorizedUser,
            @PathVariable Publication publication,
            RedirectAttributes redirectAttributes,
            @RequestHeader(required = false) String referer
    ) {
        profileService.likePublication(authorizedUser, publication);

        return "redirect:" + UriUtils.previousAddress(redirectAttributes, referer);
    }

    @PostMapping
    public String addPublication(@AuthenticationPrincipal User authorizedUser,
                                 @PathVariable User user,
                                 @Valid PublicationDto publicationDto,
                                 BindingResult bindingResult,
                                 Model model,
                                 @RequestParam("image") MultipartFile image,
                                 @PageableDefault(sort = {"id"}, direction = Sort.Direction.DESC) Pageable pageable) {
        if (bindingResult.hasErrors()) {
            model.mergeAttributes(ControllerUtils.getErrors(bindingResult));
            model.addAttribute("url", "/id" + user.getId());
            model.addAttribute("pagePublications", profileService.userPublicationList(user.getId(), authorizedUser.getId(), null, pageable));
            model.addAttribute("pageOwner", user);
            return "profile";
        } else {
            profileService.savePublication(authorizedUser, publicationDto, image);
            return "redirect:/id" + user.getId();
        }
    }
}

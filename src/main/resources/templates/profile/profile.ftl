<#import "../parts/common.ftl" as common>
<#import "../parts/pager.ftl" as p>
<#include "../parts/security.ftl">

<@common.page>
    <#include "../parts/main-menu.ftl"/>

    <div class="col-3">
        <div class="card pt-2 pb-0 px-2">
            <img src="<#if pageOwner?? && pageOwner.personalData.avatarFileName??>/img/${pageOwner.personalData.avatarFileName}<#else>../../static/img/icon/camera_200.png</#if>"
                 class="card-img-top" alt="avatar">
            <div class="card-body">
                <#if authorizedUser.id != pageOwner.id>
                    <div class="row mb-2">
                        <a href="/id${pageOwner.id}/edit/" class="col btn pt-1"
                           style="font-size: 12.5px; height: 30px; background-color: #5181b8; color: #fff;">Написать сообщение</a>
                    </div>
                </#if>

                <div class="row">
                    <#if authorizedUser.id == pageOwner.id>
                        <a href="/id${pageOwner.id}/edit/" class="col-9 btn pt-1 mr-2"
                           style="font-size: 12.5px; height: 30px; background-color: #e5ebf1; color: #55677d;">Редактировать</a>
                    <#else>
                        <#if isSubscriber>
                            <a href="/id${pageOwner.id}/unsubscribe" class="col btn pt-1 mr-2"
                               style="font-size: 13px; height: 30px;  background-color: #5181b8; color: #fff">Отписаться</a>
                        <#else>
                            <a href="/id${pageOwner.id}/subscribe" class="col btn pt-1 mr-2"
                               style="font-size: 13px; height: 30px;  background-color: #5181b8; color: #fff">Подписаться</a>
                        </#if>
                    </#if>


                    <a href="#" class="btn col-2 ml-1 p-0" style="height: 30px; background-color: #e5ebf1; color: #55677d;">...</a>
                </div>
            </div>
        </div>
    </div>

    <div class="col">
        <#-- Информационный блок -->
        <div class="row mb-3">
            <div class="col pl-3 pt-2 bg-white border rounded">
                <#-- ФИ + статус Online/Offline -->
                <div class="row">
                    <div class="col">
                        <h5>${pageOwner.personalData.firstName} ${pageOwner.personalData.lastName}</h5>
                    </div>
                    <div class="col d-flex justify-content-end">
                        <p>
                            <#if isPageOwnerOnline>
                                Online
                            <#else>
                                Offline
                            </#if>
                        </p>
                    </div>
                </div>

                <div class="dropdown-divider"></div>

                <#-- Дата рождения -->
                <div class="row">
                    <div class="col-4">
                        <p class="mb-1">День рождения:</p>
                    </div>
                    <div class="col">
                        <p class="mb-1">${pageOwner.personalData.dateBirth?date('yyyy-MM-dd')}</p>
                    </div>
                </div>

                <#-- Город -->
                <div class="row">
                    <div class="col-4">
                        <p>Город:</p>
                    </div>
                    <div class="col">
                        <p>${pageOwner.personalData.city.name}</p>
                    </div>
                </div>

                <#-- Подробная информация -->
                <div class="row accordion" id="accordionInfo">
                    <div class="col-4"></div>
                    <div class="col">
                        <div id="heading">
                            <button class="btn btn-link collapsed pl-0" type="button" data-toggle="collapse"
                                    data-target="#collapse" aria-expanded="false"
                                    aria-controls="collapse"
                                    style="color: #2a6592; text-decoration: none; font-size: 14px">
                                Показать подробную информацию
                            </button>
                        </div>
                    </div>
                    <div class="w-100"></div>
                    <div class="col">
                        <div id="collapse" class="collapse" aria-labelledby="heading"
                             data-parent="#accordionInfo">
                            <p>Пока ничего не реализовано</p>
                        </div>
                    </div>
                </div>

                <div class="dropdown-divider"></div>

                <#-- Счетчики по категориям -->
                <div class="row mx-3  justify-content-center">
                    <div class="col px-0 pb-2">
                        <a class="row" href="#" style="text-decoration: none">
                            <div class="col d-flex justify-content-center"><b>72</b></div>
                            <div class="w-100"></div>
                            <div class="col d-flex justify-content-center"><p>друга</p></div>
                        </a>
                    </div>
                    <div class="col px-0 pb-2">
                        <a class="row" href="#" style="text-decoration: none">
                            <div class="col d-flex justify-content-center"><b>38</b></div>
                            <div class="w-100"></div>
                            <div class="col d-flex justify-content-center"><p>фотографий</p></div>
                        </a>
                    </div>
                    <div class="col px-0 pb-2">
                        <a class="row" href="#" style="text-decoration: none">
                            <div class="col d-flex justify-content-center"><b>11</b></div>
                            <div class="w-100"></div>
                            <div class="col d-flex justify-content-center"><p>отметок</p></div>
                        </a>
                    </div>
                    <div class="col px-0 pb-2">
                        <a class="row" href="#" style="text-decoration: none">
                            <div class="col d-flex justify-content-center"><b>6</b></div>
                            <div class="w-100"></div>
                            <div class="col d-flex justify-content-center"><p>видеозаписей</p></div>
                        </a>
                    </div>
                    <div class="col px-0 pb-2">
                        <a class="row" href="#" style="text-decoration: none">
                            <div class="col d-flex justify-content-center"><b>7</b></div>
                            <div class="w-100"></div>
                            <div class="col d-flex justify-content-center"><p>аудиозаписей</p></div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <#-- Конец информационного блока -->

        <#-- Фото из галереи -->
        <#if lastUploadedImagesUser?hasContent>
            <div class="row mb-3 ">
                <div class="col bg-white border rounded">
                    <div class="row">
                        <div class="col p-2"><p>Мои фотографии</p></div>
                    </div>
                    <div class="row pb-2 d-flex justify-content-center">
                        <#list lastUploadedImagesUser as image>
                            <div class="col-3 px-1 d-flex justify-content-center">
                                <img src="img/${image}" style="width: 123px; height: 123px">
                            </div>
                        </#list>
                    </div>
                </div>
            </div>
        </#if>

        <#-- Добавление публикации -->
        <#if authorizedUser.id == pageOwner.id>
            <div class="row mb-3">
                <div class="col bg-white border rounded">
                    <#include "../parts/message/message-edit.ftl"/>
                </div>
            </div>
        </#if>
        <#-- Конец добавления публикации -->

        <#-- Фильтр -->
        <#if pagePublications.content?hasContent>
            <div class="row">
                <div class="col bg-white border rounded">
                    <form method="get" action="/id${pageOwner.id}" class="form-inline">
                        <img src="../../static/img/icon/search.png" alt="search"/>

                        <input type="text" name="tag" autocomplete="off" value="${filter?ifExists}"
                               placeholder="Введите тэг"
                               class="form-control form-control-sm border-0" style="width: 95%; box-shadow: none"/>
                    </form>
                </div>
            </div>
        </#if>
        <#-- Конец фильтра -->

        <#-- Блок с публикациями -->
        <#if pagePublications.content?hasContent>
            <#list pagePublications.content as publication>
                <div class="row mb-3">
                    <div class="col bg-white border rounded">
                        <div class="card border-0">
                            <div class="row pt-3">
                                <img class="col-2 card-img-top rounded-circle"
                                     src="<#if pageOwner.personalData.avatarFileName??>/img/${pageOwner.personalData.avatarFileName}<#else>../../static/img/icon/camera_200.png</#if>"
                                     style="height: 63px;" alt="author-avatar">

                                <div class="col pl-0">
                                    <a href="/id${pageOwner.id}">
                                        ${pageOwner.personalData.firstName} ${pageOwner.personalData.lastName}
                                    </a>
                                    <p>${publication.dateCreation?date}</p>
                                </div>
                                <div class="col-1">
                                    <div class="dropdown">
                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>

                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                            <form action="/id${publication.author.id}/publication/delete/"
                                                  method="post">
                                                <input type="submit" class="dropdown-item" value="Удалить запись"/>
                                                <input type="hidden" name="id" value="${publication.id}"/>
                                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row pt-2">
                                <div class="col">
                                    ${publication.text}
                                </div>
                            </div>

                            <#if publication.fileName?hasContent>
                                <div class="mb-1">
                                    <img src="/img/${publication.fileName}" class="card-img-top" alt="publication-image"/>
                                </div>
                            </#if>

                            <#if publication.tag?hasContent>
                                <div class="mb-1">
                                    #${publication.tag}
                                </div>
                            </#if>

                            <div class="dropdown-divider"></div>

                            <div class="row pb-2">
                                <a class="col-2" href="/id${pageOwner.id}/publication/${publication.id}/like">
                                    <#if publication.getLikedAuthorizedUser()>
                                        <img class="main-menu-img" src="../../static/img/icon/like.png"
                                             alt="like"/> ${publication.numberLikes}
                                    <#else>
                                        <img class="main-menu-img" src="../../static/img/icon/none-like.png"
                                             alt="none like"/> ${publication.numberLikes}
                                    </#if>
                                </a>
                                <div class="col">
                                    <img class="main-menu-img" src="../../static/img/icon/repost.png" alt="repost"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </#list>
        <#else>
            <div class="row mb-3">
                <div class="col bg-white border rounded">
                    <div class="row pt-2">
                        <div class="col">Нет записей</div>
                    </div>

                    <div class="dropdown-divider"></div>

                    <div class="row p-3">
                        <div class="col p-3 d-flex justify-content-center">
                            <img src="../../static/img/icon/publication.png" alt="no-publication"/>
                        </div>

                        <div class="w-100"></div>

                        <div class="col p-2 d-flex justify-content-center">
                            <p>На стене пока нет ни одной записи</p>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
        <#-- Конец блока с публикациями -->

        <#-- Пагинация -->
        <#if pagePublications.content?hasContent>
            <div class="row mb-3">
                <@p.pager url pagePublications/>
            </div>
        </#if>
        <#-- Конец пагинации -->
    </div>
</@common.page>
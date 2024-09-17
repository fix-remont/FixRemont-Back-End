from enum import Enum


class ProjectType(str, Enum):
    FLAT = "Квартира"
    HOUSE = "Дом"


class PostType(str, Enum):
    NEWS = "Новость"
    BLOG = "Блог"


class UserType(str, Enum):
    REALTOR = "Риэлтор"
    DEVELOPER = "Заказчик"
    INDIVIDUAL = "Индивидуальный предприниматель"


class NotificationType(str, Enum):
    NO_MESSAGES = "Сообщений нет"
    NEW_MESSAGE = "Новое сообщение"
    FILL_DOCUMENT = "Заполнить документы"

class MessageType(str, Enum):
    MESSAGE = "Сообщение"
    SIGNATURE = "Акт"

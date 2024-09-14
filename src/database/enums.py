from enum import Enum


class ProjectType(str, Enum):
    FLAT = "FLAT"
    HOUSE = "HOUSE"


class PostType(str, Enum):
    NEWS = "NEWS"
    BLOG = "BLOG"


class UserType(str, Enum):
    REALTOR = "REALTOR"
    DEVELOPER = "DEVELOPER"
    INDIVIDUAL = "INDIVIDUAL"


class NotificationType(str, Enum):
    NO_MESSAGES = "NO_MESSAGES"
    NEW_MESSAGE = "NEW_MESSAGE"
    FILL_DOCUMENT = "FILL_DOCUMENT"

class MessageType(str, Enum):
    MESSAGE = "MESSAGE"
    SIGNATURE = "SIGNATURE"

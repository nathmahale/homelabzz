from aiogram import Router
from aiogram.filters import Command
from aiogram.types import Message

getuserid_router = Router()


@getuserid_router.message(Command("getuserid"))
async def command_getuserid_handler(message: Message) -> None:
    """
    This handler receives messages with `/getuserid` command
    """
    await message.answer(f"Hello, <b>{message.from_user.full_name}!</b>")
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", extra="ignore")

    # Banco
    DATABASE_URL: str
    DATABASE_TEST_URL: str = ""

    # JWT
    SECRET_KEY: str
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
    REFRESH_TOKEN_EXPIRE_DAYS: int = 7

    # Google (opcional — só necessário para login com Google)
    GOOGLE_CLIENT_ID: str = ""

    # App
    APP_ENV: str = "development"
    ALLOWED_ORIGINS: str = "http://localhost:3000"

    @property
    def is_production(self) -> bool:
        return self.APP_ENV == "production"


settings = Settings()

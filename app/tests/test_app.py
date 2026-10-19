import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parents[1]))

from app import get_message, health_check


def test_get_message():
    assert get_message() == "My AWS DevSecOps Pipeline"


def test_health_check():
    assert health_check() == "healthy"
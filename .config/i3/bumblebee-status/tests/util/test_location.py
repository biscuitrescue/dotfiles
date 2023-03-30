import pytest
import json

import util.location


@pytest.fixture
def urllib_req(mocker):
    util.location.reset()
    return mocker.patch("util.location.urllib.request")


@pytest.fixture
def secondaryLocation():
    return {
        "country": "Middle Earth",
        "longitude": "10.0",
        "latitude": "20.5",
        "ip": "127.0.0.1",
    }


@pytest.fixture
def primaryLocation():
    return {
        "country_name": "Rivia",
        "longitude": "-10.0",
        "latitude": "-23",
        "ip": "127.0.0.6",
    }


def test_primary_provider(urllib_req, primaryLocation):
    urllib_req.urlopen.return_value.read.return_value = json.dumps(primaryLocation)

    assert util.location.country() == primaryLocation["country_name"]
    assert util.location.coordinates() == (
        primaryLocation["latitude"],
        primaryLocation["longitude"],
    )
    assert util.location.public_ip() == primaryLocation["ip"]


def test_secondary_provider(mocker, urllib_req, secondaryLocation):
    urlopen = mocker.MagicMock()
    urlopen.read.return_value = json.dumps(secondaryLocation)
    urllib_req.urlopen.side_effect = [RuntimeError(), urlopen]

    assert util.location.country() == secondaryLocation["country"]
    assert util.location.coordinates() == (
        secondaryLocation["latitude"],
        secondaryLocation["longitude"],
    )
    assert util.location.public_ip() == secondaryLocation["ip"]


# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4

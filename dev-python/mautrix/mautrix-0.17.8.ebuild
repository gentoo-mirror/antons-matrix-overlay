# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_9 python3_10 python3_11 )
inherit distutils-r1

DESCRIPTION="A Python 3 asyncio Matrix framework."
HOMEPAGE="https://github.com/mautrix/python"
SRC_URI="https://github.com/mautrix/python/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/python-${PV}"

DEPEND="
	>=dev-python/aiohttp-3.0.0
	<dev-python/aiohttp-4.0.0
	>=dev-python/attrs-18.1.0
	>=dev-python/yarl-1.5.0
	<dev-python/yarl-2.0.0
"
RDEPEND="${DEPEND}"
BDEPEND=""

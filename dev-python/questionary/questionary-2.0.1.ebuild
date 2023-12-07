# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Python library to build pretty command line user prompts"
HOMEPAGE="https://github.com/tmbo/questionary"
SRC_URI="https://github.com/tmbo/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/prompt-toolkit-2.0.0[${PYTHON_USEDEP}]
	<=dev-python/prompt-toolkit-3.0.36[${PYTHON_USEDEP}]
	"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# TypeError: <lambda>() missing 1 required positional argument: 'strike'
	tests/prompts/test_common.py::test_print_with_style
)

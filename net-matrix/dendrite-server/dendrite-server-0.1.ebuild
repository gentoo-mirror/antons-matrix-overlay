# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Installs a typical configuration of dendrite."
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="net-matrix/dendrite >=dev-db/postgresql-9.6 www-servers/nginx app-crypt/certbot-nginx"
BDEPEND="sys-devel/m4 sys-apps/util-linux"

pkg_config() {
	if test -n "$ROOT" ; then
		# TODO: create a script that can be run from the target system.
		die "Cross-emerge (non-empty \$ROOT) is not supported."
	fi

	local postgre_user="dendrite"
	local postgre_password="$(hexdump --length 10 --no-squeezing --format '/1 "%02x"' /dev/random)"
	local database="dendrite"
	local dns_name="$(hostname --fqdn)"
	# PostgreSQL
	{
		echo "${postgre_password}" | postgres createuser -P "${postgre_user}" && \
		postgres createdb -O "${postgre_user}" "${database}"
	} || ewarn "Could not create PostgreSQL user and database."
	# CertBot
	{
		if test -f "${EROOT}/etc/letsencrypt/live/${dns_name}/privkey.pem" ; then
			echo "Found Let's Encrypt certificate"
			true
		else
			echo "Requesting Let's Encrypt certificate for ${dns_name}"
			certbot certonly --nginx -d "${dns_name}"
		fi && \
		if test -e "${EROOT}/var/spool/cron/crontabs/root" && grep -q certbot "${EROOT}/var/spool/cron/crontabs/root" ; then
			ewarn "I see certbot mentioned in your crontab. I will assume that you have the"
			ewarn "automatic renewal of certificates already set up. I will not modify"
			ewarn "crontab in any way. If this is not correct, please arrange to run"
			ewarn "  certbot renew -q"
			ewarn "regularly."
			true
		else
			echo '    0     0    *    *    *  sleep $( hexdump --length 2 --format '"'"'/2 "\%d"'"'"' /dev/random ); certbot renew -q' \
				>> "${EROOT}/var/spool/cron/crontabs/root" && \
			einfo "Scheduled automatic renewal of the Let's Encrypt certificates."
		fi
	} || ewarn "Something went wrong in setting up a Let's Encrypt certificate."
	# nginx
	if test -e "${EROOT}/etc/nginx/conf.d/dendrite"; then
		ewarn "\"${EROOT}/etc/nginx/conf.d/dendrite\" already exists"
		ewarn "Skipping nginx configuration"
	else
		einfo "Generating \"${EROOT}/etc/nginx/conf.d/dendrite\""
		{
			mkdir "${EROOT}/etc/nginx/conf.d" 2>/dev/null
			m4 --prefix-builtins \
				-D__prefix__="${EPREFIX}" \
				-D__dns_name__="${dns_name}" \
				"${FILES}/nginx.conf.template" > "${EROOT}/etc/nginx/conf.d/dendrite" && \
			echo "include conf.d/dendrite;" >> "${EROOT}/etc/nginx/nginx.conf"
		} || ewarn "Failed to configure nginx."
	fi
	# dendrite: server key
	if test -e "${EROOT}/etc/dendrite/matrix_key.pem" ; then
		einfo "${EROOT}/etc/dendrite/matrix_key.pem already exists."
	else
		einfo "Generating ${EROOT}/etc/dendrite/matrix_key.pem."
		generate-keys --private-key "${EROOT}/etc/dendrite/matrix_key.pem"
	fi
	# dendrite: config
	local dendrite_yaml
	if -e "${EROOT}/etc/dendrite/dendrite.yaml" ; then
		local i=1
		while -e "${EROOT}/etc/dendrite/dendrite-autoconfig-${i}.yaml" ; do
			i=$((${i}+1))
		done
		dendrite_yaml="${EROOT}/etc/dendrite/dendrite-autoconfig-${i}.yaml"
		ewarn "${EROOT}/etc/dendrite/dendrite.yaml already exists. Saving"
		ewarn "dendrite configuration to ${dendrite_yaml}"
	else
		dendrite_yaml="${EROOT}/etc/dendrite/dendrite.yaml"
	fi
	{
		m4 --prefix-builtins \
			-D__prefix__="${EPREFIX}" \
			-D__dns_name__="${dns_name}" \
			-D__postgre_user__="${postgre_user}" \
			-D__postgre_password__="${postgre_password}" \
			-D__database__="${database}" \
			"${FILES}/dendrite.yaml.template" > "${dendrite_yaml}" || \
		ewarn "Failed to generate dendrite.yaml"
	} && \
	chown dendrite:dendrite "${dendrite_yaml}" && \
	chmod go-rwx "${dendrite_yaml}"
}

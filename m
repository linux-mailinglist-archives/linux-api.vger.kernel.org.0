Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A99251367
	for <lists+linux-api@lfdr.de>; Tue, 25 Aug 2020 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgHYHgi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 25 Aug 2020 03:36:38 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.120]:22066 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbgHYHge (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 25 Aug 2020 03:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598340988;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=FylwbsoRc8YAPnjWRxFB9vS/7W/T+xjE16Ru+zQWYso=;
        b=r0pR9XAOqstugF/z5JgW30I1DQA1nY9V3U4JMCEHhR7+DJXenPT+o4Gz9A0z0nMZpG
        aQWIFwpFoSALNOMK9kfEisysJ6ljD8NL3syptUtmGgpXZ+oxfpeVUXcZe//jEmDw+Pim
        x+sA8GBBlEoCy3ZwyP3JP1DrLz6cbV8CWAxe4s9CysCpJMwCgYso5zdfIi5WdXnQML4J
        5CPyFjxErHBtamHwVT8MSMQCNh3y0f8/8MMxC0Iqo9cJJ+CMf3+I0G0ByXwLM5HINKzK
        IeNzNpchix5jB2iDteyFndL1zk5umjFJJcV9hl0itORZZUMigYthfOhNLbOPl7ZDqm57
        +7pQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaIvSXRbo="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 002e9aw7P7ZIZGQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 25 Aug 2020 09:35:18 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>
Subject: [PATCH v34 07/12] LRNG - add kernel crypto API PRNG extension
Date:   Tue, 25 Aug 2020 09:25:36 +0200
Message-ID: <9813416.nUPlyArG6x@positron.chronox.de>
In-Reply-To: <11649613.O9o76ZdvQC@positron.chronox.de>
References: <2544450.mvXUDI8C0e@positron.chronox.de> <5532247.MhkbZ0Pkbq@positron.chronox.de> <11649613.O9o76ZdvQC@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add runtime-pluggable support for all PRNGs that are accessible via
the kernel crypto API, including hardware PRNGs. The PRNG is selected
with the module parameter drng_name where the name must be one that the
kernel crypto API can resolve into an RNG.

This allows using of the kernel crypto API PRNG implementations that
provide an interface to hardware PRNGs. Using this extension,
the LRNG uses the hardware PRNGs to generate random numbers. An
example is the S390 CPACF support providing such a PRNG.

The hash is provided by a kernel crypto API SHASH whose digest size
complies with the seedsize of the PRNG.

CC: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Alexander E. Patrakov" <patrakov@gmail.com>
CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>
CC: Willy Tarreau <w@1wt.eu>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Vito Caputo <vcaputo@pengaru.com>
CC: Andreas Dilger <adilger.kernel@dilger.ca>
CC: Jan Kara <jack@suse.cz>
CC: Ray Strode <rstrode@redhat.com>
CC: William Jon McCann <mccann@jhu.edu>
CC: zhangjs <zachary@baishancloud.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Florian Weimer <fweimer@redhat.com>
CC: Lennart Poettering <mzxreary@0pointer.de>
CC: Nicolai Stange <nstange@suse.de>
Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
=2D--
 drivers/char/lrng/Kconfig      |  12 ++
 drivers/char/lrng/Makefile     |   1 +
 drivers/char/lrng/lrng_kcapi.c | 321 +++++++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_kcapi.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index 4f2b757a8962..c89de14d173a 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -82,6 +82,18 @@ config LRNG_DRBG
 	  Enable the SP800-90A DRBG support for the LRNG. Once the
 	  module is loaded, output from /dev/random, /dev/urandom,
 	  getrandom(2), or get_random_bytes_full is provided by a DRBG.
+
+config LRNG_KCAPI
+	tristate "Kernel Crypto API support for the LRNG"
+	depends on CRYPTO
+	depends on !LRNG_DRBG
+	select CRYPTO_RNG
+	help
+	  Enable the support for generic pseudo-random number
+	  generators offered by the kernel crypto API with the
+	  LRNG. Once the module is loaded, output from /dev/random,
+	  /dev/urandom, getrandom(2), or get_random_bytes is
+	  provided by the selected kernel crypto API RNG.
 endif # LRNG_DRNG_SWITCH
=20
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index 0d320fcb7b9e..94b2dfb2dfdb 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_NUMA)		+=3D lrng_numa.o
 obj-$(CONFIG_SYSCTL)		+=3D lrng_proc.o
 obj-$(CONFIG_LRNG_DRNG_SWITCH)	+=3D lrng_switch.o
 obj-$(CONFIG_LRNG_DRBG)		+=3D lrng_drbg.o
+obj-$(CONFIG_LRNG_KCAPI)	+=3D lrng_kcapi.o
diff --git a/drivers/char/lrng/lrng_kcapi.c b/drivers/char/lrng/lrng_kcapi.c
new file mode 100644
index 000000000000..b71092605e6b
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_kcapi.c
@@ -0,0 +1,321 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Backend for the LRNG providing the cryptographic primitives using the
+ * kernel crypto API.
+ *
+ * Copyright (C) 2018 - 2020, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <crypto/hash.h>
+#include <crypto/rng.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/lrng.h>
+
+static char *drng_name =3D NULL;
+module_param(drng_name, charp, 0444);
+MODULE_PARM_DESC(drng_name, "Kernel crypto API name of DRNG");
+
+static char *pool_hash =3D "sha512";
+module_param(pool_hash, charp, 0444);
+MODULE_PARM_DESC(pool_hash,
+		 "Kernel crypto API name of hash or keyed message digest to read the ent=
ropy pool");
+
+static char *seed_hash =3D NULL;
+module_param(seed_hash, charp, 0444);
+MODULE_PARM_DESC(seed_hash,
+		 "Kernel crypto API name of hash with output size equal to seedsize of D=
RNG to bring seed string to the size required by the DRNG");
+
+struct lrng_hash_info {
+	struct shash_desc shash;
+	char ctx[];
+};
+
+struct lrng_drng_info {
+	struct crypto_rng *kcapi_rng;
+	struct lrng_hash_info *lrng_hash;
+};
+
+static struct lrng_hash_info *_lrng_kcapi_hash_alloc(const char *name)
+{
+	struct lrng_hash_info *lrng_hash;
+	struct crypto_shash *tfm;
+	int size;
+
+	if (!name) {
+		pr_err("Hash name missing\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	tfm =3D crypto_alloc_shash(name, 0, 0);
+	if (IS_ERR(tfm)) {
+		pr_err("could not allocate hash %s\n", name);
+		return ERR_CAST(tfm);
+	}
+
+	size =3D sizeof(struct lrng_hash_info) + crypto_shash_descsize(tfm);
+	lrng_hash =3D kmalloc(size, GFP_KERNEL);
+	if (!lrng_hash) {
+		crypto_free_shash(tfm);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	lrng_hash->shash.tfm =3D tfm;
+
+	return lrng_hash;
+}
+
+static inline u32 _lrng_kcapi_hash_digestsize(struct lrng_hash_info *lrng_=
hash)
+{
+	struct shash_desc *shash =3D &lrng_hash->shash;
+	struct crypto_shash *tfm =3D shash->tfm;
+
+	return crypto_shash_digestsize(tfm);
+}
+
+static inline void _lrng_kcapi_hash_free(struct lrng_hash_info *lrng_hash)
+{
+	struct shash_desc *shash =3D &lrng_hash->shash;
+	struct crypto_shash *tfm =3D shash->tfm;
+
+	crypto_free_shash(tfm);
+	kfree(lrng_hash);
+}
+
+static void *lrng_kcapi_hash_alloc(const u8 *key, u32 keylen)
+{
+	struct lrng_hash_info *lrng_hash;
+	int ret;
+
+	lrng_hash =3D _lrng_kcapi_hash_alloc(pool_hash);
+	if (IS_ERR(lrng_hash))
+		return ERR_CAST(lrng_hash);
+
+	/* If the used hash is no MAC, ignore the ENOSYS return code */
+	ret =3D crypto_shash_setkey(lrng_hash->shash.tfm, key, keylen);
+	if (ret && ret !=3D -ENOSYS) {
+		pr_err("could not set the key for MAC\n");
+		_lrng_kcapi_hash_free(lrng_hash);
+		return ERR_PTR(ret);
+	}
+
+	pr_info("Hash %s allocated\n", pool_hash);
+
+	return lrng_hash;
+}
+
+static void lrng_kcapi_hash_dealloc(void *hash)
+{
+	struct lrng_hash_info *lrng_hash =3D (struct lrng_hash_info *)hash;
+
+	_lrng_kcapi_hash_free(lrng_hash);
+	pr_info("Hash %s deallocated\n", pool_hash);
+}
+
+static u32 lrng_kcapi_hash_digestsize(void *hash)
+{
+	struct lrng_hash_info *lrng_hash =3D (struct lrng_hash_info *)hash;
+
+	return _lrng_kcapi_hash_digestsize(lrng_hash);
+}
+
+static int lrng_kcapi_hash_buffer(void *hash, const u8 *inbuf, u32 inbufle=
n,
+				  u8 *digest)
+{
+	struct lrng_hash_info *lrng_hash =3D (struct lrng_hash_info *)hash;
+	struct shash_desc *shash =3D &lrng_hash->shash;
+
+	return crypto_shash_digest(shash, inbuf, inbuflen, digest);
+}
+
+static int lrng_kcapi_drng_seed_helper(void *drng, const u8 *inbuf,
+				       u32 inbuflen)
+{
+	struct lrng_drng_info *lrng_drng_info =3D (struct lrng_drng_info *)drng;
+	struct crypto_rng *kcapi_rng =3D lrng_drng_info->kcapi_rng;
+	struct lrng_hash_info *lrng_hash =3D lrng_drng_info->lrng_hash;
+
+	if (lrng_hash) {
+		struct shash_desc *shash =3D &lrng_hash->shash;
+		u32 digestsize =3D _lrng_kcapi_hash_digestsize(lrng_hash);
+		u8 digest[64] __aligned(8);
+		int ret;
+
+		BUG_ON(digestsize > sizeof(digest));
+
+		ret =3D crypto_shash_digest(shash, inbuf, inbuflen, digest);
+		if (ret)
+			return ret;
+
+		ret =3D crypto_rng_reset(kcapi_rng, digest, digestsize);
+		if (ret)
+			return ret;
+
+		memzero_explicit(digest, digestsize);
+
+		return 0;
+	} else {
+		return crypto_rng_reset(kcapi_rng, inbuf, inbuflen);
+	}
+}
+
+static int lrng_kcapi_drng_generate_helper(void *drng, u8 *outbuf,
+					   u32 outbuflen)
+{
+	struct lrng_drng_info *lrng_drng_info =3D (struct lrng_drng_info *)drng;
+	struct crypto_rng *kcapi_rng =3D lrng_drng_info->kcapi_rng;
+	int ret =3D crypto_rng_get_bytes(kcapi_rng, outbuf, outbuflen);
+
+	if (ret < 0)
+		return ret;
+
+	return outbuflen;
+}
+
+static void *lrng_kcapi_drng_alloc(u32 sec_strength)
+{
+	struct lrng_drng_info *lrng_drng_info;
+	struct crypto_rng *kcapi_rng;
+	int seedsize;
+	void *ret =3D  ERR_PTR(-ENOMEM);
+
+	if (!drng_name) {
+		pr_err("DRNG name missing\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!memcmp(drng_name, "drbg", 4)) {
+		pr_err("SP800-90A DRBG cannot be allocated using lrng_kcapi backend, use=
 lrng_drbg backend instead\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!memcmp(drng_name, "stdrng", 6)) {
+		pr_err("stdrng cannot be allocated using lrng_kcapi backend, it is too u=
nspecific and potentially may allocate the DRBG\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	lrng_drng_info =3D kmalloc(sizeof(*lrng_drng_info), GFP_KERNEL);
+	if (!lrng_drng_info)
+		return ERR_PTR(-ENOMEM);
+
+	kcapi_rng =3D crypto_alloc_rng(drng_name, 0, 0);
+	if (IS_ERR(kcapi_rng)) {
+		pr_err("DRNG %s cannot be allocated\n", drng_name);
+		ret =3D ERR_CAST(kcapi_rng);
+		goto free;
+	}
+	lrng_drng_info->kcapi_rng =3D kcapi_rng;
+
+	seedsize =3D  crypto_rng_seedsize(kcapi_rng);
+
+	if (sec_strength > seedsize)
+		pr_info("Seedsize DRNG (%u bits) lower than security strength of LRNG no=
ise source (%u bits)\n",
+			crypto_rng_seedsize(kcapi_rng) * 8, sec_strength * 8);
+
+	if (seedsize) {
+		struct lrng_hash_info *lrng_hash;
+
+		if (!seed_hash) {
+			switch (seedsize) {
+			case 32:
+				seed_hash =3D "sha256";
+				break;
+			case 48:
+				seed_hash =3D "sha384";
+				break;
+			case 64:
+				seed_hash =3D "sha512";
+				break;
+			default:
+				pr_err("Seed size %d cannot be processed\n",
+				       seedsize);
+				goto dealloc;
+				break;
+			}
+		}
+
+		lrng_hash =3D _lrng_kcapi_hash_alloc(seed_hash);
+		if (IS_ERR(lrng_hash)) {
+			ret =3D ERR_CAST(lrng_hash);
+			goto dealloc;
+		}
+
+		if (seedsize !=3D _lrng_kcapi_hash_digestsize(lrng_hash)) {
+			pr_err("Seed hash output size not equal to DRNG seed size\n");
+			_lrng_kcapi_hash_free(lrng_hash);
+			ret =3D ERR_PTR(-EINVAL);
+			goto dealloc;
+		}
+
+		lrng_drng_info->lrng_hash =3D lrng_hash;
+
+		pr_info("Seed hash %s allocated\n", seed_hash);
+	} else {
+		lrng_drng_info->lrng_hash =3D NULL;
+	}
+
+	pr_info("Kernel crypto API DRNG %s allocated\n", drng_name);
+
+	return lrng_drng_info;
+
+dealloc:
+	crypto_free_rng(kcapi_rng);
+free:
+	kfree(lrng_drng_info);
+	return ret;
+}
+
+static void lrng_kcapi_drng_dealloc(void *drng)
+{
+	struct lrng_drng_info *lrng_drng_info =3D (struct lrng_drng_info *)drng;
+	struct crypto_rng *kcapi_rng =3D lrng_drng_info->kcapi_rng;
+	struct lrng_hash_info *lrng_hash =3D lrng_drng_info->lrng_hash;
+
+	crypto_free_rng(kcapi_rng);
+	if (lrng_hash) {
+		_lrng_kcapi_hash_free(lrng_hash);
+		pr_info("Seed hash %s deallocated\n", seed_hash);
+	}
+	kfree(lrng_drng_info);
+	pr_info("DRNG %s deallocated\n", drng_name);
+}
+
+static const char *lrng_kcapi_drng_name(void)
+{
+	return drng_name;
+}
+
+static const char *lrng_kcapi_pool_hash(void)
+{
+	return pool_hash;
+}
+
+static const struct lrng_crypto_cb lrng_kcapi_crypto_cb =3D {
+	.lrng_drng_name			=3D lrng_kcapi_drng_name,
+	.lrng_hash_name			=3D lrng_kcapi_pool_hash,
+	.lrng_drng_alloc		=3D lrng_kcapi_drng_alloc,
+	.lrng_drng_dealloc		=3D lrng_kcapi_drng_dealloc,
+	.lrng_drng_seed_helper		=3D lrng_kcapi_drng_seed_helper,
+	.lrng_drng_generate_helper	=3D lrng_kcapi_drng_generate_helper,
+	.lrng_hash_alloc		=3D lrng_kcapi_hash_alloc,
+	.lrng_hash_dealloc		=3D lrng_kcapi_hash_dealloc,
+	.lrng_hash_digestsize		=3D lrng_kcapi_hash_digestsize,
+	.lrng_hash_buffer		=3D lrng_kcapi_hash_buffer,
+};
+
+static int __init lrng_kcapi_init(void)
+{
+	return lrng_set_drng_cb(&lrng_kcapi_crypto_cb);
+}
+static void __exit lrng_kcapi_exit(void)
+{
+	lrng_set_drng_cb(NULL);
+}
+
+late_initcall(lrng_kcapi_init);
+module_exit(lrng_kcapi_exit);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
+MODULE_DESCRIPTION("Linux Random Number Generator - kernel crypto API DRNG=
 backend");
=2D-=20
2.26.2





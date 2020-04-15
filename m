Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BF31A9AB4
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 12:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408735AbgDOKfI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Apr 2020 06:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408662AbgDOKcI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Apr 2020 06:32:08 -0400
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5304::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95B4C061A0F;
        Wed, 15 Apr 2020 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586946726;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=6CSWctxL15DZKE0KWrvBDvlt2/V1XgOHz1pnOGOVTf4=;
        b=AtQqMc9XCieaPPIokNTPE/80oZqXV1PAkNpZSYP64b2JoVv8yDWdBLv/W0+mIX9aRI
        0KR88gyGg6B+LKaXTIscb+tUPNs31VKmDNMfW3HntyGQ6CtFph9XQVGuBGdPX8yiFfQ6
        dsRByTwO9fCEAraPK0C94woqr7+wpemGkENevj08KqJoWwcd6tm5/bbLaKlVU2Z0iJsn
        VgFpJyaaQgHBjC12Pjoguj/2LewAtxO6SPMjtVZkLBF7MQf7BrGTP2vDTc9QyquhmN2W
        C81S8vlSOuhU2ZNDH4aRSvaqweorMiCkCPCTAjYv2YdwZUGYMGLyzs9Us2a7x0vtvgh0
        wZvA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZIvSaiyU="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.4.0 DYNA|AUTH)
        with ESMTPSA id 404ef0w3FAJr126
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 15 Apr 2020 12:19:53 +0200 (CEST)
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
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v30 05/12] crypto: DRBG - externalize DRBG functions for LRNG
Date:   Wed, 15 Apr 2020 12:12:02 +0200
Message-ID: <6030457.XiyDu3rDxA@positron.chronox.de>
In-Reply-To: <11836144.hkEK2qVKZC@positron.chronox.de>
References: <11836144.hkEK2qVKZC@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch allows several DRBG functions to be called by the LRNG kernel
code paths outside the drbg.c file.

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
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
=2D--
 crypto/drbg.c         | 16 ++++++++++------
 include/crypto/drbg.h |  7 +++++++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index b6929eb5f565..5561dd0f09e1 100644
=2D-- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -113,7 +113,7 @@
  * the SHA256 / AES 256 over other ciphers. Thus, the favored
  * DRBGs are the latest entries in this array.
  */
=2Dstatic const struct drbg_core drbg_cores[] =3D {
+const struct drbg_core drbg_cores[] =3D {
 #ifdef CONFIG_CRYPTO_DRBG_CTR
 	{
 		.flags =3D DRBG_CTR | DRBG_STRENGTH128,
@@ -190,6 +190,7 @@ static const struct drbg_core drbg_cores[] =3D {
 	},
 #endif /* CONFIG_CRYPTO_DRBG_HMAC */
 };
+EXPORT_SYMBOL(drbg_cores);
=20
 static int drbg_uninstantiate(struct drbg_state *drbg);
=20
@@ -205,7 +206,7 @@ static int drbg_uninstantiate(struct drbg_state *drbg);
  * Return: normalized strength in *bytes* value or 32 as default
  *	   to counter programming errors
  */
=2Dstatic inline unsigned short drbg_sec_strength(drbg_flag_t flags)
+unsigned short drbg_sec_strength(drbg_flag_t flags)
 {
 	switch (flags & DRBG_STRENGTH_MASK) {
 	case DRBG_STRENGTH128:
@@ -218,6 +219,7 @@ static inline unsigned short drbg_sec_strength(drbg_fla=
g_t flags)
 		return 32;
 	}
 }
+EXPORT_SYMBOL(drbg_sec_strength);
=20
 /*
  * FIPS 140-2 continuous self test for the noise source
@@ -1202,7 +1204,7 @@ static int drbg_seed(struct drbg_state *drbg, struct =
drbg_string *pers,
 }
=20
 /* Free all substructures in a DRBG state without the DRBG state structure=
 */
=2Dstatic inline void drbg_dealloc_state(struct drbg_state *drbg)
+void drbg_dealloc_state(struct drbg_state *drbg)
 {
 	if (!drbg)
 		return;
@@ -1223,12 +1225,13 @@ static inline void drbg_dealloc_state(struct drbg_s=
tate *drbg)
 		drbg->fips_primed =3D false;
 	}
 }
+EXPORT_SYMBOL(drbg_dealloc_state);
=20
 /*
  * Allocate all sub-structures for a DRBG state.
  * The DRBG state structure must already be allocated.
  */
=2Dstatic inline int drbg_alloc_state(struct drbg_state *drbg)
+int drbg_alloc_state(struct drbg_state *drbg)
 {
 	int ret =3D -ENOMEM;
 	unsigned int sb_size =3D 0;
@@ -1307,6 +1310,7 @@ static inline int drbg_alloc_state(struct drbg_state =
*drbg)
 	drbg_dealloc_state(drbg);
 	return ret;
 }
+EXPORT_SYMBOL(drbg_alloc_state);
=20
 /*************************************************************************
  * DRBG interface functions
@@ -1874,8 +1878,7 @@ static int drbg_kcapi_sym_ctr(struct drbg_state *drbg,
  *
  * return: flags
  */
=2Dstatic inline void drbg_convert_tfm_core(const char *cra_driver_name,
=2D					 int *coreref, bool *pr)
+void drbg_convert_tfm_core(const char *cra_driver_name, int *coreref, bool=
 *pr)
 {
 	int i =3D 0;
 	size_t start =3D 0;
@@ -1902,6 +1905,7 @@ static inline void drbg_convert_tfm_core(const char *=
cra_driver_name,
 		}
 	}
 }
+EXPORT_SYMBOL(drbg_convert_tfm_core);
=20
 static int drbg_kcapi_init(struct crypto_tfm *tfm)
 {
diff --git a/include/crypto/drbg.h b/include/crypto/drbg.h
index 8c9af21efce1..c63b20375235 100644
=2D-- a/include/crypto/drbg.h
+++ b/include/crypto/drbg.h
@@ -282,4 +282,11 @@ enum drbg_prefixes {
 	DRBG_PREFIX3
 };
=20
+extern int drbg_alloc_state(struct drbg_state *drbg);
+extern void drbg_dealloc_state(struct drbg_state *drbg);
+extern void drbg_convert_tfm_core(const char *cra_driver_name, int *corere=
f,
+				  bool *pr);
+extern const struct drbg_core drbg_cores[];
+extern unsigned short drbg_sec_strength(drbg_flag_t flags);
+
 #endif /* _DRBG_H */
=2D-=20
2.25.2





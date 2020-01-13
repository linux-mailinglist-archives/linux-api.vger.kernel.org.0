Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AF1138F87
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2020 11:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgAMKsS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Jan 2020 05:48:18 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:33380 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAMKsS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Jan 2020 05:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578912490;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Usp1p+nhOPTVY+J45k08K2IiYrE2hi1cmiuVc8jh9vc=;
        b=HY+BH77zsdmiuTdCrUxgDYgwaMAJnxSW/0U2+sMjP+PkoO+qw/SwOSwwXc+yn39Usc
        x96G3GnVOJnhGTDyp/0Ksk8o8WBmJBnjeST78ZC4E4RU8Gw3RiN2MTHEoV7p7CP1YHmW
        K+LWqV3tdWtegEj8CTEEvBdjeY6h1lR2uGDHQ1+wudqVKm4DDXUYH7dX2MtJ4SZBMf6T
        ezLnJozNbD9C4r6Yqy4N5xzuVzx3O5bHa7TvdP7JXVfIdqgd3gj7cvMGqIyIHxgHT1nt
        KomFRJO1hcwxCFIG+5TE8SnmgSYo9VkW3hCMp1PaRsWwTXju2OsYevi8ObG3+VZDu+uO
        eU8w==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJPScHivh"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w0DAkjKZs
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 13 Jan 2020 11:46:45 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, kbuild-all@lists.01.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v27 12/12] LRNG - add power-on and runtime self-tests
Date:   Mon, 13 Jan 2020 11:46:45 +0100
Message-ID: <7793472.zipptD7Jei@tauon.chronox.de>
In-Reply-To: <20200113103941.GC9488@kadam>
References: <20200113103941.GC9488@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Montag, 13. Januar 2020, 11:39:41 CET schrieb Dan Carpenter:

Hi Dan,

> Hi "Stephan,
>=20
> url:  =20
> https://github.com/0day-ci/linux/commits/Stephan-M-ller/dev-random-a-new-=
ap
> proach-with-full-SP800-90B/20200110-084934 base: =20
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> 68faa679b8be1a74e6663c21c3a9d25d32f1c079
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> smatch warnings:
> drivers/char/lrng/lrng_selftest.c:117 lrng_pool_lfsr_selftest() warn:
> sizeof(NUMBER)? drivers/char/lrng/lrng_selftest.c:229
> lrng_hash_df_selftest() warn: sizeof(NUMBER)?
>=20
> #
> https://github.com/0day-ci/linux/commit/5b6f2811172c968d8eb78167825c58557=
ea
> 91995 git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 5b6f2811172c968d8eb78167825c58557ea91995
> vim +117 drivers/char/lrng/lrng_selftest.c
>=20
> 5b6f2811172c96 Stephan M=FCller 2020-01-09   89  static unsigned int
> lrng_pool_lfsr_selftest(void) 5b6f2811172c96 Stephan M=FCller 2020-01-09 =
  90
>  {
> 5b6f2811172c96 Stephan M=FCller 2020-01-09   91  	/*
> 5b6f2811172c96 Stephan M=FCller 2020-01-09   92  	 * First, 67th and last
> entry of entropy pool. 5b6f2811172c96 Stephan M=FCller 2020-01-09   93  	=
 *
> 5b6f2811172c96 Stephan M=FCller 2020-01-09   94  	 * The 67th entry is pi=
cked
> because this one is the first to receive 5b6f2811172c96 Stephan M=FCller
> 2020-01-09   95  	 * an entry. As we start with 1 to inject into the=20
LFSR,
> the 5b6f2811172c96 Stephan M=FCller 2020-01-09   96  	 * 67th entry shoul=
d=20
be
> equal to rol(1, 7) >> 3 considering that 5b6f2811172c96 Stephan M=FCller
> 2020-01-09   97  	 * all other values of the LFSR are zero and the the
> twist value of 0 5b6f2811172c96 Stephan M=FCller 2020-01-09   98  	 * is
> applied.
> 5b6f2811172c96 Stephan M=FCller 2020-01-09   99  	 */
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  100  	static u32 const
> lrng_lfsr_selftest_result[][3] =3D { 5b6f2811172c96 Stephan M=FCller 2020=
=2D01-09
>  101  		{ 0xf56df24a, 0x00000010, 0x0e014939 }, 5b6f2811172c96 Stephan
> M=FCller 2020-01-09  102  		{ 0x4b130726, 0x00000010, 0x2802f509=20
},
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  103  		{ 0x87279152,=20
0x00000010,
> 0x00150000 }, 5b6f2811172c96 Stephan M=FCller 2020-01-09  104  		{
> 0x0b67f997, 0x00000010, 0x00150000 }, 5b6f2811172c96 Stephan M=FCller
> 2020-01-09  105  		{ 0x4fea174f, 0x00000010, 0xcbf4a6ae },=20
5b6f2811172c96
> Stephan M=FCller 2020-01-09  106  		{ 0x77149108, 0x00000010,=20
0x77bfadf2 },
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  107  		{ 0x1e96037e,=20
0x00000010,
> 0x18017e79 }, 5b6f2811172c96 Stephan M=FCller 2020-01-09  108  		{
> 0xc84acef2, 0x00000010, 0x6345f7a8 }, 5b6f2811172c96 Stephan M=FCller
> 2020-01-09  109  		{ 0x6a2eb6df, 0x00000010, 0x03950000 },=20
5b6f2811172c96
> Stephan M=FCller 2020-01-09  110  	};
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  111  	struct lrng_pool *lrng_=
pool,
> *lrng_pool_aligned; 5b6f2811172c96 Stephan M=FCller 2020-01-09  112  	u32=
=20
i,
> ret =3D LRNG_SELFTEST_PASSED; 5b6f2811172c96 Stephan M=FCller 2020-01-09 =
 113
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  114=20
> 	BUILD_BUG_ON(ARRAY_SIZE(lrng_lfsr_selftest_result) < 5b6f2811172c96
> Stephan M=FCller 2020-01-09  115  					=09
	CONFIG_LRNG_POOL_SIZE);
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  116
> 5b6f2811172c96 Stephan M=FCller 2020-01-09 @117  	lrng_pool =3D
> kzalloc(sizeof(struct lrng_pool) + sizeof(LRNG_KCAPI_ALIGN),
> ^^^^^^^^^^^^^^^^^^^^^^^^ Probably just LRNG_KCAPI_ALIGN is intended with =
no
> sizeof().


Yes, absolutely. Fixed in both cases.

Thank you!
>=20
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  118  			   =20
GFP_KERNEL);
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  119  	if (!lrng_pool)
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  120  		return
> LRNG_SEFLTEST_ERROR_LFSR; 5b6f2811172c96 Stephan M=FCller 2020-01-09  121=
=20
> 	lrng_pool_aligned =3D PTR_ALIGN(lrng_pool, sizeof(u32)); 5b6f2811172c96
> Stephan M=FCller 2020-01-09  122
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  123  	for (i =3D 1; i <=3D
> LRNG_POOL_SIZE; i++) 5b6f2811172c96 Stephan M=FCller 2020-01-09  124=20
> 		_lrng_pool_lfsr_u32(lrng_pool_aligned, i); 5b6f2811172c96=20
Stephan M=FCller
> 2020-01-09  125
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  126  	if
> ((atomic_read_u32(&lrng_pool_aligned->pool[0]) !=3D 5b6f2811172c96 Stephan
> M=FCller 2020-01-09  127  	   =20
> lrng_lfsr_selftest_result[CONFIG_LRNG_POOL_SIZE][0]) || 5b6f2811172c96
> Stephan M=FCller 2020-01-09  128  	  =20
> (atomic_read_u32(&lrng_pool_aligned->pool[67 & 5b6f2811172c96 Stephan
> M=FCller 2020-01-09  129  						     =20
(LRNG_POOL_SIZE - 1)]) !=3D
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  130  	   =20
> lrng_lfsr_selftest_result[CONFIG_LRNG_POOL_SIZE][1]) || 5b6f2811172c96
> Stephan M=FCller 2020-01-09  131  	  =20
> (atomic_read_u32(&lrng_pool_aligned->pool[LRNG_POOL_SIZE - 1]) !=3D
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  132  	   =20
> lrng_lfsr_selftest_result[CONFIG_LRNG_POOL_SIZE][2])) { 5b6f2811172c96
> Stephan M=FCller 2020-01-09  133  		pr_err("LRNG LFSR self-test=20
=46AILED\n");
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  134  		ret =3D
> LRNG_SEFLTEST_ERROR_LFSR; 5b6f2811172c96 Stephan M=FCller 2020-01-09  135=
  =09
}
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  136
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  137  	kfree(lrng_pool);
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  138  	return ret;
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  139  }
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  140
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  141  /*
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  142   * The test vectors are
> generated with the hash_df_testvector_generation tool 5b6f2811172c96
> Stephan M=FCller 2020-01-09  143   * provided as part of the test tool se=
t of
> the LRNG. 5b6f2811172c96 Stephan M=FCller 2020-01-09  144   */
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  145  static unsigned int
> lrng_hash_df_selftest(void) 5b6f2811172c96 Stephan M=FCller 2020-01-09  1=
46=20
> {
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  147  	const struct lrng_crypt=
o_cb
> *crypto_cb =3D &lrng_cc20_crypto_cb; 5b6f2811172c96 Stephan M=FCller 2020=
=2D01-09
>  148
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  149  	/*
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  150  	 * The size of 45 bytes=
 is
> chosen arbitrarily. Yet, this size should 5b6f2811172c96 Stephan M=FCller
> 2020-01-09  151  	 * ensure that we have at least two hash blocks plus=20
some
> fraction 5b6f2811172c96 Stephan M=FCller 2020-01-09  152  	 * of a hash b=
lock
> generated. 5b6f2811172c96 Stephan M=FCller 2020-01-09  153  	 */
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  154  	static u8 const
> lrng_hash_df_selftest_result[][45] =3D { 5b6f2811172c96 Stephan M=FCller
> 2020-01-09  155  		{
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  156  			0x3b, 0xbe,=20
0x7a, 0xbd,
> 0x2b, 0x16, 0x02, 0x4c, 5b6f2811172c96 Stephan M=FCller 2020-01-09  157=20
> 			0xfc, 0xd3, 0x02, 0x15, 0xf0, 0x86, 0xd4, 0xdb,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  158  			0x49, 0xec, 0x26, 0x53, 0xd6,=20
0xc9, 0x6d, 0xad,
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  159  			0x24, 0xca,=20
0x72, 0x89,
> 0x2c, 0xfa, 0x48, 0x18, 5b6f2811172c96 Stephan M=FCller 2020-01-09  160=20
> 			0xf7, 0x47, 0xb5, 0x2f, 0x92, 0xa2, 0x1b, 0xd9,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  161  			0x24, 0xa7, 0x2f, 0xa2, 0x0b,=20
5b6f2811172c96
> Stephan M=FCller 2020-01-09  162  		}, {
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  163  			0xd2, 0xaa,=20
0xf9, 0x76,
> 0x26, 0xc6, 0x13, 0xea, 5b6f2811172c96 Stephan M=FCller 2020-01-09  164=20
> 			0xb8, 0xde, 0xe6, 0x88, 0x8f, 0xc4, 0x7a, 0x7d,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  165  			0x9c, 0xb4, 0x1b, 0xd1, 0xd1,=20
0x8a, 0x40, 0xc9,
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  166  			0xaa, 0x45,=20
0xa6, 0xb6,
> 0xb5, 0x6f, 0xf6, 0xbc, 5b6f2811172c96 Stephan M=FCller 2020-01-09  167=20
> 			0xbb, 0x77, 0x37, 0xbc, 0x5a, 0x2d, 0xcc, 0x84,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  168  			0x25, 0x68, 0x5e, 0xba, 0x16,=20
5b6f2811172c96
> Stephan M=FCller 2020-01-09  169  		}, {
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  170  			0x58, 0x66,=20
0x82, 0x88,
> 0x29, 0x19, 0xa4, 0xbb, 5b6f2811172c96 Stephan M=FCller 2020-01-09  171=20
> 			0x33, 0x42, 0xc9, 0x72, 0x0d, 0x68, 0x6e, 0xb9,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  172  			0xc6, 0xe0, 0x7a, 0xf9, 0x20,=20
0xca, 0x6d, 0x18,
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  173  			0x35, 0xec,=20
0xfa, 0x9e,
> 0xf6, 0x3a, 0xa7, 0xb6, 5b6f2811172c96 Stephan M=FCller 2020-01-09  174=20
> 			0x92, 0x7a, 0xe5, 0xcd, 0xc5, 0x13, 0x9f, 0x65,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  175  			0x6a, 0xe1, 0xe4, 0x3f, 0xb9,=20
5b6f2811172c96
> Stephan M=FCller 2020-01-09  176  		}, {
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  177  			0xdd, 0xf1,=20
0x34, 0xca,
> 0x08, 0xe3, 0xce, 0x8a, 5b6f2811172c96 Stephan M=FCller 2020-01-09  178=20
> 			0x26, 0x6b, 0xce, 0x99, 0x8a, 0x84, 0xd2, 0x21,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  179  			0x98, 0x10, 0x95, 0x5f, 0x9f,=20
0xc3, 0xf2, 0xe4,
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  180  			0x79, 0x75,=20
0xb5, 0x15,
> 0xa7, 0xa2, 0xf1, 0xc4, 5b6f2811172c96 Stephan M=FCller 2020-01-09  181=20
> 			0xdc, 0x67, 0xcb, 0x67, 0x8c, 0xb2, 0x1b, 0xd5,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  182  			0xd6, 0x8b, 0xc2, 0x34, 0xd6,=20
5b6f2811172c96
> Stephan M=FCller 2020-01-09  183  		}, {
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  184  			0xc3, 0x16,=20
0x9d, 0xf0,
> 0x78, 0x15, 0xab, 0xf2, 5b6f2811172c96 Stephan M=FCller 2020-01-09  185=20
> 			0x2f, 0xc9, 0x2e, 0xe1, 0xc6, 0x5e, 0xfa, 0x03,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  186  			0xaf, 0xd4, 0xd5, 0x47, 0x2a,=20
0xe8, 0x06, 0xe8,
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  187  			0x7e, 0x0a,=20
0x71, 0xc7,
> 0x0d, 0x39, 0xb1, 0xa9, 5b6f2811172c96 Stephan M=FCller 2020-01-09  188=20
> 			0x5a, 0x49, 0xee, 0x8b, 0x2f, 0xcd, 0xea, 0x96,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  189  			0xcc, 0x08, 0x71, 0xef, 0x9c,=20
5b6f2811172c96
> Stephan M=FCller 2020-01-09  190  		}, {
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  191  			0x1a, 0x3d,=20
0x70, 0x39,
> 0xc2, 0x02, 0x4d, 0x3a, 5b6f2811172c96 Stephan M=FCller 2020-01-09  192=20
> 			0xaa, 0x14, 0x20, 0x88, 0x96, 0x4c, 0x7c, 0xe4,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  193  			0xaa, 0x49, 0x89, 0x30, 0x50,=20
0x96, 0xb6, 0xa7,
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  194  			0x55, 0x0a,=20
0xf8, 0xd2,
> 0x4e, 0x83, 0x9d, 0x1f, 5b6f2811172c96 Stephan M=FCller 2020-01-09  195=20
> 			0x56, 0x49, 0x13, 0xc6, 0x46, 0x55, 0x73, 0x0d,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  196  			0x74, 0xcd, 0x81, 0xe0, 0x65,=20
5b6f2811172c96
> Stephan M=FCller 2020-01-09  197  		}, {
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  198  			0x4b, 0xf6,=20
0x49, 0x89,
> 0x2a, 0x9f, 0x67, 0xd7, 5b6f2811172c96 Stephan M=FCller 2020-01-09  199=20
> 			0xb8, 0x1d, 0xbb, 0x5d, 0xf0, 0x1b, 0x60, 0xb6,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  200  			0xb7, 0xf3, 0x86, 0x6d, 0xe0,=20
0x04, 0xa1, 0xbc,
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  201  			0x3b, 0xb0,=20
0x10, 0x91,
> 0xe8, 0x22, 0x67, 0x5b, 5b6f2811172c96 Stephan M=FCller 2020-01-09  202=20
> 			0xe8, 0xf0, 0x4f, 0x82, 0x70, 0xc7, 0xe1, 0xc8,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  203  			0xd8, 0xad, 0x70, 0xcf, 0xf6,=20
5b6f2811172c96
> Stephan M=FCller 2020-01-09  204  		}, {
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  205  			0x60, 0x1f,=20
0x71, 0x07,
> 0x92, 0xae, 0xa0, 0x24, 5b6f2811172c96 Stephan M=FCller 2020-01-09  206=20
> 			0xb6, 0xa4, 0x10, 0x70, 0x1f, 0x94, 0x51, 0x9a,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  207  			0x5a, 0x81, 0xc4, 0x46, 0x78,=20
0x56, 0x71, 0xdd,
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  208  			0x45, 0x63,=20
0x01, 0x34,
> 0x87, 0x79, 0xb4, 0xd5, 5b6f2811172c96 Stephan M=FCller 2020-01-09  209=20
> 			0x91, 0x79, 0xb9, 0x93, 0x11, 0x44, 0x50, 0xad,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  210  			0x64, 0x7e, 0x5c, 0xec, 0x16,=20
5b6f2811172c96
> Stephan M=FCller 2020-01-09  211  		}, {
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  212  			0x49, 0x2f,=20
0xa0, 0x45,
> 0xf8, 0xb0, 0x80, 0x88, 5b6f2811172c96 Stephan M=FCller 2020-01-09  213=20
> 			0x79, 0xeb, 0xb6, 0x82, 0x1c, 0xf3, 0x67, 0xc4,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  214  			0x88, 0x88, 0xe9, 0x75, 0x20,=20
0x54, 0x78, 0xc6,
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  215  			0x5c, 0x59,=20
0xcf, 0xd9,
> 0x73, 0x12, 0x17, 0xf4, 5b6f2811172c96 Stephan M=FCller 2020-01-09  216=20
> 			0x30, 0x9c, 0xb7, 0x21, 0x45, 0xe2, 0xb6, 0x0c,=20
5b6f2811172c96 Stephan
> M=FCller 2020-01-09  217  			0x0c, 0xeb, 0x1b, 0xdc, 0xdc,=20
5b6f2811172c96
> Stephan M=FCller 2020-01-09  218  		}
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  219  	};
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  220  	struct lrng_pool *lrng_=
pool,
> *lrng_pool_aligned; 5b6f2811172c96 Stephan M=FCller 2020-01-09  221  	u8
> hash_df[sizeof(lrng_hash_df_selftest_result[0])] 5b6f2811172c96 Stephan
> M=FCller 2020-01-09  222  						=09
__aligned(sizeof(u32)); 5b6f2811172c96
> Stephan M=FCller 2020-01-09  223  	u32 generated;
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  224  	int ret =3D 0;
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  225
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  226=20
> 	BUILD_BUG_ON(ARRAY_SIZE(lrng_hash_df_selftest_result) < 5b6f2811172c96
> Stephan M=FCller 2020-01-09  227  					=09
	CONFIG_LRNG_POOL_SIZE);
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  228
> 5b6f2811172c96 Stephan M=FCller 2020-01-09 @229  	lrng_pool =3D
> kzalloc(sizeof(struct lrng_pool) + sizeof(LRNG_KCAPI_ALIGN),
> ^^^^^^^^^^^^^^^^^^^^^^^^ Here too.
>=20
>=20
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  230  			   =20
GFP_KERNEL);
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  231  	if (!lrng_pool)
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  232  		return
> LRNG_SEFLTEST_ERROR_HASHDF; 5b6f2811172c96 Stephan M=FCller 2020-01-09  2=
33=20
> 	lrng_pool_aligned =3D PTR_ALIGN(lrng_pool, sizeof(u32)); 5b6f2811172c96
> Stephan M=FCller 2020-01-09  234
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  235  	generated =3D
> __lrng_pool_hash_df(crypto_cb, NULL, lrng_pool_aligned, 5b6f2811172c96
> Stephan M=FCller 2020-01-09  236  				=09
hash_df, sizeof(hash_df) << 3);
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  237
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  238  	if ((generated >> 3) !=
=3D
> sizeof(hash_df) || 5b6f2811172c96 Stephan M=FCller 2020-01-09  239  	  =20
> memcmp(hash_df, lrng_hash_df_selftest_result[CONFIG_LRNG_POOL_SIZE],
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  240  		   sizeof(hash_df)))=20
{
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  241  		pr_err("LRNG Hash DF
> self-test FAILED\n"); 5b6f2811172c96 Stephan M=FCller 2020-01-09  242  	=
=09
ret
> =3D LRNG_SEFLTEST_ERROR_HASHDF; 5b6f2811172c96 Stephan M=FCller 2020-01-0=
9  243
>  	}
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  244
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  245  	kfree(lrng_pool);
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  246  	return ret;
> 5b6f2811172c96 Stephan M=FCller 2020-01-09  247  }
>=20
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology
> Center https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel
> Corporation



Ciao
Stephan



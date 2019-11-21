Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874EF105533
	for <lists+linux-api@lfdr.de>; Thu, 21 Nov 2019 16:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKUPT3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Nov 2019 10:19:29 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:25890 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUPT3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Nov 2019 10:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574349566;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2RiF8MQSa3XBV1fR1xKat6hykVT+ebuvV4G+mKmn2PA=;
        b=Nvqxc6vJkD4JxsRYaRyKivNQMKYiFdkybhgiuRLsD0kz8LBhAqZQ9WXx6yFkVUhn2K
        zm1gJqAbgNyUfx12CRiDw+eMFLMX8A2W0+80vxa20P1FUpC1LPOb2ce65Q/M6JaFB8ai
        sTXHzS8wGsgfZZNnhgD55FDi7EwZSfy0Zw6lOFtAVQu6+LRM5d+oUyi3Y+s2QDqsoO/S
        L+LQjv8fi7L9n61oVHnOJb/VPn443u2Vwom8IFgOqFolT3q8cbIeA/tkIRkrkSjIF68S
        7rHqn+Dw6rR+9T7IFqKssn7VlE316gxGUx5rPyT3s+HCxGg+Zl9aspIFGwcbxp6v8iU8
        N1Dg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXPSIvSWlTs="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vALFIJsIY
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Nov 2019 16:18:19 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Nicolai Stange <nstange@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v25 12/12] LRNG - add interface for gathering of raw entropy
Date:   Thu, 21 Nov 2019 16:18:18 +0100
Message-ID: <23500762.5LfuSYdpsK@positron.chronox.de>
In-Reply-To: <87a78pl8xp.fsf@suse.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <3610406.x8mDjznOIz@positron.chronox.de> <87a78pl8xp.fsf@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Donnerstag, 21. November 2019, 13:18:10 CET schrieb Nicolai Stange:

Hi Nicolai,

> Hi Stephan,
>=20
> two general remarks on debugfs usage below
>=20
> Stephan M=FCller <smueller@chronox.de> writes:
> > diff --git a/drivers/char/lrng/lrng_testing.c
> > b/drivers/char/lrng/lrng_testing.c new file mode 100644
> > index 000000000000..5c33d3bd2172
> > --- /dev/null
> > +++ b/drivers/char/lrng/lrng_testing.c
>=20
> <snip>
>=20
> > +/*
> > + * This data structure holds the dentry's of the debugfs files
> > establishing + * the interface to user space.
> > + */
> > +struct lrng_raw_debugfs {
> > +	struct dentry *lrng_raw_debugfs_root; /* root dentry */
> > +	struct dentry *lrng_raw_debugfs_lrng_raw; /* .../lrng_raw */
> > +};
> > +
> > +static struct lrng_raw_debugfs lrng_raw_debugfs;
> > +
> > +/* DebugFS operations and definition of the debugfs files */
> > +static ssize_t lrng_raw_read(struct file *file, char __user *to,
> > +			     size_t count, loff_t *ppos)
> > +{
> > +	loff_t pos =3D *ppos;
> > +	int ret;
> > +
> > +	if (!count)
> > +		return 0;
> > +	lrng_raw_entropy_init();
> > +	ret =3D lrng_raw_extract_user(to, count);
> > +	lrng_raw_entropy_fini();
> > +	if (ret < 0)
> > +		return ret;
> > +	count -=3D ret;
> > +	*ppos =3D pos + count;
> > +	return ret;
> > +}
> > +
> > +/* Module init: allocate memory, register the debugfs files */
> > +static int lrng_raw_debugfs_init(void)
> > +{
> > +	lrng_raw_debugfs.lrng_raw_debugfs_root =3D
> > +		debugfs_create_dir(KBUILD_MODNAME, NULL);
> > +	if (IS_ERR(lrng_raw_debugfs.lrng_raw_debugfs_root)) {
> > +		lrng_raw_debugfs.lrng_raw_debugfs_root =3D NULL;
> > +		return PTR_ERR(lrng_raw_debugfs.lrng_raw_debugfs_root);
> > +	}
>=20
> I think pointers returned by the debugfs API are not supposed to get
> checked for NULL/IS_ERR(), c.f commit ff9fb72bc077 ("debugfs: return
> error values, not NULL") or the the output from
>=20
>   git log --pretty=3Doneline | grep 'no need to check return value of
> debugfs_create'
>=20
> (Also the above code is dubious: you're effectively returning
>  PTR_ERR(NULL)).

Removed the check compliant to the mentioned patches.
>=20
> > +	return 0;
> > +}
> > +
> > +static struct file_operations lrng_raw_name_fops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.read =3D lrng_raw_read,
> > +};
> > +
> > +static int lrng_raw_debugfs_init_name(void)
> > +{
> > +	lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw =3D
> > +		debugfs_create_file("lrng_raw", 0400,
> > +				    lrng_raw_debugfs.lrng_raw_debugfs_root,
> > +				    NULL, &lrng_raw_name_fops);q
>=20
> CONFIG_LRNG_TESTING is a bool and thus, this debugfs file can't ever get
> removed. Even if it could, this inode hasn't got any data associated
> with it and so file removal would not be a problem for lrng_raw_read().

Correct.
>=20
> Please consider using debugfs_create_file_unsafe() instead to save
> debugfs from kmalloc()ing a proxy file_operations protecting your fops
> against concurrent file removal.

Yes, you are correct. Changed.
>=20
> > +	if (IS_ERR(lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw)) {
> > +		lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw =3D NULL;
> > +		return PTR_ERR(lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw);
> > +	}
>=20
> Same comment regarding return value checking applies here.

Same here: I removed the check.

With that, I also removed the static variable to maintain the two dentries=
=20
following the examples seen in other kernel code. Also, the __exit function=
 is=20
removed as we do not need it as you pointed out.

Thanks a lot.
>=20
> Thanks,
>=20
> Nicolai
>=20
> > +	return 0;
> > +}
> > +
> > +static int __init lrng_raw_init(void)
> > +{
> > +	int ret =3D lrng_raw_debugfs_init();
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D lrng_raw_debugfs_init_name();
> > +	if (ret < 0)
> > +		debugfs_remove_recursive(
> > +					lrng_raw_debugfs.lrng_raw_debugfs_root);
> > +
> > +	return ret;
> > +}
> > +
> > +static void __exit lrng_raw_exit(void)
> > +{
> > +	debugfs_remove_recursive(lrng_raw_debugfs.lrng_raw_debugfs_root);
> > +}
> > +
> > +module_init(lrng_raw_init);
> > +module_exit(lrng_raw_exit);
> > +
> > +MODULE_LICENSE("Dual BSD/GPL");
> > +MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
> > +MODULE_DESCRIPTION("Kernel module for gathering raw entropy");


Ciao
Stephan



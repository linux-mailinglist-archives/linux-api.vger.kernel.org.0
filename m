Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2C610522D
	for <lists+linux-api@lfdr.de>; Thu, 21 Nov 2019 13:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKUMSQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 21 Nov 2019 07:18:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:32998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfKUMSP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 21 Nov 2019 07:18:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C9E2B033;
        Thu, 21 Nov 2019 12:18:13 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>
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
        Nicolai Stange <nstange@suse.de>,
        "Peter\, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v25 12/12] LRNG - add interface for gathering of raw entropy
References: <6157374.ptSnyUpaCn@positron.chronox.de>
        <2787174.DQlWHN5GGo@positron.chronox.de>
        <3610406.x8mDjznOIz@positron.chronox.de>
Date:   Thu, 21 Nov 2019 13:18:10 +0100
In-Reply-To: <3610406.x8mDjznOIz@positron.chronox.de> ("Stephan
 \=\?utf-8\?Q\?M\=C3\=BCller\=22's\?\=
        message of "Sat, 16 Nov 2019 10:38:12 +0100")
Message-ID: <87a78pl8xp.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Stephan,

two general remarks on debugfs usage below

Stephan Müller <smueller@chronox.de> writes:

> diff --git a/drivers/char/lrng/lrng_testing.c b/drivers/char/lrng/lrng_testing.c
> new file mode 100644
> index 000000000000..5c33d3bd2172
> --- /dev/null
> +++ b/drivers/char/lrng/lrng_testing.c

<snip>


> +/*
> + * This data structure holds the dentry's of the debugfs files establishing
> + * the interface to user space.
> + */
> +struct lrng_raw_debugfs {
> +	struct dentry *lrng_raw_debugfs_root; /* root dentry */
> +	struct dentry *lrng_raw_debugfs_lrng_raw; /* .../lrng_raw */
> +};
> +
> +static struct lrng_raw_debugfs lrng_raw_debugfs;
> +
> +/* DebugFS operations and definition of the debugfs files */
> +static ssize_t lrng_raw_read(struct file *file, char __user *to,
> +			     size_t count, loff_t *ppos)
> +{
> +	loff_t pos = *ppos;
> +	int ret;
> +
> +	if (!count)
> +		return 0;
> +	lrng_raw_entropy_init();
> +	ret = lrng_raw_extract_user(to, count);
> +	lrng_raw_entropy_fini();
> +	if (ret < 0)
> +		return ret;
> +	count -= ret;
> +	*ppos = pos + count;
> +	return ret;
> +}
> +
> +/* Module init: allocate memory, register the debugfs files */
> +static int lrng_raw_debugfs_init(void)
> +{
> +	lrng_raw_debugfs.lrng_raw_debugfs_root =
> +		debugfs_create_dir(KBUILD_MODNAME, NULL);
> +	if (IS_ERR(lrng_raw_debugfs.lrng_raw_debugfs_root)) {
> +		lrng_raw_debugfs.lrng_raw_debugfs_root = NULL;
> +		return PTR_ERR(lrng_raw_debugfs.lrng_raw_debugfs_root);
> +	}

I think pointers returned by the debugfs API are not supposed to get
checked for NULL/IS_ERR(), c.f commit ff9fb72bc077 ("debugfs: return
error values, not NULL") or the the output from

  git log --pretty=oneline | grep 'no need to check return value of debugfs_create'

(Also the above code is dubious: you're effectively returning
 PTR_ERR(NULL)).



> +	return 0;
> +}
> +
> +static struct file_operations lrng_raw_name_fops = {
> +	.owner = THIS_MODULE,
> +	.read = lrng_raw_read,
> +};
> +
> +static int lrng_raw_debugfs_init_name(void)
> +{
> +	lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw =
> +		debugfs_create_file("lrng_raw", 0400,
> +				    lrng_raw_debugfs.lrng_raw_debugfs_root,
> +				    NULL, &lrng_raw_name_fops);q

CONFIG_LRNG_TESTING is a bool and thus, this debugfs file can't ever get
removed. Even if it could, this inode hasn't got any data associated
with it and so file removal would not be a problem for lrng_raw_read().

Please consider using debugfs_create_file_unsafe() instead to save
debugfs from kmalloc()ing a proxy file_operations protecting your fops
against concurrent file removal.



> +	if (IS_ERR(lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw)) {
> +		lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw = NULL;
> +		return PTR_ERR(lrng_raw_debugfs.lrng_raw_debugfs_lrng_raw);
> +	}

Same comment regarding return value checking applies here.

Thanks,

Nicolai


> +	return 0;
> +}
> +
> +static int __init lrng_raw_init(void)
> +{
> +	int ret = lrng_raw_debugfs_init();
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = lrng_raw_debugfs_init_name();
> +	if (ret < 0)
> +		debugfs_remove_recursive(
> +					lrng_raw_debugfs.lrng_raw_debugfs_root);
> +
> +	return ret;
> +}
> +
> +static void __exit lrng_raw_exit(void)
> +{
> +	debugfs_remove_recursive(lrng_raw_debugfs.lrng_raw_debugfs_root);
> +}
> +
> +module_init(lrng_raw_init);
> +module_exit(lrng_raw_exit);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
> +MODULE_DESCRIPTION("Kernel module for gathering raw entropy");

-- 
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg), GF: Felix Imendörffer

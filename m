Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B567418F231
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2020 10:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCWJxs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Mar 2020 05:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbgCWJxs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 23 Mar 2020 05:53:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5CDF2072D;
        Mon, 23 Mar 2020 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584957227;
        bh=vYQRdibAHre6Z0ZRM2+BRlR2nFJ0LeQHPRN+LvLMVBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yWjYuu7kvYMl56D+Y8BuUPq3QPFiMCKuoOxVlWQhwAM+Wm8idPdIVqevNxw69uAAk
         ovtTcEbcF8rxF1O0XGhGCwlQyvi72gjTGLHWblk502xAlVEL1Pik4+Qi5JPX9hQqV2
         2pOn7t/JqTJs1YpmmO9wrZEG1pWDWllk+Oa0PCDY=
Date:   Mon, 23 Mar 2020 10:53:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     leon@kernel.org, vbabka@suse.cz, adobriyan@gmail.com,
        akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, kasong@redhat.com,
        bhe@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, linux-api@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/3] meminfo_extra: introduce meminfo extra
Message-ID: <20200323095344.GB425358@kroah.com>
References: <20200323080503.6224-1-jaewon31.kim@samsung.com>
 <CGME20200323080508epcas1p387c9c19b480da53be40fe5d51e76a477@epcas1p3.samsung.com>
 <20200323080503.6224-2-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323080503.6224-2-jaewon31.kim@samsung.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 23, 2020 at 05:05:01PM +0900, Jaewon Kim wrote:
> Provide APIs to drivers so that they can show its memory usage on
> /proc/meminfo_extra.
> 
> int register_meminfo_extra(atomic_long_t *val, int shift,
> 			   const char *name);
> int unregister_meminfo_extra(atomic_long_t *val);

Nit, isn't it nicer to have the subsystem name first:
	meminfo_extra_register()
	meminfo_extra_unregister()
?



> 
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
> v2: move to /proc/meminfo_extra as a new file, meminfo_extra.c
>     use rcu to reduce lock overhead
> v1: print info at /proc/meminfo
> ---
>  fs/proc/Makefile        |   1 +
>  fs/proc/meminfo_extra.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mm.h      |   4 ++
>  mm/page_alloc.c         |   1 +
>  4 files changed, 129 insertions(+)
>  create mode 100644 fs/proc/meminfo_extra.c
> 
> diff --git a/fs/proc/Makefile b/fs/proc/Makefile
> index bd08616ed8ba..83d2f55591c6 100644
> --- a/fs/proc/Makefile
> +++ b/fs/proc/Makefile
> @@ -19,6 +19,7 @@ proc-y	+= devices.o
>  proc-y	+= interrupts.o
>  proc-y	+= loadavg.o
>  proc-y	+= meminfo.o
> +proc-y	+= meminfo_extra.o
>  proc-y	+= stat.o
>  proc-y	+= uptime.o
>  proc-y	+= util.o
> diff --git a/fs/proc/meminfo_extra.c b/fs/proc/meminfo_extra.c
> new file mode 100644
> index 000000000000..bd3f0d2b7fb7
> --- /dev/null
> +++ b/fs/proc/meminfo_extra.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/mm.h>
> +#include <linux/proc_fs.h>
> +#include <linux/seq_file.h>
> +#include <linux/slab.h>
> +
> +static void show_val_kb(struct seq_file *m, const char *s, unsigned long num)
> +{
> +	seq_put_decimal_ull_width(m, s, num << (PAGE_SHIFT - 10), 8);
> +	seq_write(m, " kB\n", 4);
> +}
> +
> +static LIST_HEAD(meminfo_head);
> +static DEFINE_SPINLOCK(meminfo_lock);
> +
> +#define NAME_SIZE      15
> +#define NAME_BUF_SIZE  (NAME_SIZE + 2) /* ':' and '\0' */
> +
> +struct meminfo_extra {
> +	struct list_head list;
> +	atomic_long_t *val;
> +	int shift_for_page;
> +	char name[NAME_BUF_SIZE];
> +	char name_pad[NAME_BUF_SIZE];
> +};
> +
> +int register_meminfo_extra(atomic_long_t *val, int shift, const char *name)
> +{
> +	struct meminfo_extra *meminfo, *memtemp;
> +	int len;
> +	int error = 0;
> +
> +	meminfo = kzalloc(sizeof(*meminfo), GFP_KERNEL);
> +	if (!meminfo) {
> +		error = -ENOMEM;
> +		goto out;
> +	}
> +
> +	meminfo->val = val;
> +	meminfo->shift_for_page = shift;
> +	strncpy(meminfo->name, name, NAME_SIZE);
> +	len = strlen(meminfo->name);
> +	meminfo->name[len] = ':';
> +	strncpy(meminfo->name_pad, meminfo->name, NAME_BUF_SIZE);
> +	while (++len < NAME_BUF_SIZE - 1)
> +		meminfo->name_pad[len] = ' ';
> +
> +	spin_lock(&meminfo_lock);
> +	list_for_each_entry_rcu(memtemp, &meminfo_head, list) {
> +		if (memtemp->val == val) {
> +			error = -EINVAL;
> +			break;
> +		}
> +	}
> +	if (!error)
> +		list_add_tail_rcu(&meminfo->list, &meminfo_head);
> +	spin_unlock(&meminfo_lock);

If you have a lock, why are you needing rcu?



> +	if (error)
> +		kfree(meminfo);
> +out:
> +
> +	return error;
> +}
> +EXPORT_SYMBOL(register_meminfo_extra);

EXPORT_SYMBOL_GPL()?  I have to ask :)

thanks,

greg k-h

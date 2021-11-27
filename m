Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4606345FD7E
	for <lists+linux-api@lfdr.de>; Sat, 27 Nov 2021 10:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbhK0JLn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 27 Nov 2021 04:11:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57528 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243251AbhK0JJm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 27 Nov 2021 04:09:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DDF8B816FE;
        Sat, 27 Nov 2021 09:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB15CC53FBF;
        Sat, 27 Nov 2021 09:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638003985;
        bh=7ZxzHbakeIbEdtCuA5Ngh5y8QfTAoq9DN0W+00ku/AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1JPX0SVDukFTdxxjgKpSQJzVrurdA093u2MnpDLTo1FKC6lNPviHczNCg44aYJRda
         HEZDrcCc/N5eSbpmojKj2SCotEN+Ra18AremJ/97LpLBfDAmIRc9bCf59es5RhnTHl
         ilFsrIhTBoAKnBh4qcXhrFXXhlNdSx9X0MjGauhU=
Date:   Sat, 27 Nov 2021 10:06:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YaH1CmHClx5WvDWD@kroah.com>
References: <20211126212514.173334-1-ebiggers@kernel.org>
 <20211126212514.173334-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126212514.173334-4-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 26, 2021 at 01:25:14PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add sysfs files that expose the inline encryption capabilities of
> request queues:
> 
> 	/sys/class/block/$disk/queue/crypto/max_dun_bits
> 	/sys/class/block/$disk/queue/crypto/modes/$mode
> 	/sys/class/block/$disk/queue/crypto/num_keyslots
> 
> Userspace can use these new files to decide what encryption settings to
> use, or whether to use inline encryption at all.  This also brings the
> crypto capabilities in line with the other queue properties, which are
> already discoverable via the queue directory in sysfs.
> 
> Design notes:
> 
>   - Place the new files in a new subdirectory "crypto" to group them
>     together and to avoid complicating the main "queue" directory.  This
>     also makes it possible to replace "crypto" with a symlink later if
>     we ever make the blk_crypto_profiles into real kobjects (see below).
> 
>   - It was necessary to define a new kobject that corresponds to the
>     crypto subdirectory.  For now, this kobject just contains a pointer
>     to the blk_crypto_profile.  Note that multiple queues (and hence
>     multiple such kobjects) may refer to the same blk_crypto_profile.
> 
>     An alternative design would more closely match the current kernel
>     data structures: the blk_crypto_profile could be a kobject itself,
>     located directly under the host controller device's kobject, while
>     /sys/class/block/$disk/queue/crypto would be a symlink to it.
> 
>     I decided not to do that for now because it would require a lot more
>     changes, such as no longer embedding blk_crypto_profile in other
>     structures, and also because I'm not sure we can rule out moving the
>     crypto capabilities into 'struct queue_limits' in the future.  (Even
>     if multiple queues share the same crypto engine, maybe the supported
>     data unit sizes could differ due to other queue properties.)  It
>     would also still be possible to switch to that design later without
>     breaking userspace, by replacing the directory with a symlink.
> 
>   - Use "max_dun_bits" instead of "max_dun_bytes".  Currently, the
>     kernel internally stores this value in bytes, but that's an
>     implementation detail.  It probably makes more sense to talk about
>     this value in bits, and choosing bits is more future-proof.
> 
>   - "modes" is a sub-subdirectory, since there may be multiple supported
>     crypto modes, and sysfs is supposed to have one value per file.
> 
>   - Each mode had to be named.  The crypto API names like "xts(aes)" are
>     not appropriate because they don't specify the key size.  Therefore,
>     I assigned new names.  The exact names chosen are arbitrary, but
>     they happen to match the names used in log messages in fs/crypto/.
> 
>   - The "num_keyslots" file is a bit different from the others in that
>     it is only useful to know for performance reasons.  However, it's
>     included as it can still be useful.  For example, a user might not
>     want to use inline encryption if there aren't very many keyslots.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/block/queue-sysfs.rst |  30 +++++
>  block/Makefile                      |   3 +-
>  block/blk-crypto-internal.h         |  12 ++
>  block/blk-crypto-sysfs.c            | 177 ++++++++++++++++++++++++++++
>  block/blk-crypto.c                  |   3 +
>  block/blk-sysfs.c                   |   6 +
>  include/linux/blkdev.h              |   1 +
>  7 files changed, 231 insertions(+), 1 deletion(-)
>  create mode 100644 block/blk-crypto-sysfs.c
> 
> diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
> index 3f569d5324857..252939f340459 100644
> --- a/Documentation/block/queue-sysfs.rst
> +++ b/Documentation/block/queue-sysfs.rst

Why is all of this information not in Documentation/ABI/ like the rest
of the kernel's sysfs information?  When it is there it can be
automatically tested as well.

Please don't add new entries to the wrong place if at all possible.


> --- /dev/null
> +++ b/block/blk-crypto-sysfs.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Google LLC
> + *
> + * sysfs support for blk-crypto.  This file contains the code which exports the
> + * crypto capabilities of devices via /sys/class/block/$disk/queue/crypto/.
> + */
> +
> +#include <linux/blk-crypto-profile.h>
> +
> +#include "blk-crypto-internal.h"
> +
> +struct blk_crypto_kobj {
> +	struct kobject kobj;
> +	struct blk_crypto_profile *profile;
> +};
> +
> +struct blk_crypto_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct blk_crypto_profile *profile,
> +			struct blk_crypto_attr *attr, char *page);
> +};
> +
> +static struct blk_crypto_profile *kobj_to_crypto_profile(struct kobject *kobj)
> +{
> +	return container_of(kobj, struct blk_crypto_kobj, kobj)->profile;
> +}
> +
> +static struct blk_crypto_attr *attr_to_crypto_attr(struct attribute *attr)
> +{
> +	return container_of(attr, struct blk_crypto_attr, attr);
> +}
> +
> +static ssize_t blk_crypto_max_dun_bits_show(struct blk_crypto_profile *profile,
> +					    struct blk_crypto_attr *attr,
> +					    char *page)
> +{
> +	return sprintf(page, "%u\n", 8 * profile->max_dun_bytes_supported);

sysfs_emit() please, for this, and all other show functions.

> +}
> +
> +static ssize_t blk_crypto_num_keyslots_show(struct blk_crypto_profile *profile,
> +					    struct blk_crypto_attr *attr,
> +					    char *page)
> +{
> +	return sprintf(page, "%u\n", profile->num_slots);
> +}
> +
> +#define BLK_CRYPTO_RO_ATTR(_name)			\
> +static struct blk_crypto_attr blk_crypto_##_name = {	\
> +	.attr	= { .name = #_name, .mode = 0444 },	\

__ATTR_RO()?

> +	.show	= blk_crypto_##_name##_show,		\
> +}
> +
> +BLK_CRYPTO_RO_ATTR(max_dun_bits);
> +BLK_CRYPTO_RO_ATTR(num_keyslots);
> +
> +static struct attribute *blk_crypto_attrs[] = {
> +	&blk_crypto_max_dun_bits.attr,
> +	&blk_crypto_num_keyslots.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group blk_crypto_attr_group = {
> +	.attrs = blk_crypto_attrs,
> +};
> +
> +/*
> + * The encryption mode attributes.  To avoid hard-coding the list of encryption
> + * modes, these are initialized at boot time by blk_crypto_sysfs_init().
> + */
> +static struct blk_crypto_attr __blk_crypto_mode_attrs[BLK_ENCRYPTION_MODE_MAX];
> +static struct attribute *blk_crypto_mode_attrs[BLK_ENCRYPTION_MODE_MAX + 1];
> +
> +static umode_t blk_crypto_mode_is_visible(struct kobject *kobj,
> +					  struct attribute *attr, int n)
> +{
> +	struct blk_crypto_profile *profile = kobj_to_crypto_profile(kobj);
> +	struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
> +	int mode_num = a - __blk_crypto_mode_attrs;
> +
> +	if (profile->modes_supported[mode_num])
> +		return 0444;
> +	return 0;
> +}
> +
> +static ssize_t blk_crypto_mode_show(struct blk_crypto_profile *profile,
> +				    struct blk_crypto_attr *attr, char *page)
> +{
> +	int mode_num = attr - __blk_crypto_mode_attrs;
> +
> +	return sprintf(page, "0x%x\n", profile->modes_supported[mode_num]);
> +}
> +
> +static const struct attribute_group blk_crypto_modes_attr_group = {
> +	.name = "modes",
> +	.attrs = blk_crypto_mode_attrs,
> +	.is_visible = blk_crypto_mode_is_visible,
> +};
> +
> +static const struct attribute_group *blk_crypto_attr_groups[] = {
> +	&blk_crypto_attr_group,
> +	&blk_crypto_modes_attr_group,
> +	NULL,
> +};

ATTRIBUTE_GROUP()?

Hm, maybe not, but I think it could be used here.

> +
> +static ssize_t blk_crypto_attr_show(struct kobject *kobj,
> +				    struct attribute *attr, char *page)
> +{
> +	struct blk_crypto_profile *profile = kobj_to_crypto_profile(kobj);
> +	struct blk_crypto_attr *a = attr_to_crypto_attr(attr);
> +
> +	return a->show(profile, a, page);
> +}
> +
> +static const struct sysfs_ops blk_crypto_attr_ops = {
> +	.show = blk_crypto_attr_show,
> +};
> +
> +static void blk_crypto_release(struct kobject *kobj)
> +{
> +	kfree(container_of(kobj, struct blk_crypto_kobj, kobj));
> +}
> +
> +static struct kobj_type blk_crypto_ktype = {
> +	.default_groups = blk_crypto_attr_groups,
> +	.sysfs_ops	= &blk_crypto_attr_ops,
> +	.release	= blk_crypto_release,
> +};
> +
> +/*
> + * If the request_queue has a blk_crypto_profile, create the "crypto"
> + * subdirectory in sysfs (/sys/class/block/$disk/queue/crypto/).
> + */
> +int blk_crypto_sysfs_register(struct request_queue *q)
> +{
> +	struct blk_crypto_kobj *obj;
> +	int err;
> +
> +	if (!q->crypto_profile)
> +		return 0;
> +
> +	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
> +	if (!obj)
> +		return -ENOMEM;
> +	obj->profile = q->crypto_profile;
> +
> +	err = kobject_init_and_add(&obj->kobj, &blk_crypto_ktype, &q->kobj,
> +				   "crypto");
> +	if (err) {
> +		kobject_put(&obj->kobj);
> +		return err;
> +	}
> +	q->crypto_kobject = &obj->kobj;
> +	return 0;
> +}
> +
> +void blk_crypto_sysfs_unregister(struct request_queue *q)
> +{
> +	kobject_put(q->crypto_kobject);
> +}
> +
> +static int __init blk_crypto_sysfs_init(void)
> +{
> +	int i;
> +
> +	BUILD_BUG_ON(BLK_ENCRYPTION_MODE_INVALID != 0);
> +	for (i = 1; i < BLK_ENCRYPTION_MODE_MAX; i++) {
> +		struct blk_crypto_attr *attr = &__blk_crypto_mode_attrs[i];

sysfs_attr_init() might be needed here, have you run with lockdep
enabled?

Other than those minor things, nice work, all looks good.

greg k-h

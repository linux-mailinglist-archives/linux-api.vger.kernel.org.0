Return-Path: <linux-api+bounces-459-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEF2825B8F
	for <lists+linux-api@lfdr.de>; Fri,  5 Jan 2024 21:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868711C20BC4
	for <lists+linux-api@lfdr.de>; Fri,  5 Jan 2024 20:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C736099;
	Fri,  5 Jan 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3Oj5b5r"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03B36090;
	Fri,  5 Jan 2024 20:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E950C433C8;
	Fri,  5 Jan 2024 20:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704486362;
	bh=8+sAqgT0ExxQ53/lwPJqJZkUDBOZ2igVrzipIApt6bs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X3Oj5b5rRuD2Cv/yxM1QLj+kwIkZ+5P7eAYfrIgVRDSoZE3vI9E8kmI4Ura1DM3MF
	 t/qdVe9Cid1zHVsHph91U+uknrv32k0vEbw7WjZsmX0zOeVi8xYMnFIe50rGMjR+fx
	 UekLKLOTv7NY0oSXkLPZ5PDaeVFm2PTVvCcWuaOr1TKi172Z+gvmxeDFQ2Ih6JTYUb
	 orcUzgBZ0Oagw+y7BtxryF8up3N3uRIowdmarhKjRNSunvdJOcEa5ubwOF8ngVpFg1
	 nI7CFHhx5ZIL2kXkRlzyW0gf+NZ5bmI56yLHVklR/3mR7KZsy4cXuGbFKgM5GtBanJ
	 jH3OC4gpEU5dg==
Date: Fri, 5 Jan 2024 21:25:56 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org
Subject: Re: [PATCH 1/5] docs: move admin-guide/sysfs-rules.rst to
 userspace-api/
Message-ID: <20240105212556.503ffa68@coco.lan>
In-Reply-To: <20240104160946.3450743-1-vegard.nossum@oracle.com>
References: <20240104160946.3450743-1-vegard.nossum@oracle.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu,  4 Jan 2024 17:09:42 +0100
Vegard Nossum <vegard.nossum@oracle.com> escreveu:

> This file documents how userspace ought to interact with sysfs. It is
> clearly intended for applications that access sysfs programmatically,
> rather than at users or admins.
> 

> Move it to the userspace API guide.

Hmm... this is both uAPI and admin stuff, as sysfs nodes can be used
directly on scripts written by sysadmin.

Perhaps we should add a link from one book to the other one, specially
if we move it to uAPI guide.

Regards,
Mauro


> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/ABI/stable/sysfs-devices                 |  2 +-
>  Documentation/admin-guide/index.rst                    |  9 ---------
>  Documentation/userspace-api/index.rst                  | 10 +++++++++-
>  .../{admin-guide => userspace-api}/sysfs-rules.rst     |  0
>  tools/lib/api/fs/fs.c                                  |  2 +-
>  5 files changed, 11 insertions(+), 12 deletions(-)
>  rename Documentation/{admin-guide => userspace-api}/sysfs-rules.rst (100%)
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices b/Documentation/ABI/stable/sysfs-devices
> index 98a8ef99ac5f..7829414cba62 100644
> --- a/Documentation/ABI/stable/sysfs-devices
> +++ b/Documentation/ABI/stable/sysfs-devices
> @@ -1,6 +1,6 @@
>  Note:
>    This documents additional properties of any device beyond what
> -  is documented in Documentation/admin-guide/sysfs-rules.rst
> +  is documented in Documentation/userspace-api/sysfs-rules.rst
>  
>  What:		/sys/devices/*/of_node
>  Date:		February 2015
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 43ea35613dfc..c2b032314a24 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -47,15 +47,6 @@ problems and bugs in particular.
>     perf/index
>     pstore-blk
>  
> -This is the beginning of a section with information of interest to
> -application developers.  Documents covering various aspects of the kernel
> -ABI will be found here.
> -
> -.. toctree::
> -   :maxdepth: 1
> -
> -   sysfs-rules
> -
>  This is the beginning of a section with information of interest to
>  application developers and system integrators doing analysis of the
>  Linux kernel for safety critical applications. Documents supporting
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index 74bc0716432e..6ce2edf519f6 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -9,8 +9,16 @@ While much of the kernel's user-space API is documented elsewhere
>  also be found in the kernel tree itself.  This manual is intended to be the
>  place where this information is gathered.
>  
> +General documentation:
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   sysfs-rules
> +
> +Subsystem-specific documentation:
> +
>  .. toctree::
> -   :caption: Table of contents
>     :maxdepth: 2
>  
>     no_new_privs
> diff --git a/Documentation/admin-guide/sysfs-rules.rst b/Documentation/userspace-api/sysfs-rules.rst
> similarity index 100%
> rename from Documentation/admin-guide/sysfs-rules.rst
> rename to Documentation/userspace-api/sysfs-rules.rst
> diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
> index 5cb0eeec2c8a..c35247b6ad81 100644
> --- a/tools/lib/api/fs/fs.c
> +++ b/tools/lib/api/fs/fs.c
> @@ -214,7 +214,7 @@ static void mem_toupper(char *f, size_t len)
>  
>  /*
>   * Check for "NAME_PATH" environment variable to override fs location (for
> - * testing). This matches the recommendation in Documentation/admin-guide/sysfs-rules.rst
> + * testing). This matches the recommendation in Documentation/userspace-api/sysfs-rules.rst
>   * for SYSFS_PATH.
>   */
>  static bool fs__env_override(struct fs *fs)



Thanks,
Mauro


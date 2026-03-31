Return-Path: <linux-api+bounces-6049-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJYRORcuzGkmQgYAu9opvQ
	(envelope-from <linux-api+bounces-6049-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 22:27:03 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD3D371275
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 22:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE9C330416C7
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC444E038;
	Tue, 31 Mar 2026 20:25:55 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58AF3590A9;
	Tue, 31 Mar 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774988755; cv=none; b=kfyg6PBAAP7SG8wPfOqJkfE8kRUnR5A8YsuXvCAtcw9fNGgbK6wvx12WoiYy9zED/yfDsfMW7pTr0nadFvnDAKCGfuNw8lkKNxMYA44n6mlkHx4+jCakgaL/dlPdhrd9ta7v9W8n51DkLm+i2YqesqfWzORdDREsA84xlKZR53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774988755; c=relaxed/simple;
	bh=sJT8kMf7d4IPQrWuI+jNDGT9jVMf5s6JT+I5ZqnAs5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ndy8E7bDVlZyx7SAWv7+UJD0wxJNdLV7aPv0rIFlzOuW71d7YAyio01AGqGo+NxljNrxNkQ+yn/1muSFl/gerKqto+oWK0Zz2LchS2rPPi2hFJ3Fyrb9txRpEQ2+Xesug93QD5EF9kSdD+u5cjPQaCMYtfGkCllw08H/Gpjejy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=droneaud.fr; spf=pass smtp.mailfrom=droneaud.fr; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=droneaud.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=droneaud.fr
Received: from [IPV6:2a01:e0a:263:a640:d1:87bf:b1a6:8517] (unknown [IPv6:2a01:e0a:263:a640:d1:87bf:b1a6:8517])
	(Authenticated sender: ydroneaud@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 92A1E13F8AD;
	Tue, 31 Mar 2026 22:25:05 +0200 (CEST)
Message-ID: <df5a6fec-ca67-4196-9e7b-cd129c79578e@droneaud.fr>
Date: Tue, 31 Mar 2026 22:25:03 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
To: Jori Koolstra <jkoolstra@xs4all.nl>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
 Shuah Khan <shuah@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>,
 Alexander Aring <alex.aring@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Andrey Albershteyn <aalbersh@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Aleksa Sarai
 <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 cmirabil@redhat.com, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
 <20260331172011.3512876-2-jkoolstra@xs4all.nl>
Content-Language: fr-FR, en-US, en-GB
From: Yann Droneaud <yann@droneaud.fr>
In-Reply-To: <20260331172011.3512876-2-jkoolstra@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[droneaud.fr];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6049-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_SPAM(0.00)[0.737];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yann@droneaud.fr,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,droneaud.fr:mid,xs4all.nl:email]
X-Rspamd-Queue-Id: AFD3D371275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Le 31/03/2026 à 19:19, Jori Koolstra a écrit :
> Currently there is no way to race-freely create and open a directory.
> For regular files we have open(O_CREAT) for creating a new file inode,
> and returning a pinning fd to it. The lack of such functionality for
> directories means that when populating a directory tree there's always
> a race involved: the inodes first need to be created, and then opened
> to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> but in the time window between the creation and the opening they might
> be replaced by something else.
>
> Addressing this race without proper APIs is possible (by immediately
> fstat()ing what was opened, to verify that it has the right inode type),
> but difficult to get right. Hence, mkdirat_fd() that creates a directory
> and returns an O_DIRECTORY fd is useful.
>
> This feature idea (and description) is taken from the UAPI group:
> https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>   arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>   fs/internal.h                          |  1 +
>   fs/namei.c                             | 26 ++++++++++++++++++++++++--
>   include/linux/fcntl.h                  |  2 ++
>   include/linux/syscalls.h               |  2 ++
>   include/uapi/asm-generic/fcntl.h       |  3 +++
>   include/uapi/asm-generic/unistd.h      |  5 ++++-
>   scripts/syscall.tbl                    |  1 +
>   8 files changed, 38 insertions(+), 3 deletions(-)

> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index a332e79b3207..d2f0fdb82847 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -25,6 +25,8 @@
>   #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
>   #endif
>   
> +#define VALID_MKDIRAT_FD_FLAGS	(MKDIRAT_FD_NEED_FD)
> +

I don't see support for O_CLOEXEC-ish flag, is the file descriptor in 
close-on-exec mode by default ? If yes, it should be mentioned.


> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index 613475285643..621458bf1fbf 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -95,6 +95,9 @@
>   #define O_NDELAY	O_NONBLOCK
>   #endif
>   
> +/* Flags for mkdirat_fd */
> +#define MKDIRAT_FD_NEED_FD	0x01
> +


Regards.




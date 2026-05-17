Return-Path: <linux-api+bounces-6343-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAgQC2U0CmqixgQAu9opvQ
	(envelope-from <linux-api+bounces-6343-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2026 23:34:29 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB42D56404A
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2026 23:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4ED5B3002896
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2026 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7AA3002BB;
	Sun, 17 May 2026 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOyb+b7z"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A146176238
	for <linux-api@vger.kernel.org>; Sun, 17 May 2026 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779053665; cv=none; b=FZ021OpTEmWzAzRu8m+/uTIMvzr4Qp5CtDb98L+w9fFmI5mGwS3pZpobl0HDV6+eiaDCjHYMJ+ESpe/LN8emqYCyKaCfQ93ddV3tbhC1Pypf0phebeLa9RYWQNh/Oq1HfD38DUmSinD58E5NycKST7/XEW2zSzsl4Nna7x+q6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779053665; c=relaxed/simple;
	bh=7pmDqiNMFAWA6ss6wguWIoo3ZU7K/66a2eZ9dsWzP6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pn4t2gpqOmvoMxR+DIH0aBgWvkJIj1hkPvkYxIDYJfzNEchKoS9NDHhPsXPdJMcCFUwuRCc7I3wjNJlYReYZgaj1WZDBP7SSk2YqBPWR/QGl4qCCQr9pwDbWVlHa8Xc20uqh8PX0OsY3jPmPmErdQZh/H0J/bpkAUXLNST9IyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOyb+b7z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso16324495e9.3
        for <linux-api@vger.kernel.org>; Sun, 17 May 2026 14:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779053662; x=1779658462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jowbETNoUhlLBVOkFK2p96CeL17LN1x91A+MDtDQyE=;
        b=gOyb+b7zVM1OMc0IIuYguLZns4KACZWSgQXt2IO3Tn6KzHrVbHQHkrHbqMArOJJDQC
         vVJ9zp0mkoRrCXu4FdnM5w9qYgf+VABNMR4GMfmCmEuTwaHVOMg221WHJuvfXZ1iadyW
         CBz0+u9VMV9xdiI+jn7vJZnqdHG4cvwX8vQzKa9LrsNsPe/LIy3O50DlN3qhLM544ovw
         Z1kt2wi8lTJ61w/LVggKdTSHDD2Bqc7LZNDx3sSaBu9epHC/UJpCZH0ju5TgqE2dGzBG
         V9YWjEVtpapAUp1BbW9geUllF6QO1MwTyhrBbQAj53S4aHYDa4mQVBkW5oD2HdPrVKZB
         r5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779053662; x=1779658462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2jowbETNoUhlLBVOkFK2p96CeL17LN1x91A+MDtDQyE=;
        b=eZ9JePRXuaS+OayGotbHwnSOnM5F7Zgax4lVEN/QpSTr1b7oPftu/0+hDGlitHQ6kD
         Isn7t/y5MSwXi5Q3Yl9WoIA751P+Luvp2cD1Ut9d2AbRThJa2YWNU6kG29M/Gqib9CvB
         fW8IPeTqEsW31yw/LvXXSUYycbmjOl4w+1XTCQ1CmbyTPIot3sv5nsASq5vbRkZAlEE2
         gsTsvaeXEvDlib31nyLEeUOqWTYDeEW1/09Y94+/Vr2MwRB3GSAcSUximqcGLuWD5gNO
         3j5v9hgquSb/FOFANo2hUVUFnqVSYQ5Y2vwN6QFnzUHtGr564lIlgw3LtZemV6hyt1z0
         SIgw==
X-Forwarded-Encrypted: i=1; AFNElJ/XQ0zUnvOJBXcqHcmUDrVxxftOdTWDyETAw0VWB+reclkMi2Tt6/Yh5Snqifwxcx5ZiAYUbIyD6zY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt04aivT3ThCQdaOuiFxahLf0KateWQJVsh8dgJ3bzpKPr3yof
	4mt+Tjdxbj8JeL8U8ATq/RAkkUh0b2PxiEBTGlp+dmyR6k4/IGVO9xy262+MEI59
X-Gm-Gg: Acq92OHvGknPQfmcm425cN9+fc/Iu1323hICy4FzB3bc3U9buVS/qOvEGQkQEshw6/v
	ZMppQjMxKx+LqeYQu8LPBSCuzS4zeAJcod+IYtyrChA5DxTu3HK5p7knbNqI/Ff5ihV7NvgDt+x
	5zu50r1ghVnRI2Qse3MTPZtJSPQY/JTqYJ2yKA5EP9980a4D0BuVApKITDp6SktzR0+QBfwuh/a
	CeYRHJEbrN9qRfkOFqtVpS9LzKcub2VROozvPvhL6NUWjQeEfWmrq38/YpmDaEFkYs1BiE0Ivtk
	GHJHoXofSg2F0Mk/Pr3Zqxx5a6hP1CMxvx1/ojxcdDjjVObTt+iSeAra7LOLpWrbWP7rLeb7WCC
	4J4H9UarEr/meept11vPgcoBZlBCp9eMwoxxEagmh4xYRrYSFMe8e/7hbpkCtMBzhuTVAmnTu0M
	OGpohkvj/GQxsrMjO+0uPdfSSPiksgLHywVJ9L3b9p7eRTzP9KWFf+mmKYJ5orRyt6
X-Received: by 2002:a05:600c:885:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-48fe6517fdfmr116464375e9.27.1779053662255;
        Sun, 17 May 2026 14:34:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm34621522f8f.25.2026.05.17.14.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 14:34:21 -0700 (PDT)
Date: Sun, 17 May 2026 22:34:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Christian Brauner
 <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Shuah Khan
 <shuah@kernel.org>, willy@infradead.org, mathieu.desnoyers@efficios.com,
 Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org,
 Yafang Shao <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com,
 arnaldo.melo@gmail.com, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, linux-mm@kvack.org,
 linux-api@vger.kernel.org
Subject: Re: [PATCH 3/6] string: Introduce strtostr() for safe and
 performance string copies
Message-ID: <20260517223419.3262de7c@pumpkin>
In-Reply-To: <20260517-tonyk-long_name-v1-3-3c282eaa91e2@igalia.com>
References: <20260517-tonyk-long_name-v1-0-3c282eaa91e2@igalia.com>
	<20260517-tonyk-long_name-v1-3-3c282eaa91e2@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DB42D56404A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6343-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,igalia.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, 17 May 2026 15:36:13 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Some parts of the kernel uses memcpy() instead of strscpy() because they
> are performance sensitive and doesn't care about the return value of
> strscpy(). One such common case is to copy current->comm to a different
> buffer.
>=20
> As the command name is guaranteed to be NUL-terminated in the range of
> TASK_COMM_LEN, this is safe enough and doesn't create unterminated
> strings. However, in order to expand the size of current->comm, this
> expectation will be broken and those memcpy() could create such strings
> without trailing NUL byte.
>=20
> In order to support a fast and safe string copy, create strtostr(), to co=
py
> a NUL-terminated string to a new string buffer. If the destination buffer
> is bigger than the source, no pad is applied, but the string is
> NUL-terminated. If the destination buffer is smaller, the string is
> truncated. The last byte of the destination is always set to NUL for safe=
ty.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  include/linux/coredump.h                           |  2 +-
>  include/linux/string.h                             | 28 ++++++++++++++++=
++++++
>  include/linux/tracepoint.h                         |  4 ++--
>  include/trace/events/block.h                       | 10 ++++----
>  include/trace/events/coredump.h                    |  2 +-
>  include/trace/events/f2fs.h                        |  4 ++--
>  include/trace/events/oom.h                         |  2 +-
>  include/trace/events/osnoise.h                     |  2 +-
>  include/trace/events/sched.h                       | 10 ++++----
>  include/trace/events/signal.h                      |  2 +-
>  include/trace/events/task.h                        |  4 ++--
>  kernel/printk/nbcon.c                              |  2 +-
>  kernel/printk/printk.c                             |  2 +-
>  tools/bpf/bpftool/pids.c                           |  4 ++--
>  .../selftests/bpf/test_kmods/bpf_testmod-events.h  |  2 +-
>  15 files changed, 54 insertions(+), 26 deletions(-)
>=20
> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> index 68861da4cf7c..b370ef69f673 100644
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -54,7 +54,7 @@ extern void vfs_coredump(const kernel_siginfo_t *siginf=
o);
>  	do {	\
>  		char comm[TASK_COMM_LEN];	\
>  		/* This will always be NUL terminated. */ \
> -		memcpy(comm, current->comm, sizeof(comm)); \
> +		strtostr(comm, current->comm); \
>  		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
>  			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
>  	} while (0)	\
> diff --git a/include/linux/string.h b/include/linux/string.h
> index b850bd91b3d8..ff1f59f4139c 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -445,6 +445,34 @@ void memcpy_and_pad(void *dest, size_t dest_len, con=
st void *src, size_t count,
>  	memcpy(dest, src, strnlen(src, min(_src_len, _dest_len)));	\
>  } while (0)
> =20
> +/**
> + * strtostr - Copy NUL-terminanted string to NUL-terminate string
> + *
> + * @dest: Pointer of destination string
> + * @src: Pointer to NUL-terminates string
> + *
> + * This is a replacement for strcpy() where the caller doesn't care abou=
t the
> + * return value and if the string is going to be truncated, albeit it ne=
eds
> + * to mark sure that it will be NUL-terminated. Intended for performance
> + * sensitive cases, such as tracing.

If you care about performance, and the destination isn't smaller (especially
if the sizes are the same) then just use memcpy().
=20
> + *
> + * If the destination is bigger than the source, no padding happens. It =
it's
> + * smaller the strings gets truncated.
> + *
> + * Both arguments needs to be arrays with lengths discoverable by the co=
mpiler.
> + */
> +#define strtostr(dest, src)	do {					\
> +	const size_t _dest_len =3D __must_be_cstr(dest) +			\
> +				 ARRAY_SIZE(dest);			\
> +	const size_t _src_len =3D __must_be_cstr(src) +			\
> +				__builtin_object_size(src, 1);		\
> +									\
> +	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
> +		     _dest_len =3D=3D (size_t)-1);				\
> +	memcpy(dest, src, strnlen(src, min(_src_len, _dest_len)));	\
> +	dest[_dest_len - 1] =3D '\0';						\
> +} while (0)

That doesn't work (for all sorts of reasons).
_dest_len can be the size of a pointer - no array check.
You need to use __is_array() and sizeof () for both dest and src.
You might have meant to check that _src_len is constant, not _dest_len.
You must not leave the destination unterminated.

__builtin_object_size(x->y,1) is also entirely useless!
If you have a pointer to a structure that ends in an array then the
object size of that array is SIZE_MAX (as if the array continues past
the end of the structure).
See https://godbolt.org/z/csenjfvxe (which I happened to prepare earlier to=
day).

__builtin_object_size(x->y,0) also seems to always return SIZE_MAX.
You do get a sane answer for (x->y,3) on recent clang - but nowhere else.

-- David




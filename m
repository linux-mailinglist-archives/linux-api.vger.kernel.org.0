Return-Path: <linux-api+bounces-6400-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG9dCLMlFGrfKAcAu9opvQ
	(envelope-from <linux-api+bounces-6400-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 12:34:27 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7933E5C946A
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 12:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4343C30158A5
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690033537ED;
	Mon, 25 May 2026 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnQ4yPWF"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA4A1C7012
	for <linux-api@vger.kernel.org>; Mon, 25 May 2026 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705264; cv=none; b=ktWMPUQE1eiyuVSLER9bd25LOO0y640vPALU2hfuybQdto8eInGZILPbTXxu+YZNSqLgZfrU6Ihfm8ItX2eLOlpMEyWNkdVgZwsx4nH4fGnbp2AWVv1Aan33hhD/teVXB+DRrgzJyFQxa9tKTkcI3VeJS6VROp1O86TDKtoaIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705264; c=relaxed/simple;
	bh=mb5ZXkGMIgb6DQIaD/P8DOgOOXgzG2RC35+NeGAmz34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnS4Zx3oIxrx0ssogR7iFIF0s9V1M7Q5EEHcwAakpKqy/Qyuz6ge8K2y3LC0NLBcj2JuCda0X6XBQ+5FmPlCSS/BPc4SbMghislKaaxkKOCQiOdNWftqn+rHdj6i51qPMmlcyHONSwnUE08ZNRkS2X14pR14yhBWf+5Rtq/vgoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnQ4yPWF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso4980105e9.1
        for <linux-api@vger.kernel.org>; Mon, 25 May 2026 03:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779705261; x=1780310061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANTTltvHrc5c1FeMjZzkkc8QWIGg79MSqFOZN/bt4nE=;
        b=HnQ4yPWF5LYAnsBODc5Clb7+diRGkGU15T7CYuOSoIcUsV1QC6no8scIi2PZ1N5epC
         PEtkTCt47xUHj7FZTzjtaRkjWjKOGS/Cbtj8Hu3YMUdWZYpCi2oHH6Wh/kzeXDJ7yjLx
         VpUCmEL8/vx1EPqaY1uhtqOFQNNPidISG7dOG9dEEQuk/t89BZboxQsXoH6XbDpzMW/5
         s+IsBme9WMlnvqllfjHlaacHYGPSTjFmILDXOuU9sQ0rx5Gq4/uzBwA62rPxFJpTI72/
         a+SJEZEm3ACLwj82M3vclcB/uXDr9MDZpEOljsSvlhqGHfqQ8TgwXr4q0NV1Gyo94L6F
         yYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779705261; x=1780310061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANTTltvHrc5c1FeMjZzkkc8QWIGg79MSqFOZN/bt4nE=;
        b=Z6JYz85+uefaHa0jSYvMVTRB7iGW/BNYzQL0auIvurAGYdwy4o8N6r1PubCtdX4xYq
         tVNFyTMPWjpLITyMADSfbOGjSvJ4wg6PvwOkOtk0jOUb2Yva17bfG2/TDpguqogtNWmn
         3QrHSo0+qMvxap6yyxY42GZF6uWkCE2oPhXEgkrD0FRn2Jgq+3QZLk4mDZWoxxQBJ9oi
         Shtx6jpkxbSdZBmyDOX88dz7FsywhoBhdoaPNaDj45y42vJeu8v7RfjbbG5JqK1gEw8Q
         Qy+DKYX8XNppqi+8DyQGRGDRYuNNOdx6nv2kVG43iOV4w+st+QRm0jWzBGtUukwjxwZs
         FLXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Ywe6iATNxYtdzLpWMWzXkcq8Xz3FgbsXKN5F/w+IAQKQcdG67WuZl+ajHd9FeFS9XqNbQClLwkFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2DGe597iFqKq61u6R2abrm1p+9UP54T4bqv/o5lnP0ZM7+i14
	5HxGWHLCWrgYUV9XYg0lUWO3dRAHKgrtqcbBi2liW/4tG4YjvuTWrSw4
X-Gm-Gg: Acq92OEHX8QJoS5dsgF0KByww7zrjrhk3m33srHG9xVfpUgv6QlPZ21VTlNtyk+8qI8
	gScA3lh7Ir7h1u3KS4ySKiAeb65QvraWob5PzRmMo1Ssx9rq8TLlYd+nTY9WA432o+NeEVTka5i
	jtXTk6AmhP3ogLcOjg7wNQjrEWDetfKmM4bASPL1Ec7RkTuA+ptnB5NKt7hMSNTDt7AGH48dNeE
	43N+b2pzL7bNK0hHsBUeDRMW1na+GzFzyUjcMcll9BIiTQ5nXLrnXN4q1f9qyj3MMCQxtBu0f28
	5KKfSR/rbr3jraF2lM9e9D3XuUjg0VfbK/OVlSZRLf6WbQhY7Up2HlYHXWQQ6GtPGtl397X5AjF
	7KRpdCnoDVVOEU0xALixezQW7EZ2Gy8MoyF8zXN7ZZUu6bAXjYAWL2RhfYGvBJ185BeKXHeRukV
	KGQBZasYIa+72qW7YYFoS+bzL6xNRDDuQP9j0+dcHAhC2IBet9NBzEzSQvp1z2QTwV
X-Received: by 2002:a05:600c:c4a1:b0:48f:e230:2a1e with SMTP id 5b1f17b1804b1-49042ae7881mr243970285e9.33.1779705260735;
        Mon, 25 May 2026 03:34:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm25157564f8f.30.2026.05.25.03.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:34:20 -0700 (PDT)
Date: Mon, 25 May 2026 11:34:18 +0100
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
 linux-api@vger.kernel.org, Bhupesh <bhupesh@igalia.com>
Subject: Re: [PATCH v2 2/6] treewide: Get rid of get_task_comm()
Message-ID: <20260525113418.032bd1d0@pumpkin>
In-Reply-To: <20260524-tonyk-long_name-v2-2-332f6bd041c4@igalia.com>
References: <20260524-tonyk-long_name-v2-0-332f6bd041c4@igalia.com>
	<20260524-tonyk-long_name-v2-2-332f6bd041c4@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6400-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,igalia.com,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7933E5C946A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 24 May 2026 19:38:52 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Since commit 4cc0473d7754 ("get rid of __get_task_comm()"),
> get_task_comm() does just a redundant check for the buffer size and call
> strscpy_pad(). Replace get_task_comm() calls with strscpy_pad(), that will
> do the right thing if the buffers sizes doesn't match: zero-pad if it's
> bigger, and truncate if it's smaller.
>=20
> Link: https://lore.kernel.org/lkml/CAHk-=3Dwi5c=3D_-FBGo_88CowJd_F-Gi6Ud9=
d=3DTALm65ReN7YjrMw@mail.gmail.com/
> Co-developed-by: Bhupesh <bhupesh@igalia.com>
> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
...=20
> -/*
> - * - Why not use task_lock()?
> - *   User space can randomly change their names anyway, so locking for r=
eaders
> - *   doesn't make sense. For writers, locking is probably necessary, as =
a race
> - *   condition could lead to long-term mixed results.
> - *   The logic inside __set_task_comm() ensures that the task comm is
> - *   always NUL-terminated and zero-padded. Therefore the race condition=
 between
> - *   reader and writer is not an issue.
> - *
> - * - BUILD_BUG_ON() can help prevent the buf from being truncated.
> - *   Since the callers don't perform any return value checks, this safeg=
uard is
> - *   necessary.
> - */
> -#define get_task_comm(buf, tsk) ({			\
> -	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
> -	strscpy_pad(buf, (tsk)->comm);			\
> -	buf;						\
> -})
> -

I don't think it is worth the churn of removing this wrapper.
The calls can be optimised based on the knowledge that tsk->com
is always '\0' terminated and can be assumed to be padded.
(A read mid-update might give an unpadded result, but that doesn't
matter because it can only 'leak' part of an old name.

-- David


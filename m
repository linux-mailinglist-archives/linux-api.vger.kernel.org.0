Return-Path: <linux-api+bounces-5982-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHQ8AOPktWla6gAAu9opvQ
	(envelope-from <linux-api+bounces-5982-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 23:44:51 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDD28F5F6
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 23:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F045302768E
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 22:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FD386544;
	Sat, 14 Mar 2026 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUHvKzBF"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A634FF4F
	for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773528284; cv=none; b=czRU9mryBmpOJIMUx9Jpj3zR2clMcj7JXV1XTJsEh+CYOOExkDKB8DHmWTyzD9Zdz93JrtvEFvcHamexoPOPy9k9RBW3iivGAwf7oKgXsFhD/CDz5Dk93Qe/+QCuEpw1Ggk4ZOPkfHg2cYNk411wogAFaKCte8OKwz/mCpRxLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773528284; c=relaxed/simple;
	bh=+BzfWIbWutBn9FVLenIu2cDO6fBukYew6iGg+YJ9bLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0Se4qNJsku1BqBzC7omxBxo09Hnw0pA2qj/RoVIQmzV7nqQ+bo/tjVmJEyyhmmrhy6IXBpcLMsbUd2/y1aCVHjSLRx5FpKkfkwNXi6n7NbvoQV63TYp1a5KEFg92nZhwS7kAnhAN1rBUXr4xpAXzJW6PBN/MJB65bxsZHODdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUHvKzBF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89a14be4733so42369316d6.2
        for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 15:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773528282; x=1774133082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuJUhym4M/ZFIJ+HRVLrIiZVMxaVq6Aogwi4UFclA/I=;
        b=HUHvKzBF5hhX4JfsIma2dg7iVHahQVXvhnXj8AsIHtXNbMgTUuSYsPwy8VLT9xnEzF
         EeX7jt9RC7YfoK+BU25zJMWlMfztSjsh3LnnNpj0z0DyMWJqPXNAXYzgXzCr8TyUV0E8
         QwN8SbxvwIoa1lZiVk+/ugNlZzDW5T1SeilDNtenbONU4IVtyDb5jrAkYPnnyjoXawjR
         Eox8mi29T0lZpOE9gmj0Fedk5acbLbj8L20uDD9X1MIqxRUUFgjHdJj4pPZRH+cX/WKG
         FVAixQnIPaGULYn/1rQ5NgpgG4pP3cblsCvSepBTlhftfQ/CD85LZ15xbYP44UzQuVmT
         HPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773528282; x=1774133082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuJUhym4M/ZFIJ+HRVLrIiZVMxaVq6Aogwi4UFclA/I=;
        b=lFEVphl10vuLPFfnnl8/KXJR8uGERma0KINXtpfNuwaSqFdILpPnHwM/GNQ0/Gnxp3
         USrig9W39hs6i8V3sWifWPTF0nBK+T20pzl6JmcCoCAtJLiA3NULguJPgDQf+bIUp3hG
         WY92BwKh+lAUzH2E+CbwdIB6ei4WmezlV8wJNkhJeXxjJAoHWXZAKI6g8kauJLA62lAK
         LvLxtMexzcqFf3upPpauaahOG0viQhD9Asai1jvbxzimt+yf6OMJaAXnV0hrKm0V8x/m
         +TmrEcvia7GxXQ3dg6cECpX4Yk/TXf5QNbBWCDcxmnqAJYzyfbgB0HVzjcREaGlwF4pk
         X+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU4YDeaC/2nlqx1upJJ9oubgYO6UGktZ7P0qjP5DMOOXPPMYD2EC5Qh7mk9Zw/yNAwME4V9lFUQXNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9Z8fvl5myC1M/z6A6FlTX4NwrCml0CmWQ55LGV+U1Ae4wBlu
	/FpWD/FwmQtTEMJ0VEUeFnBIvD2twxB5OLHU3pdXy7cBJP2w8wKyKdTC
X-Gm-Gg: ATEYQzwsmmrUCISwx2QbRWyit6ut4ZEN7ub0n0x68KF+gNyPcTWV29vWRgm1vEfwxB6
	SPHIlp1y+5xI5FYZ55E9x8jb0dJqMuFGBE+K9OQOVUggUeWV1S9OpjOOV3Ep2X+IxEn5KQV3k7N
	ybPW9+exZLK13VbZygxiy1QhNVxTDw/mQj2Y1rUNw3ZXoz85VeQ8U7RtNF1IcUwUmwFBJCpk6zD
	5khN70gCXkZ0R7zzZyTmieIqUFHbdO9DeGq2GvM1/E5lTdVgkO3s15pfMMa3G3WNTl21eIUdIuM
	8GImLT+O1cn7Nwjrjq+mWJmAoKlvd3GY6Wi13jU6abDzU/IeLmT6OGHL02zCUnS036q5alROnC7
	mesw0h2Y4uqzkUeORvjPKHEZ/3mxhmOSz+p5g4p+8JDhUf//A/cMOAgjJTrdJWiqRpgs1j3n3qk
	Yxj9o0KcqEZt+EbHrafS/Ah+PaA9jnvmIvHikbzP0A1O2wUpV4AlXZnkePkrvKTZDI
X-Received: by 2002:a05:6214:529d:b0:89a:173d:9c54 with SMTP id 6a1803df08f44-89a81cb9be9mr117730886d6.8.1773528282565;
        Sat, 14 Mar 2026 15:44:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c43bb47c3sm11296526d6.14.2026.03.14.15.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 15:44:41 -0700 (PDT)
Date: Sat, 14 Mar 2026 22:44:35 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
 tools@kernel.org, x86@kernel.org, Thomas Gleixner <tglx@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Dmitry
 Vyukov <dvyukov@google.com>, Randy Dunlap <rdunlap@infradead.org>, Cyril
 Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>, Jake Edge
 <jake@lwn.net>, Askar Safin <safinaskar@zohomail.com>, Gabriele Paoloni
 <gpaoloni@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann
 <arnd@arndb.de>
Subject: Re: [PATCH 0/9] Kernel API Specification Framework
Message-ID: <20260314224435.35465615@pumpkin>
In-Reply-To: <20260314111822.63a2ba4a@kernel.org>
References: <20260313150928.2637368-1-sashal@kernel.org>
	<20260314111822.63a2ba4a@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5982-lists,linux-api=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BEDD28F5F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 11:18:22 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 13 Mar 2026 11:09:10 -0400 Sasha Levin wrote:
> > This enables static analysis tools to verify userspace API usage at compile
> > time, test generation based on formal specifications, consistent error handling
> > validation, automated documentation generation, and formal verification of
> > kernel interfaces.  
> 
> Could you give some examples? We have machine readable descriptions for
> Netlink interfaces, we approached syzbot folks and they did not really
> seem to care for those.

The whole thing reminds me of doxygen comment blocks.
They tend to make it hard to read the source files, hard to search
the source files (due to all the extra matches) and are pretty much
always out of date.

The kerndoc comment blocks for trivial helper functions are hard enough
to keep up to date.

The only way even parameter descriptions are going to stay correct is if the
compiler is using the definition and only the comment part is extra.
For error returns you'll need the documentation to be at the return site.

	David


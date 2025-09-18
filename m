Return-Path: <linux-api+bounces-4558-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1FB32325
	for <lists+linux-api@lfdr.de>; Fri, 22 Aug 2025 21:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E40DB1D27DF6
	for <lists+linux-api@lfdr.de>; Fri, 22 Aug 2025 19:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C93D2D542F;
	Fri, 22 Aug 2025 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUWpPkOs"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DECC2D5436
	for <linux-api@vger.kernel.org>; Fri, 22 Aug 2025 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891972; cv=none; b=P64etWKmx1p6qvOOQkF2qmanPhU7GJAd9pS4ZCeHQP1IFQeAFEPQ90kXR17WrXktVnHcm+MPxLWA+OSfqRjQVwK163xNH0Y8VgoB60GGx+w0CHfIu4bRwH58Q6jJT19s759GuSrc6vZlU41LbHGiv89vu8Y3zVWxGx6TNgeP+Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891972; c=relaxed/simple;
	bh=XBIUH0wquQctWkgcUJPdSrr7nfWPNHBoFiNbn8Q/vok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUvEjEECgdov9BN1RV6zFYN60hNe2hD3+7fFmGr8kbyQ8/RpDpdsb4+s0AgyeADTq40hl/9EKn6WYbOlH+OZcWjJW+j2X7zK6AEUmCinq4ii1A/lKdSLdxROMefr9XuNAe+9rND6HlWEULl6gDrPWTm3WKX9GpLL0J8CjKZJkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUWpPkOs; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-618660b684fso2007a12.0
        for <linux-api@vger.kernel.org>; Fri, 22 Aug 2025 12:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755891969; x=1756496769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDGPq2QAoamqAsn96zDYfVwrsh9uyHlSfDp4Mt63PH0=;
        b=iUWpPkOshd2mUXVt+rBH22eNjxhtSdMpQMdXL+Sg76oTxb0XrNSBPb+ygkQQox2iH8
         RuZziDcm7Omrsv9tS3dEQrMSrhCnRnOWspTBcpkX3TzniYxwfYNUyfkh+H1dRymc0Uur
         alpwRFGLngP6PYeq6DReukClGyT59aKk5pwR0FtwRahPUDwWliTXwROROw4+kuCMQ+8c
         XFcjseldZGzUEFLij/x34u7USjHWBLzPN186BEmjtNEo2grwJXOAIvBwWBK8yMWYqnii
         T+UTquaAiGBJwI4FnYWqHg7W5QemP3VZ9VSOIGJCBvn5UgO767o4GXvpDi1CP9sH6Lh3
         eW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755891969; x=1756496769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDGPq2QAoamqAsn96zDYfVwrsh9uyHlSfDp4Mt63PH0=;
        b=Dg/pmGkxaPyUrm6afvh9qVc4O4+ZJrVUjofgAHVKEmxAyz6yAl1Chym9z4QKCsui6B
         g7fOb2vZZvIfJ+55mrBxA0KlnkZrmH/fBU0+AuzMSzB9N0J82045w7X3P5HuuZn0UYaP
         BPc1Sjz2sO/hBV5xTtaCvP0sm4bc0rbzKkoKb4Eg2uAd9ix5d/cZNRHNqhC3pS7siIr9
         ENeWb/xSw30J5nO+WSdqP8ENZC8TQUd0yQ3qBTVJmZmVRneTSRBsiT/2hOnR/5VoiUp9
         A3Ckc74xf8AF6juNmkssH/EUECWvWD4zPr/WLieL4dju+Lotfu4CISBzvb2mSQMNL6xo
         J3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2uLt88/7nQr5g7mlw4+2BsiFdsB0zvcRMbQL/OnyB4w3p3fr0Amn4Ux3E3xB/4U3tY15HWW1hPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqrddnPTz1Z4KP3wvXk24Ghwy8Yedl2MAPpzpYKIXSuRUafnH
	q7mnNbod91phqNhM8SD4d56of+dvzhg6Tsiv+ziuhIZd/2nmmxKY/omTYUp3E4weyVlsn16byY9
	VCIQrWb9LdZsN2NT0gODdUKxgvlzEunkkkXgiF1ce
X-Gm-Gg: ASbGncuaLMSEK6zCaYpvKBucTHfyfU9jIjh0BgzK7IgJ/B3pi7CZANEoB+FSpWvNXJj
	G+Xo7cxMAX3VXw/h7FIlqji7YEP9xV/aMeVAEqK3HAI3WKDfMG4zBpjka+O/OOP4UNMiTkNTWYn
	LCYLeuwThXzOQCs3AphbwR0lJW872E3xR5NOiKfsjI4d1Ki3KViwmw/7F2JCc7c3Z7niVmizLji
	iWSSKzwbNJkMnYc4b0RFPpWmnzve0Q1ug+WJPg=
X-Google-Smtp-Source: AGHT+IEp5JtOIpLeEMiI4+ZgwDstAGg61BU3UaS/vBzIt/3oQq6zs0o3AsSV2sCxqe1VwQ3ShoALvJizriSBAYLp6Cs=
X-Received: by 2002:a05:6402:2393:b0:61a:590c:481c with SMTP id
 4fb4d7f45d1cf-61c361f8759mr8808a12.6.1755891968513; Fri, 22 Aug 2025 12:46:08
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250822170800.2116980-2-mic@digikod.net>
In-Reply-To: <20250822170800.2116980-2-mic@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Fri, 22 Aug 2025 21:45:32 +0200
X-Gm-Features: Ac12FXwjpgWQzX75-i1-fxwmf--db3NEnzMzNGlpF6QflXz8uRcHgI7dwyXvzpA
Message-ID: <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 7:08=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> Add a new O_DENY_WRITE flag usable at open time and on opened file (e.g.
> passed file descriptors).  This changes the state of the opened file by
> making it read-only until it is closed.  The main use case is for script
> interpreters to get the guarantee that script' content cannot be altered
> while being read and interpreted.  This is useful for generic distros
> that may not have a write-xor-execute policy.  See commit a5874fde3c08
> ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
>
> Both execve(2) and the IOCTL to enable fsverity can already set this
> property on files with deny_write_access().  This new O_DENY_WRITE make

The kernel actually tried to get rid of this behavior on execve() in
commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that had
to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
because it broke userspace assumptions.

> it widely available.  This is similar to what other OSs may provide
> e.g., opening a file with only FILE_SHARE_READ on Windows.

We used to have the analogous mmap() flag MAP_DENYWRITE, and that was
removed for security reasons; as
https://man7.org/linux/man-pages/man2/mmap.2.html says:

|        MAP_DENYWRITE
|               This flag is ignored.  (Long ago=E2=80=94Linux 2.0 and earl=
ier=E2=80=94it
|               signaled that attempts to write to the underlying file
|               should fail with ETXTBSY.  But this was a source of denial-
|               of-service attacks.)"

It seems to me that the same issue applies to your patch - it would
allow unprivileged processes to essentially lock files such that other
processes can't write to them anymore. This might allow unprivileged
users to prevent root from updating config files or stuff like that if
they're updated in-place.


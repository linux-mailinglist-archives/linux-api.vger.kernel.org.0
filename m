Return-Path: <linux-api+bounces-6795-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SaFUFEhoTmprMAIAu9opvQ
	(envelope-from <linux-api+bounces-6795-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 17:10:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1930727C7E
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 17:09:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amacapital-net.20251104.gappssmtp.com header.s=20251104 header.b=Dz7ZCOdl;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6795-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6795-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 325DF31F9B69
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38163B71BC;
	Wed,  8 Jul 2026 14:55:40 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B93B7765
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 14:55:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522540; cv=pass; b=tu5H6Esanb//xG1dBsE8dENXcZcfpxWnLB3IzxW3l6Q1RUjRt7DmeohM4qzz1y2xleBbDdW8QsdME+zUpL/bxJVPX29Ar4RZAmYvQm+lq8fHdkfOUIJ5eg1jMLhwpqJbp7wTVC1cxVSleGUmFpjtpmaivjMum4diI6F5JDvKlW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522540; c=relaxed/simple;
	bh=n90YfTOdmUl7zWpqdxsCFHko/DVT+Qm+JbT9gK4fWzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBic805e/1kQ+WVxSdUsAm3EuQn6m1gLfGgx9ACxyJK5y6h93gm1Q4qk+Ioig6IOuEVsH8SuROZhuZQF35YQT33juh0+c/ZY2ZWrYuiMEUUn8Ku5/5z883I6H3rPZ43/LvDdQGwIQvb4QmCgab5t+eVy7yXutE7oqsF/LOeeOIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Dz7ZCOdl; arc=pass smtp.client-ip=209.85.167.52
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b00ca000ceso906026e87.0
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2026 07:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783522537; cv=none;
        d=google.com; s=arc-20260327;
        b=SlIcgiLO1b7OtHcppWZMZNHC+MW105cZE0gITbVxB9nmETqGU7zwUSyCFhNjt03Sc4
         MfINAutPhWTxipVIrMxonnCdy8/xO8LQvVFrQifRqvm6sovCUNpul2ZDOE3U9KRj24Hk
         vks1ZGWM4XktfFgGeD3EL1kyBQOrJCxiaXsEDc+WpJxlQph0pIdypUwvsViwc8SxRDIf
         pdTy0gJ9BVMZOPTcehxhcqLb4s9TMv9HM6YQircJDEDcbp6YAafgf8ek1r8r1O5cM1BX
         DKi897zUg2o2WygMmGP5DUSqrL9hvqEca9gW+wy15ivvLgEC3J29tdeNGmN2RAUTP8bT
         nKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HNUyOLDVIp+0zKTGoz+OqkdsD7McKB6c6W+fqiostx4=;
        fh=JrzDGhmGi82GQUBea7Z26rs9AnBF5JOqslGZrVM+uaE=;
        b=FettTDnKyuDQknmzfBLQUMurTG3gdYHSEqacDwIL+cFk/lVPuGrJEJ9gK7pJ163BVw
         xYXZ9AZ7JKJ6cwPOTksqrc/ipSIh2gRUFat4ZZ3E7jSP8iW4te0ObWmH0klkRZC4KnmT
         9x3Eq6fQ6KgNTNYF/4aP6qD+Nw7TPJ2tyIIrBuFMJY1YUO6gUiewlVjKs/ARwAB2zWuw
         /vWQeZM6dfZjz2NpB1Djupopyd7tshyWltclRa/K0KkZNA9eEp9TWzlXI3+AJngE8RsU
         i+isZCimOsyYc3Raklx1DLNj8SNN23Gs77Qr/jnDu3bqT4NubXEfFGi+urqPikDniiJq
         CMgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1783522537; x=1784127337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HNUyOLDVIp+0zKTGoz+OqkdsD7McKB6c6W+fqiostx4=;
        b=Dz7ZCOdl+uMJPCmheUkJ0ljOMgnz+kZe5+lpXto5XQi/DgnTD6D+gSU2h8JlTknTv7
         gYmhy4/PpfyEOwPTZTvy4pMpJvA+UR/rp1pAVaHy2d6kbh18MujqcTu2xiTPaZ0Sclot
         vPDEHclRmjR54QG7iR10cgcRGV6w8Dgw5Vb0RTh1UaYtSB7svNvzGyNw9a1YsXjkCeJc
         1Yl98bdfdRvTgZZb7DHiUojDOBP9rr9QersBRD2rGFGocQq+PWJmy8jjrEN67lPz1FCH
         2ohZeMAaO5Iiqxiozac+wmnKX48uALopXjma/FtKZ/w/q3BTkQGuVYtuyEnev2VsrTpX
         YzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522537; x=1784127337;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNUyOLDVIp+0zKTGoz+OqkdsD7McKB6c6W+fqiostx4=;
        b=djwDhlhJV6Jgn9LSsdE3ygHkiPAwECWFNRsBvCZmA2wrUdomAYaHtsPpz+P89QC8sy
         F7CbHOM49cTvu5HbgX225+eSdrIPwveFwvsvbSnfOqyEH8LDlonniyYyKI4Y8uDVBz8q
         x603X7w4vMu1Z/bcY1rPOfnci3S3N+Varu0D2nETzSv4DRaayQUogu6T6AIsf4PldQ7f
         BqUJjxc4pmKNbNUOlBQA574KkTL1xOsoQLR2WhFJkiZKfnXE/kP3vPI1wAOAEDoKmgpU
         BqiZm11vMxmBkWsvBjrnyL6d+f9c8247TE/aLgg5NDsjhVPXKv2k3AEmvOMSO+UhjN/0
         t5wA==
X-Forwarded-Encrypted: i=1; AHgh+RqRfK2F4iGU8MFuPgEqPsO/awXOLthCRSIcRvXM/VWHr08J4NCMKBqzmmaqyon4rRzmtFs+2AvvdZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziEnP66HU4z0+n1bpi3/tiXHrIjIOjLuSgZ3dgOpC46xxBjMQu
	utc1GH/EI6XfSc5Q3raG6RkcvpodfLh57uxXhadAdKRyzBAvYEpVCTP7RI3gdBb+fPsPiI7tLZn
	guHHOj1c5xVE/O8R3EetBBRps5o3wxkZq52wwrRrOUoYhx8WN5yCf8A==
X-Gm-Gg: AfdE7clRmN4eYWECE//bFZG+Kvabh3u2AdirF8SucVLZSf7RXpeJAX6hTdYzncruNDn
	EUJlXFVJ/VgFo08wjfsv+86oqM4Do+pf7O6BMY8QQ1Q5JMg1WTuYJn5LzIfaIUeJtRl1p/7zerC
	J8NXjGLxJ6rJsdiMxakg8IdCEF2QIWyia+56l+GmgCpyqrd05zQgZ3ADVWQp27dO0dXH4sloaBd
	dazQcuV2MjE60Rl8foKS7DRLabypETLLjS1PK0XU36CYh6+PyHRiujw8zikkNlEMGsvXQ==
X-Received: by 2002:a05:6512:8348:b0:5ae:b5d0:9da2 with SMTP id
 2adb3069b0e04-5b011462b7emr693309e87.38.1783522536822; Wed, 08 Jul 2026
 07:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708093446.3370200-1-gscrivan@redhat.com> <20260708093446.3370200-3-gscrivan@redhat.com>
In-Reply-To: <20260708093446.3370200-3-gscrivan@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 8 Jul 2026 07:55:25 -0700
X-Gm-Features: AUfX_mxOfC8JmvatfXCPy4TV9OGzLE6zGNnyTgpXNYag_FZ0rPhcjgOvQmXLouo
Message-ID: <CALCETrVE0g-qKC079K4Ch=26VH6R+q1tXVU7HiN_Og9o1zzpow@mail.gmail.com>
Subject: Re: [PATCH 2/2] erofs: add ioctl to retrieve the backing source file descriptor
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6795-lists,linux-api=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amacapital-net.20251104.gappssmtp.com:dkim,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1930727C7E

On Wed, Jul 8, 2026 at 2:36=E2=80=AFAM Giuseppe Scrivano <gscrivan@redhat.c=
om> wrote:
>
> Add EROFS_IOC_GET_SOURCE_FD ioctl that returns a file descriptor to the
> backing image file for file-backed erofs mounts.

What=E2=80=99s the use case?

In any event, this seems to have potential security and API-oddity implicat=
ions.

1. That capable(CAP_SYS_ADMIN) seems critical =E2=80=94 otherwise a task th=
at
is admin in a userns can get an fd to a backing file *outside* its
container or to an otherwise inaccessible file.  It at least needs a
comment IMO.

2.  This series appears to fully round-trip the struct file. That
means that f_cred and mode are preserved. This seems strange and may
have all kinds of accidental effects. For mode in parallel, if the
program that mounts the backing store opened it for write, then this
API gives a writable fd, which seems like an odd choice for a
filesystem that literally has read only in the name.

The OVL variant has these issues to a lesser extent due to the fact
that it returns an O_PATH fd instead of an actual open file.


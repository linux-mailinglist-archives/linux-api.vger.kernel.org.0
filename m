Return-Path: <linux-api+bounces-5777-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGA8NNg3fGnFLQIAu9opvQ
	(envelope-from <linux-api+bounces-5777-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 05:47:20 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B47B726D
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 05:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D56943017011
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 04:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118919E819;
	Fri, 30 Jan 2026 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO0Nge2W"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8801E3DDE
	for <linux-api@vger.kernel.org>; Fri, 30 Jan 2026 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769748412; cv=pass; b=Jo5dJ3pWOs/3koG8p9qBeDDtOU0ISCAqjWE3CzF+OWVrATGd2WdhzsCHBPJulGzdnVY37XkCUd3Mwv+aI/0ZNVPRaZJELv9bexuPKcuYPgWZM8PtokbY9E6Bt8CE47Qo0KElWIeOeVh92jvxxp3JeuTYt3WBxEs92X190P1sIEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769748412; c=relaxed/simple;
	bh=1QJyDJE8/RwVdlpn5wHmp1OKZDbqaPptfo9AX+CnuJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0m/BlzKwoMlErGjQicLF7pJNvwf3VMcxPuUHtsY0ehw36iWnCm29FxLYTY1Mk0h8sNpWzFQnCw3R4Zeov4NILs8piF5yzNhXtGjWSNo1FAPLlZnAeur13ujfQ1tHZYOP1Qi6kUCDrt6rndEZKvJHOwn+I0rCROhUKIsdXzEtv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO0Nge2W; arc=pass smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c52c67f64cso164255285a.0
        for <linux-api@vger.kernel.org>; Thu, 29 Jan 2026 20:46:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769748408; cv=none;
        d=google.com; s=arc-20240605;
        b=KpU/Ad8nsv3O9CfkpFt39y3772Pq9lxPZdYWo50yduJug/E4a7n0VTv1HKwoLinfeN
         mDaupV5y5OzVvFj0dm/x1hLbhHi7fnne0DKRq1KZKtBsfKkVsIBM6ZtyaBhGU79eLmzx
         lRgb6lW1wiuiPkpLFf72G2gezPvlc+NpVtDNyB+ERyjWUcLR+Yxx4RzUh/th9LlmwSIT
         2XOy9TXQfOruklfxYS1P6jdNjzTMjQu3a9sd+CEMpJ+c34AUHnpbJ8FhBcdrf6rJR+Pu
         QzzTOOkoGX00XhRi73rHzXEuQzUFMdgrrGIPn6Bct44U0jYK9QSDuhpts5g0yg5RCgcp
         0OaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t4LF6SauvoM56B4cbnm2wB20O1YxkaswIBTQd/3l4QQ=;
        fh=HGYGJinc/EaSqsjNB/sFo4lgvyWdXdmnfcQfSJyw5Jw=;
        b=KjpTp51+W4mzne6HXiyRJHYxOF4B82qhlNBHTSR8ulJ8Z/ac3QYOWUCDYyDiRNVQVR
         kT7nKBfSUT0TZbxQKlRN3J559KQvnnv5r4tLroMg7vjA74uS3snypS9QEoJXrAF0hP7K
         89W/Xie7YWM4XTG2lziq8Ce6cllAvg19qU+5uJhYJGn842gJtJQQ4WrH3wlfwrjZ4rEx
         F5zSIhKoVzOI6K9bSBu+sacFRImiB4H1udcMtP7Lp836OuIEsk26ZReHglSoJ/iE2rmP
         FOebr01croWq31LAu+HYm+z6p6Ey5QICwOwzCekxxXimj6FlnXkTNMNvBBXzbS9NqMSp
         IM1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769748408; x=1770353208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4LF6SauvoM56B4cbnm2wB20O1YxkaswIBTQd/3l4QQ=;
        b=TO0Nge2WHvR77HYLdbsOMvsZjLPth4rVAvBzcl5/LE/VfPhF6ZG/sDqBrTSxqDvx0P
         9f4T42NcuJnT2s+Pw8OibXAYtTHxYlK06iETTPO8jGtw3Cb2dO8z4knHTu8v2bdVctTr
         VIWzRL3sHqqo/Riw0tgALM6ztHGmwvoKzzrMd9o2ZvVfhEMhRqM+QW/L+N3bfBVw6s22
         wrNaJ4TAX5P7kcnbVBdXVN+3estYZ6qfhpvndim3eEoilf3f40sd7JTjppVk+D2Tb3JC
         aQ0ZcG4WY+gEQSiM4LfL+vcwCl4PBpq3IV8RizfKLGZIVk9Jq2H0nDajQ3oHLtiK6XX7
         wswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769748408; x=1770353208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4LF6SauvoM56B4cbnm2wB20O1YxkaswIBTQd/3l4QQ=;
        b=durjGKhG1KCFRGYKMZEJfgNXQTO1sb4/GBEFaoaQiN0HaLxTEkFtrixU9errd/oqgC
         bCDEz+nN7m6/jX2kxedcDgnDcFmcW0XpNccEudXv9cVwsWcoPmKx6ZAUn/S+ltgt17tX
         quAx6T1YRakOwfVP/ErtcKm6NJy5zef6DKQiXsIBWksSAvF6AD2LL3NsUp6DN+daDfo4
         ss+Tj5o/LgRgLaNo9HSCs1k0Lh6TzFckMY5YhEINztK58a4RCW0NyW8mEXLZaTlv+k0d
         6q9wdGwuPc12iCm6DXT/+79wzhMnJu2+QJjIPAfLP4OksbFfzetHgEXqk+FLJGTxP+mp
         y3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFxQuw1SBVgw32yelmtZr5pnExvNWf+CZ/LsDE5mpv4tMIZ0Ea+AWO+xCW2OFeimIBQXbkVTP3Muk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylsjNz74EBaX7HAcJZ4G/oPs7dTyV93oT1k42N9VxIylxwcb6S
	TW5STTsFM+9mwe3HyyXanH+GNLGriOjePDUWg6wlvQKGd5nQKU6c+6qVYE0Zi0NRIhz0gpHriZz
	cP32peLgi8qCiAYD+EGhqK5KpbFflpLLKi4nyJcA=
X-Gm-Gg: AZuq6aIFMTInpqhuFX0MNK3SyFeMJ8jeywlymW5FwSpkOVITZf/OM9ypUS/B4cVyq0f
	2Vqcag21lmQLeL3oCH7VFe0CmlO2/J16bTUF3DNA9pBrmEBRj0bsf83a/XHGUY7XIWrjzZyyQlv
	pMImAz1MKSPKIre/DuOBfxIgkM9WMUOCofjDkzsR4MQWdYoJCwbTGu1ySHnTjA3XPca+jRW3o0f
	t3nLac2wxNhkvrp9NN18vKVJPn54A3lofyWzMS3gKyWLe08OdK5VBDIO+gqW3QqU/hcCkwiEHwP
	qlx/p0cfjw0duEuItHKrd5wE3EZRBIZyzhR8vE03e3Yu2590KLzYAZ0X
X-Received: by 2002:a05:620a:178b:b0:8b1:2853:673f with SMTP id
 af79cd13be357-8c9eb218b95mr231028585a.15.1769748408447; Thu, 29 Jan 2026
 20:46:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129075200.38060-1-enelsonmoore@gmail.com> <24935907-76b8-4369-a221-f408c9747642@kernel.org>
In-Reply-To: <24935907-76b8-4369-a221-f408c9747642@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 29 Jan 2026 20:46:37 -0800
X-Gm-Features: AZwV_QjXPANZJhFTUmAD_xs-kXsc12oeZYASoSpgH3VuFAFrYtXsvMe2H33A0d4
Message-ID: <CADkSEUiN=5X8XjmVE-SfF1GGQbfxkHPQB=BvCJdHG7jgDBiTew@mail.gmail.com>
Subject: Re: [PATCH] tty: synclink_gt: remove broken driver
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-api@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haren Myneni <haren@linux.ibm.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Simon Horman <horms@kernel.org>, 
	Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5777-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 56B47B726D
X-Rspamd-Action: no action

Hi, Jiri,

Thanks for your feedback.

On Thu, Jan 29, 2026 at 3:41=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
> Have you checked this is not included in any relevant userspace? How?
> Hints: debian code search, github...
The only references in Debian Code Search outside the kernel are in
libexplain (which has a configure test for the presence of this header
and should be fine), lists of files, and lists of ioctls, e.g. in
strace, which do not include the header itself.
The only reference of note on GitHub (although I can't look past the
5th page of results) is in
https://github.com/sunfishcode/linux-raw-sys, which includes every
Linux header as part of its binding generation process, and has
already had to drop other headers as they were removed:
https://github.com/sunfishcode/linux-raw-sys/commit/a804ac01491f63c8ce879ef=
27254d27dfcf89ff2
The package ships a generated version of the bindings, so the header
is not needed by normal users.
If this commit is merged, I will send a pull request to remove
<linux/synclink.h> from the code.
It was also used in old versions of
https://github.com/jerome-pouiller/ioctl but recent versions
automatically generate the list of ioctls on every build.
Is this okay with you, or should I send a new version of the patch
with <linux/synclink.h> retained?

> I would just drop the line, removing one conflicting entry. The letter
> is not going to be dead.
>
> Or is this Dead note some ioctl-number's policy?
It was used in quite a few other entries, so I just followed their example.

> This paragraph actually talks about long removed synclink.c, removed in:
>    a1f714b44e34 tty: Remove redundant synclink driver
Good to know.

Ethan


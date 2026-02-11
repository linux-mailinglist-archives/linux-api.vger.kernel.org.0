Return-Path: <linux-api+bounces-5832-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDaIE5X+jGn4wgAAu9opvQ
	(envelope-from <linux-api+bounces-5832-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 23:11:33 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE35128039
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 23:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43C743004DFF
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062533A70C;
	Wed, 11 Feb 2026 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8NpOVMi"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558D331207
	for <linux-api@vger.kernel.org>; Wed, 11 Feb 2026 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847889; cv=pass; b=DSnlvqjEcWdMpcz+wLOgNS+waK6rDHhe0HhONJqD7GnEwmA87F6UzrrVh8FZH2j9VR2+iLByRRYYmRoiydPzaeBP0hFP4MSxq8OK+82afkncNDCL+8sYgc3mwSdWov37UiGtqzmGL9zZ4xT9Ee0YW0F6gKB9PCTNaEUqyjF6RHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847889; c=relaxed/simple;
	bh=JiSSwWSerMjJ0lnCuuErFYRTqBQvNbw9BigQz83PYg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzEkzqMDxQFGg48rftJKpOZ5CTHzTPw63jCxrDW1iW3cn7Lk2nxkQ1fKZ/DLJ6fEngFuhbJcU2FKD33Wy0BbToFhgHqnro0aXylz2GgX8EcYHj9fnUnSdkPkA8Ve5ipW3fDiLKs3uC2gxu9W7i4MU49CK3Xrs6Cqz65JkzT5j/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8NpOVMi; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a871c8b171so14224545ad.3
        for <linux-api@vger.kernel.org>; Wed, 11 Feb 2026 14:11:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770847888; cv=none;
        d=google.com; s=arc-20240605;
        b=hxsgcr4yzthTlDYhqj4rqo8salQhEHKIH/2nKN5anp2Noc+E5md2aGtroX1H+ZDh9t
         bBTf3VWT/JsesgfPqoLPFe1qHFxWfOaqoC80z3URa7qhrMDJWlsBvKDiwK5AgNv4z5Km
         fPVgBJXo1T+4IVokbprWZfCb7iI/2qvGFetLuM50Pv2h05Xu6XpZqrjtOsGkLYMAcjAU
         fjpWOra1eTtiV5/5mWu6RwVyOMRJLMwkjnVGI13Wl++6uvMVs4GYdtm8Zxud0KLgU2FS
         ikxocp6JTXIEZXd7qEOQpBLlnNgvhu37F8FHdeLnQZJfyWk6QjvIQSq3Otm99bzt3SKR
         hF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3YLj4yo1hdeJHDtsmSn5m8ezeqMhDQtpYJhbUhzSCs=;
        fh=44qyHoYEpgw7w9LfKEghIjyCJck4MkrknG+nncly1N0=;
        b=DyIb81Jqr7/IQA45GxdBOWRKQPo5zmzbMnQZYduRzsh+6dMCiGBCTTOv7VD4QQDOue
         KCyZo688xCPTAoCMgIq9/nzN/XB/maHIyJDUbd2sWrSR/GilEgHkoNCIo7jbWDlFeb5f
         fbGIR5rhGTwrL4H6HUe8qLBg06tU7rcMvXJAzj7TL5FCUG09Lbvb/GnOwbbsu3wcfDcD
         gqpKql1l4o3Sz6JHAgpGyy3XSaOdcdvULhOimqKVbwndWE2AGXlpW97JL74HEs/WrB/+
         +z9H04W92jo/LwX8l6sr3SkcYsxgKBFYeG0YGZHl2C/OFKB9m3B7zLpDJ24OqiV0K+Dr
         1I8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770847888; x=1771452688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3YLj4yo1hdeJHDtsmSn5m8ezeqMhDQtpYJhbUhzSCs=;
        b=R8NpOVMiMcQX0I2yd5Hb/YdZiM01zGM4AZmbXy6oaymYPCBBuVcX1C7K48P+y18yjY
         5XHaiMojiKY8Q5YY6hW4d5H05j487AphhFrV55zXO+BYZF0hiTRvZnD6r/DZoWYukvkU
         ByM2uW0uJ9CUEjehdjZGmu0fuSPQqCKVdUqjjRnVazoOjdPQoVLlgmGU6lScb1YnHOhF
         dv0VcCVT6tTDgOAz+oWqYMsdBtBWUDnyM5gSmJz3BcxK84/a4tIdGVCSUVd+ShQf9kbA
         2kNBlxx1e2NAFOR1iDW2mDAfly6cgC+P74oW/jlBhltosgkBf8JA96RxF9YE1JzXk6YP
         oCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770847888; x=1771452688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3YLj4yo1hdeJHDtsmSn5m8ezeqMhDQtpYJhbUhzSCs=;
        b=DgNENsTXkXbpmbOrLBz+/9MqGJ5mc7i+CO/Zsap0Lqd1GYuqh5EAUR4KFOTdehF6FN
         VNzzySqAQZ8+BQ0rhOHytmTe0YIaClzLc3XYCBqtUalDlNN817FRNhCaE+G7VWagd9Aw
         5uLH8Qm2cyFiR+X82ASVxJlCwN/bR+pl3Eu5UXhvtNbb8kg2BXy3uostSaaOCVQNoOVU
         28r/nL8T0iutJX7Y8cz6GFqcsS1kTi0OLjMMBB4YbsPkuMGZNakpXD8Wm6XhyYTMfpW1
         Ugvbn3F58i6iMdEjY4DgLsUTY6blaKbwlALLItDzlir2091IL2P2u2RDI8dlvzL7cbZV
         5vlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfmXt1Gc8nNeTVgI0mwlCbJzHpiTmGjA/4WGBhtRrV0x1FP+HpC8ocZ/pUKyBHhnz9RcxNdVf7JMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEg4TvSZHL6ROxCF/ihtVd9TMriP29hs5MtwRUuL2bB4dSa3XR
	yyV9g94soJqnHjEf2EZIkPB3zdJTkG4H/a+qLrpVeZApXWWHLG1Jw0PApnliKUZaXSUOC9TeHW3
	MtASb0I5gIiMenpjjITScvZeXD5KZG50=
X-Gm-Gg: AZuq6aJgncCO7/0tQcwu4PvPZhv4MhpsnQJi4ZLq5ppIlqHFgzTuUeb4E6Zn673mwvy
	j1xhP8Fvgu7P64k9FcCiGupFmOdldLAZTFCXSMhcKb7o2Zh8z8Gqg0P4fzL80E4MCkgaqngyeGw
	ljqPj/xrRhxSxO3sIRIQP6vMs0Pr22ehI0wJeN2e8PccfqNTkSE1MvSdtbus678/dUenEfV7rJN
	5b0iG7bIS6MHwcG3++ftX3OJW/+0XdmkVQReln37rbx4auZ10Xpm8FFwOC8LHUZ2ro0I10CzSzH
	0GPY8Wv/RTLm5uic9WaoTpQ=
X-Received: by 2002:a17:902:e845:b0:2a9:634d:de98 with SMTP id
 d9443c01a7336-2ab3b1a7943mr1909285ad.23.1770847887796; Wed, 11 Feb 2026
 14:11:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211151115.78013-1-leon.hwang@linux.dev> <20260211151115.78013-6-leon.hwang@linux.dev>
In-Reply-To: <20260211151115.78013-6-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 14:11:15 -0800
X-Gm-Features: AZwV_QhJt1PQFJH8kXPiKEX8G0i2EkGRQG9mZq9x-DDfQaPpKPgqIRSO-GyXGqY
Message-ID: <CAEf4BzY3GA+860RODLaXqqO3j5AgJ24pmKU1yv3+gHJpy0DvNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 5/8] bpf: Add syscall common attributes
 support for btf_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5832-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: DDE35128039
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 7:13=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> BPF_BTF_LOAD can now take log parameters from both union bpf_attr and
> struct bpf_common_attr, with the same merge rules as BPF_PROG_LOAD:
>
> - if both sides provide a complete log tuple (buf/size/level) and they
>   match, use it;
> - if only one side provides log parameters, use that one;
> - if both sides provide complete tuples but they differ, return -EINVAL.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/btf.h  |  3 ++-
>  kernel/bpf/btf.c     | 30 +++++++-----------------------
>  kernel/bpf/syscall.c | 11 ++++++++---
>  3 files changed, 17 insertions(+), 27 deletions(-)
>

same remark about user space only log_true_size, but overall LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]


Return-Path: <linux-api+bounces-6359-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G12KMjLDGrAlwUAu9opvQ
	(envelope-from <linux-api+bounces-6359-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 22:44:56 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E52584CF3
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 22:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 457F83010BB6
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 20:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBFF39F162;
	Tue, 19 May 2026 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NX92oBfx"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D23403E4
	for <linux-api@vger.kernel.org>; Tue, 19 May 2026 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223492; cv=none; b=Y2LrrNS7ySdnlnXvki8R0/Ih3+xUq/dIsJeoxo3LSwWjQN2xAwfuL5mK7NNiUWK37n8K7gjIbXzHG9pclC+0DKN31X1qON1aepz+r8eIsJoiObaOOlY9JmwJd2od9HFe5VoNmKJkY0vE4/WEBAq3xK3a9+IPq1t3xj5zCCpCcP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223492; c=relaxed/simple;
	bh=IlqV/VzCv/lG2dRMW+ifrWeImunHWAg0y0uAQ+quOFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBLcW7MOs8VmNJCCoceeu64xAdNtVSY6I9QhdB+5OzfTI/AOzhEpNZhGwjUxdvjLOWEg3iAcFxEz+OD48gfA18CIUpriJhwFBNGZXDNTRz3eFL66if7nbChE5yutSuV+svvgW35Ej7XdOe+fes23USSLhICfpLwu3tQ+W5Au99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NX92oBfx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so9489419a12.2
        for <linux-api@vger.kernel.org>; Tue, 19 May 2026 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1779223489; x=1779828289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNHrtYaT2ssFGIbGBvuTdTsSFVUxE4rajD3tzQ6hD+o=;
        b=NX92oBfxL+xfoTBl1Rp3BB2bdQYBxvCqgRoPuCo4sC8J77LkD06/pTb9/aVzqletHi
         Oh6R/W1vXK8jxb5MPTg7rgvOg3cCAPEZNDRIayXN4FcD57AMvYQ2jb4pUJaVtA447gjf
         PskPTbNKexNxSFQHO0tp4LG6ov6uek952lryw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223489; x=1779828289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNHrtYaT2ssFGIbGBvuTdTsSFVUxE4rajD3tzQ6hD+o=;
        b=olYC2DHTemA0jm7+42HFzo3Kqapd71Qudz80Ug7WvaG/WH5QCFbU4N82ypkSwYHdwm
         kkOLMblSY6bdn0OIknZBZiSYXX70JWsTrdWtdCEMrt55fuQ6FQ5Z4ngqpaZYLq9TR5KN
         jUyLtiMCxHuFkbdYN9dmHrgmzlz1n2csiKoEe51sZgUHiDlZwJIg+qFzHw741JoLZCCN
         PWlbbpW8zqEyy1Fn7lHJ0am0irv04YZ5eEoQAHLyT5UjP/v5KNdaduUCi8Fdx9iUIU8W
         m2ZKmgegWeVS4/mNg/OuBum+Ya/ckqNpG4NCocwMokmcCdlUZmO7yMGP3jfrBKcqgHiq
         WTkA==
X-Forwarded-Encrypted: i=1; AFNElJ98ZiQ/RZ1sqLeDk77VYX37I8+MRVMgUGbrSXn3SktLaJgu0o4VqPgpVgVLfk3M6U98Bl4VVdHiDWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYzJ7pMe8nQwS19GcPVnKwhPuCBp5Dj33AgiMAtDrjgZAJqdu
	l3eHI3ZrwwuyiL9B3Jd8r4+Uq2t/gE5AknpaIlAUWcAE7M+eiyJfjEajYK2XPCJ2YSNq/v5Hq8v
	JPusLDXqEOg==
X-Gm-Gg: Acq92OF2TXK8yLNJZS8agGNIujSg/yJECz9N0VPV1EaGnTw08s3DOXefNUKW81bHIoT
	Pld6of9uRVKT4Iqa6zwBHgi983LYKuXTXHTBVsLYRmSbhjdjKUxjEEL/yeOr6ABwwzpnR79ihDk
	JyICP4QqnJ4WICLGa6T6X5Bs4L8U1TIAA78giGerRMcAcQNrZKGwEPEKT/zujLFr9huMzlUZEop
	uwXO24ssrwFs66m1YGDvBp3K0Xq5EniNpLaE85dYmWF+obckMeNfbmrdJ+KUrkSMxrSLECtpVMW
	4e+CqMiVm6+U1aCcRB9kLeNEMIJVt72UKkzVH+ALbEeWwjItUawSo1Vgu7oObh/5Jy4/LSYtku4
	rDgOLV+YJz4Il2eNZ6PhQwYHQzpP6Y7/DqdRn4pqV6rv1+JJ1zz5GHPCrA1vCEqLqclEcrhqzNh
	0D8gTwP9sRCUCMjXNfRFlYan17rHL5lKtBRsFlmDajG3zuzo6+QT1HVvxYEzAZBNn9DxE4IhaMF
	OHaz3v6eCA=
X-Received: by 2002:a17:907:94c4:b0:bd7:f75a:817c with SMTP id a640c23a62f3a-bd7f769c461mr626791366b.17.1779223489491;
        Tue, 19 May 2026 13:44:49 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd7bbae7a93sm310114966b.22.2026.05.19.13.44.49
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 13:44:49 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68719234fd8so183839a12.3
        for <linux-api@vger.kernel.org>; Tue, 19 May 2026 13:44:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/HClXYKQAxDzzd/G4JrUmuIqSg3pQrbBe7C4VM/5lovPzDdpSCSxQqpuGHMwyhKsFSiw8Xe6PhLv4=@vger.kernel.org
X-Received: by 2002:a05:6402:5292:b0:678:93eb:c9fa with SMTP id
 4fb4d7f45d1cf-683bd094604mr11729034a12.15.1779223094548; Tue, 19 May 2026
 13:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517-tonyk-long_name-v1-0-3c282eaa91e2@igalia.com>
 <20260517-tonyk-long_name-v1-3-3c282eaa91e2@igalia.com> <20260517223419.3262de7c@pumpkin>
 <d4d6cf61-568e-478e-88d6-01b769d7eded@igalia.com>
In-Reply-To: <d4d6cf61-568e-478e-88d6-01b769d7eded@igalia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 19 May 2026 15:37:57 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgBdK5iRf1NdOuMT0-+sjxUc8QAU9vr66jBBzY6EFDtUA@mail.gmail.com>
X-Gm-Features: AVHnY4KL6sZr2VANjPBDeT072XXr6vvQupwTPfEIQuzU7GSuDKYQKMbqdbBGZ8c
Message-ID: <CAHk-=wgBdK5iRf1NdOuMT0-+sjxUc8QAU9vr66jBBzY6EFDtUA@mail.gmail.com>
Subject: Re: [PATCH 3/6] string: Introduce strtostr() for safe and performance
 string copies
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: David Laight <david.laight.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, willy@infradead.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, Yafang Shao <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com, 
	arnaldo.melo@gmail.com, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com, linux-mm@kvack.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6359-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,linux-foundation.org,suse.com,vger.kernel.org,igalia.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linux-foundation.org:dkim,igalia.com:email]
X-Rspamd-Queue-Id: 23E52584CF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 at 09:37, Andr=C3=A9 Almeida <andrealmeid@igalia.com> w=
rote:
>
> The problem is that as I'm expanding current->comm, the source buffer
> might be bigger than destination, and when we truncate the string, it
> won't have the termination NUL byte. So we need an extra dest[len-1] =3D
> \0 after the memcpy.

What's wrong with just using strscpy() with 'len' being min(srcsize,dstsize=
)?

           Linus


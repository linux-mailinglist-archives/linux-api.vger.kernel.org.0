Return-Path: <linux-api+bounces-6597-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ryu1BE7sKWq8fgMAu9opvQ
	(envelope-from <linux-api+bounces-6597-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2026 00:59:26 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165E66D44B
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2026 00:59:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qEn4tIWy;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6597-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6597-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06DD130A81AB
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 22:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE13749F3;
	Wed, 10 Jun 2026 22:59:23 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C68369D45
	for <linux-api@vger.kernel.org>; Wed, 10 Jun 2026 22:59:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132363; cv=pass; b=dQFv1ZMRA7VAw+ykucAsOEblGOhnB4T4HkYd7pat3W/Ckbw6CgTRo6ihaFTTrHF7U67nxnhO3KDOWAYEFw8dB+zDseloGfk00nNNEgSeSvtAQSh8HwzqxYll3ikk8MvPZ+sp34ngU45l19Q6yMrl/zuIiFMM2Ssmr0qlV2+B6ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132363; c=relaxed/simple;
	bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqtJW4ZyOZ+KVtoIilTwHHbPw+FMRoS9SYdIdOlN2+80am3jZ9B5/50YdwKeqKYJShmGptY3YelfVU8Q0nXi6vYrj4j1nTnEu1uSHDEoanjAmoHRgjOnYjk2iqGlRMKVYe3QHaQBykM7xl9i/79qdlRbYHTQud0hksONBLQk07w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEn4tIWy; arc=pass smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so14432079a12.1
        for <linux-api@vger.kernel.org>; Wed, 10 Jun 2026 15:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781132360; cv=none;
        d=google.com; s=arc-20240605;
        b=cqSd6Axrxl7P/5Y4M6Jn8DC/IDKOlZvyZo6tK1LKQ0ib2C+ZY5Vg47muWf0PrULdnh
         yBzmUihNhVtkQ0xc51YChlGykN7agGbpKsjJNpQL8k+qeP1gsVD2kzwKuBr8WFZ+GSCX
         r6/oSi/TOfGKh7AEKzsAfW3oENzKnG8nG+N7xEgmOQ9N3KCguhapOzqsjy3mZsVac5A5
         zk6QY+Iak+BQ5SiOfPCBvOoWChOg/92uKv+Z2yeTHpmJZvvHqkb+yX1HienG/JrbS0dB
         xg31f4Hjmai9bux4lfqCD+MpC84lq/XWXcei6intucZ9rcC6GonNTIUbOzI4UryZwdeD
         0kYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
        fh=bxsRCrulu0MSSDRoJCI7CweDLAwKDgV+RbR3RNwLkIM=;
        b=Bocutag8gXpOS9g6tOLKR4paHdfM/YQqDsP0mgM47bWgFgmYbFaV5eO7YUrjiZaFUL
         hyENzR/kh5+yKQzNjEvcueItJx10EQhf7AqMmdXiQpnufT0M3Dp+weI9hSEAncpVKz7f
         2k6VPdXpwXrKz0+G1Nx2y/FKvtN/9FmLwh9+pHvCd0tUCwD+iFo+k/yYAjQpwC3L2l6B
         jT8jZWKYmV46uWlJrBT7OQWkk2cSZCfc+gL0PaHfwZX8U4oGac4y6g3b75D+L5IA4/qx
         01P6z7tbNSPDeGN8YbHAyhGG9f3DHkuvjKye7dLgWbSbl9Bbsk8SmXxwduj7fUlEypSg
         RpjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781132360; x=1781737160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
        b=qEn4tIWyzGrvjUgvO574u6bAFB8n1Bu79d+gI2oyFcZSTG2PxL2qFkS7fainrrfrV8
         JBMIOmi08eKO7E1Aj9XPkaMb/2J2V2mSI7ole22hdtrek8TO+kg6IQXol5thJJGLcXMe
         TvO4cEC9g7XMzDu8Gbw6Hh4RTK6UDyqZgmnbe9NiDrFgl0sQHcsJgFHeiKnJjdk481Pa
         w4sUsM1k/OBPwW1b8N0SWLEtBrHQN5WlmEpsaRUJglIosxsDBsE1YWDA5Rex2p+aGKkL
         kFPkBD5MrcWH4toiaQBJb1V1kvARUTSG8MKzUg5hBPmu5IGHxgP6iZ423hIxmHohe/Ax
         vulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132360; x=1781737160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEzIwJCTEGfUPAMEdjx97uQ6KkcVMIzM//6ziaFjsoE=;
        b=N0kb6xzJpjadcRHjU+89POQBTSQfjxAF/O7NXYIg25g4n64egxRiH76Z5WB7Gi7hZJ
         8RqREWBhIxMtKAgs4ZHEUfXzBK4T/9zV0P08ExUub1qJZrw5A/8/tuaX+AEOB/er/+r0
         E4gj+qcziSVI4NXaZ2vMtkDrG1eNa1teOjv3LzWvmON57EYr7ouiApac5ErHTc5ifhnT
         HwlFgLYR1Eu0sUlsyjZV7WsxXUGCOacvhBG/wnq/t66k8YmZfzqVB3WclktFeeqhjpd7
         aPoxDVq2Y5MDzHDqiYNyrjtrKicjz/I9/RAZsYtswz9yWu3I2keAxETh13RpcrpDAraS
         vBvg==
X-Forwarded-Encrypted: i=1; AFNElJ/S6BsDdRbpzbfqc1wAiGSqlVJl6EFJMQ4wPq/G+mNqRzh6UXZUB+DeK4wg8sw5V9sqrXyVyhWqOiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIPN60yPOphHgznLiYv4zMyAMqooSl0rqafZvhPajUfJk2f5Jm
	w0rl5Ny7bSP+L7B8qQjobQ0TyD/5h3vOIZAVDNW3186P0GJvoohrxI4FPdnreG0fkMvFhAMN0OE
	/hglvuWYNJMEqNVlsgDbjWCUDzzSHIPg=
X-Gm-Gg: Acq92OFXuy7UYI9EcFdXuOdPkYb4khoM6TE7nHpMI6q+pEIl6NYAnBNxmPpLBHISypZ
	OQtIKILlpkXBGZncw8vqWtG6gxzP+tog9YS20QGPxtu36qkUtZkg6Fva0geaqfJ3W1fQsZCb5zP
	nV8VFka+VWyMb0Es8YsoseZ829lcX15EK4RhTxxwKMV4vD64hKk7o2zoKjuvyM6o/xoX//cZ8Ur
	HYafUVNa+kyZ+xLzBnUYFigQ7Kv2BFG/It8fPxG+1strXhVNMQziBvalHbjv09Iy/j3rRvl/NmZ
	Uuqx3GIFZ9ATcifOZDnR5PiKYJeWxuv6P5Dkl3FSf+dxmXAHfQ==
X-Received: by 2002:a17:906:6a1c:b0:bf1:ac1d:94b0 with SMTP id
 a640c23a62f3a-bf373eec601mr1347239866b.35.1781132359944; Wed, 10 Jun 2026
 15:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528095235.2491226-1-me@linux.beauty> <vealb52tv5suireenkke4lul2l3wbnaul2rp3ea545ly5wa5ty@yk3aksvp7skt>
 <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com>
In-Reply-To: <CAG48ez38OEE8ZPLyU6nr9=cYx-hMsdoh5WRrv-GMZGMDKyyOTA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 11 Jun 2026 00:59:08 +0200
X-Gm-Features: AVVi8CdthNiQaFys6OtVKdO_jwR53Q5mhKecw8_q9iDf4OCUN-Dc5Jgmeo3bc0c
Message-ID: <CAGudoHHq-AKfWwRXuVbmz0B3PPK=Z7gW=HeUYOe_8k4fvPJFHA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/13] exec: add spawn templates for repeated
 executable startup
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Li Chen <me@linux.beauty>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jannh@google.com,m:brauner@kernel.org,m:me@linux.beauty,m:kees@kernel.org,m:viro@zeniv.linux.org.uk,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-arch@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:x86@kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mjguzik@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-6597-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FREEMAIL_FROM(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5165E66D44B

On Mon, Jun 8, 2026 at 5:02=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Thu, May 28, 2026 at 2:55=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> > This problem is dear to my heart and I have been pondering it on and of=
f
> > for some time now. The entire fork + exec idiom is terrible and needs t=
o
> > be retired.
>
> It seems to me like vfork+exec is a decent UAPI building block, on
> which you can build nice-looking userspace APIs, though I agree that
> this is not an ideal direct interface for application code.
>
> > Additionally there is a known problem where transiently copied file
> > descriptors on fork + exec cause a headache in multithreaded programs
> > doing something like this in parallel. I only did cursory reading, it
> > seems your patchset keeps the same problem in place.
>
> I think we almost have UAPI that would let you avoid this issue?
> You can use clone() with CLONE_FILES, then unshare the FD table with
> close_range(3, UINT_MAX, CLOSE_RANGE_UNSHARE). That is not currently
> implemented to be atomic with stuff that happens on other threads, but
> if we changed that, and it doesn't provide a good way to carry some
> FDs across, but it feels to me like this could be fixed with a variant
> of close_range() that removes O_CLOEXEC FDs except ones listed in an
> array.

Suppose you want to exec a binary with the following fd set:
0 is /dev/null
1 is fd 1023 in your process
2 is fd 1023 in your process

You have tons of other fds and you don't want any of them anywhere near thi=
s.

Clean interface from my standpoint would avoid any unnecessary
overhead and would allow you to clearly specify what do you want.

In this case whatever the interface it should provide the ability to
map 1023 to 1 and 2 in the child. With the current syscall set you get
refs taken on these on clone, then you have to manually dup2 these
which is separate syscalls with extra atomics on top. A fast & elegant
solution would allow you to tell the kernel directly where to install
the 2 files.

Also note in practical terms userspace likes to closefrom/close_range
anyway to get rid of unwanted fds which happen to not have the cloexec
bit which is yet another syscall to invoke on the way to exec. A
better interface would instantly avoid the problem by not copying the
unwanted fds if not asked. For viability for use as foundation to
build posix_spawn over it such copying would have to be supported of
course.

>
> > There are numerous impactful ways to speed up execs both in terms of
> > single-threaded cost and their multicore scalability, most of which
> > would be immediately usable by all programs without an opt-in. imo thes=
e
> > needs to be exhausted before something like a "template" can be
> > considered.
>
> (I think probably a large part of this would be stuff that happens in
> userspace, like dynamic linking.)

I have not investigated userspace, even putting specific APIs aside
the kernel has *a lot* of avoidable overhead.

>
> > Per the above, the primary win would stem from *NOT* messing with mm.
>
> As you write below, I think we have that with CLONE_MM? The C function
> vfork() is kind of a terrible API because of its returns-twice
> behavior, but I think if process cloning with CLONE_VM|CLONE_VFORK was
> wrapped by libc in a way similar to clone() (with the child executing
> a separate handler function), or if it was used in the implementation
> of some higher-level process-spawning API, it would be a perfectly
> fine API?
>
> Or am I misunderstanding what you mean by "messing with mm"?
>

I was not aware of this functionality, let's assume it indeed works.
You still have the file issue described above.


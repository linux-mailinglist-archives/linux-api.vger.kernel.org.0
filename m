Return-Path: <linux-api+bounces-6533-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VF1+HEeNIWoLIwEAu9opvQ
	(envelope-from <linux-api+bounces-6533-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 16:35:51 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC8640ED4
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 16:35:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=EtivtKQZ;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6533-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6533-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D002F32E1A03
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 14:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDB148A2D2;
	Thu,  4 Jun 2026 14:17:34 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718F48A2B3
	for <linux-api@vger.kernel.org>; Thu,  4 Jun 2026 14:17:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582654; cv=none; b=dykDuGQeitqAJWnlW4dMIlYylQnVp32e1iCL3BCKId8fiQxhXJ0Q8ddFxVj/Dn1/iPzJzTSPaRUwwE1nGcptha0ZvVN3yCBhnVSvm6sAGNV8VJxK/DCxo//bLfRMhbEU9t+BH9xLS3TJsvTl0jAcdZ7qLFcbi9Ml/QxOmid37dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582654; c=relaxed/simple;
	bh=Ecbl/t5OYeJ4mb+vVa4qoGM4jTXP3pkfic84pGx71kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLOATmzNf7rqcR+6Yt7z9qKW+c2AIYWfTPa6+9IhnZ0ZxYzjrtVEZVm5szOu6/iZYRhlAsmSG7OKEfSs1UFR5hsoOUG3fOE9uDUwKcZgHJ8m4yX9XbgrEmhT1/Mlnp7l6kLMkRMZVQ561iUuAq8eKCZEefIKtAvjvhZ6V4lU1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EtivtKQZ; arc=none smtp.client-ip=209.85.218.47
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bf046d4da1fso78160366b.3
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780582651; x=1781187451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAn7tUi15DsxPNLBVxb55DsaCLzi2ItCgQT81dYuAAI=;
        b=EtivtKQZ0UaWvmOomgvBh7aW1IGtzIsa+LckJO6Fn7867x5Louh1caqGC+O6AMlo0V
         577exvdCSWG0rmMLXb6f/xw1us8Bpv9YaOrTck6lFUS6N0Lcq7CrFGs32XG4IPF0IPAs
         n/QDfh4TcIoRUAMrcKfAfa0yRU1w+t7kptlWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582651; x=1781187451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAn7tUi15DsxPNLBVxb55DsaCLzi2ItCgQT81dYuAAI=;
        b=ZRGtjAGpaQx/rUnNUupn9sOKGfkGCNGRerI5EH2ZEnW1XIkwelxSz+3Ob9MZZaoewZ
         VUyEwgFW5OcqnM4r+HpO+qyoOUxtXXNsoiltQMo2JnJIwjHA498fuZgf+xdAdu45Y11p
         S/17N66kJYSI0v6pv3LYYtivIQv1ADuaUKiK0msGDz9mahA+UjyB2882776Y97Z5Qc3+
         Zib7ow/DyPSaQfQQNrxoLGJGA2TQr0DR1vPoWSWTj3FZ9NPm12nhDPOfhtevcn3fJWRF
         ZMD1HpGUmquJtpaRLPx/91OW5hZBmnEDyFtvFJ4u4hF21IeSvLGfU6guqOYSC4DFtjIN
         Urlw==
X-Forwarded-Encrypted: i=1; AFNElJ/UytIkwFnCM9ipJ9snuE1OblxxQnnl/4GAzgfRgidUP0BFgB/EW1Y+ArfBkPM/qpKq7a/EaAissME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVu43MfE815arE8SshSCH1OTasfRm1Fbz/RnA9YfLqgoqwrxFi
	jhq7fU+bZtJxU9Gw8UzpXj0EV3ekvaWEa9Iezm+myaPddBiiYgPCre/rG4EZ0Q4vUwXHiAZJXXW
	/Is5Vqy9WuA==
X-Gm-Gg: Acq92OEDdgDHZtu+qM479AjAhkqGW0z+DuFcv3wCiJrn4AfTWOJUCBQN9qbTmQyKmXG
	CpY137CJJiRcd2VJQTKvswp7iAIibszhZRnJ1QlSv+v94Ls5HmDtK0NzMg9IlOE9IAWkGzTxmep
	N3xZdf9aDTXYlv0PkXUHIpzcBFuwFI4zRbVnKeL6Bo8fjIDwS9u2EILg++H9GU5XxYuR/+jPcHA
	M08KFssxP50+7CPEVLJgVd98UWmT1B4jcvJWNWSQow8bmY1jsx2YfZ4uxs/0sEz2Rknim2L6eJ4
	slP0IFZ5F739HIilNSZtg1jTyGNd0trdwMNckfbYFt0R4/8BLFJyifptik5kQ5+vGxnG+QqJsgL
	eV1jVOf9pt/V+EgVMlONRqpV55IdqcM48kv/+gm+cVs04bdixwMzZHuR4ovBPaxUg525ZWtNfsm
	abRb6LoBxr894MZlsUdM1jtpkXkJ72QjEpRli8IVeEgQ7XRcM659jPSnCRUSOViSi2YNcY43Hbi
	iq7eCk8FzM=
X-Received: by 2002:a17:906:9b4b:b0:bf1:1d19:cf95 with SMTP id a640c23a62f3a-bf11d19d67cmr266033166b.12.1780582651186;
        Thu, 04 Jun 2026 07:17:31 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0553fd86csm310797866b.46.2026.06.04.07.17.28
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:17:29 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68ca6f01079so881536a12.0
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 07:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Ax731HClflrjDafG9XPGFsXFSDnAEjgYBiGrLTHvXuofhJM904VO1rpKB0HfFfgPTBvHtPJ5DRjc=@vger.kernel.org
X-Received: by 2002:a05:6402:5296:b0:670:8add:2b8d with SMTP id
 4fb4d7f45d1cf-68e72739555mr4177743a12.24.1780582648047; Thu, 04 Jun 2026
 07:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
In-Reply-To: <20260604100609.6b37f500@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 07:17:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
X-Gm-Features: AVVi8CcQ0yaowxPCFqM7JCGZCz4oCGBQaQ6sAmWXnRpVnXINniRqjS3Vb3FRVpM
Message-ID: <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: David Laight <david.laight.linux@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org, akpm@linux-foundation.org, 
	axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6533-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,samba.org,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-foundation.org:from_mime,linux-foundation.org:dkim,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03CC8640ED4

On Thu, 4 Jun 2026 at 02:06, David Laight <david.laight.linux@gmail.com> wrote:
>
> Something needs to ensure that the high 32bits of the fd get masked off
> on 64bit systems.

That something already exists: CLASS(fd, f)(fd);

It ignores the top bits, because 'fdget()' takes an 'unsigned int'.

We have been a bit random in how we declare the system calls in
general, and we mix 'unsigned int' and 'int' and 'unsigned long'
pretty much randomly when it comes to file descriptor arguments to
system calls.

fs/read_write.c in particular uses all three cases with no real logic to it all:

  SYSCALL_DEFINE3(lseek, unsigned int, fd, ..
  SYSCALL_DEFINE3(readv, unsigned long, fd, ..
  SYSCALL_DEFINE4(sendfile, int, out_fd, ..

but then anything that uses fdget() (through one of the helper classes
or not) will simply not care.

Does it make sense? Is it pretty? Nope. Does it matter? Also nope.

                  Linus


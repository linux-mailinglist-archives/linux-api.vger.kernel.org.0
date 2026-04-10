Return-Path: <linux-api+bounces-6078-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BDVLK+32GnnhAgAu9opvQ
	(envelope-from <linux-api+bounces-6078-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 10:41:19 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4A43D43EF
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 10:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 959E5303E49E
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2026 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9513ACA78;
	Fri, 10 Apr 2026 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeBBSPat"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797FA37AA99
	for <linux-api@vger.kernel.org>; Fri, 10 Apr 2026 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810133; cv=none; b=BadDP4AUc3ZwtHH26xZh9FQypAjwRWPxmBGFlgO/DTu3qcv2B0q9WhkfT3KibJAGP4I8GWhdttSJgGhGmx9wkXmmkUbkAmuYR2RRIJVQPIejyL8o4Z9rVLoprqKymLW+JUO3KC2K9oQ5slnPQzMe9CM1h0KCCDflu31U0bH6rSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810133; c=relaxed/simple;
	bh=r3o7TyAvYn90Ww2v104Gl1JFBfu4uAg42L7TMid5ils=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrtBXeflwPIGjAeplIU8DHqUFvVukZULtoRBMFafvwARj3BAkAZxQR3i1RqMp/1pBGqsB1m8bKN2PJHGAf3xTPWUw5uSBKvUcjjZP19/+9OX9McBafiw3y2zfslAHmpcnx2f82dia4M8u6QLUuMceJqEmFPK82P46jrx91sGbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeBBSPat; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso17415325e9.1
        for <linux-api@vger.kernel.org>; Fri, 10 Apr 2026 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775810131; x=1776414931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDrRORXqwjO/w1YCwauGfrHI2K78vJz+M9V6gxkImmA=;
        b=NeBBSPatXkARY4wJAhpBXUh5D9EsafolV5UnSA/aM3pviiKSYNoRjr6gLEboV+wLih
         H8r+cO5jAp8I2vG00Ly2KDHQ2ZrRUwU/jM4N7RWUs6HN+n77p2qE7HUA8RSmt+IRyZUx
         RmXWg33H2gmyHW8xv1gdI+aY3YvA3H2NT3Bej8ZP0eQemcLOjYylaNGDyJ6HwiFEBk0x
         LOwLJbdXxk3VqlwoRoYcdBDiet14khYwEkVJLdJDaCdnxLrbL3ocalbByPiIaH/gpQwy
         zkdb2Yfsjo84JC7jp6kD/AowiAb/ZOBf9iPPFFpwccvKmNEY19+EmsQpCZ8RQID/SRnw
         FQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775810131; x=1776414931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDrRORXqwjO/w1YCwauGfrHI2K78vJz+M9V6gxkImmA=;
        b=fIHW5h1NG14wRi0gQK7YMucYtbwoD5Aa8ijC2XfrDEAYb+rNkvou72OER1+X3mP08B
         M7k78akQmiQ4C0qr8uVEb0Z0Rb+JxTLkrM+BcsTlg9TS54wS32fX0j5yezIqBRlSp4aj
         6A3dvBiynNv14FIz2bsqFRmk7+KcXfPkf5sYmbBX6aalty9JU3MIsqECaJ2Xi4udrzMX
         qy0EJlXh2Ke4doT+9J8TXMmulFJYXnfvJO7SZPS6SH2NO7uqxKeQ4ZKrpM68pxwnz1zd
         PkQ5A30BmvhHwaN727Q6nSJ0mdVm+oBBjP6/dpHW/LBZOkoI4LMpXTJFlbPv1HqWyR4o
         PHig==
X-Forwarded-Encrypted: i=1; AJvYcCXjLnCnxKDR5vc/fc6u/ppGY5OLZX/cpDd5Xznybvjl/PkmzKi0hyPzw6aO7OCX0f3Qo3GAx11Aigc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyygEwiKA8FIyoDkzPs9DvNCkLIqRR8ufAJY0fpuaxjVSbDmW+M
	FIHKuLga7EZLmZpLLz1yFjuW4FS4lgyAQ1eHv36y9bvO3+0vdcWgNbuN4vF2
X-Gm-Gg: AeBDievowAjzkvS6V5XHFiGJg3e4yUqjKFu9kUP5kT/pux0tc6wAPwUG1YA7Sfo9Q0M
	3/ttI4yMGgZsr93OQv6RwNqlTuCLd61vtZMGXARrYHIpZk+RCdHZAYv/CVuAA8YeyLBzXCVM5AV
	SEge/54lrhPtz6Xtc1tJgBzgJmgIAqi3n4EzSfSuAUgfUPvV1GnnbS5RYuE7W97fuEoMiHM26hf
	dW92rcAbRb+DLPXZE9rBq0r5Ebk4gaIkQ9HQxqslyGlZovAmDme/Gp/MNscT1W+0mY2GNOn0jQn
	oczYMG0RTwMw0N+4CHh9eVccQ+8Ucu5oPVI8DQTXU7zq4Fsecq7n8StEhtwfPH5/ldkN335n3bV
	kAyx2RgLEbQIL6VHcjwW8uwaS0uNmjg4HIb4jiX6Fhms+ZOuaL4chxQjVCqfg52m+83/1aQm/2H
	HPc5l+4BtE6yhM3/EJexOYdh/IyeiZS4rRUFgCOaLoA4C0YeXv1ZF5TMohUF8rw5obuxW6lMGNm
	PsWrQ==
X-Received: by 2002:a05:600c:674f:b0:488:a82f:bb9b with SMTP id 5b1f17b1804b1-488d68cb47amr27836175e9.30.1775810130619;
        Fri, 10 Apr 2026 01:35:30 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-188.brest.telecom.by. [46.53.134.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5cf2e70sm27761365e9.0.2026.04.10.01.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:35:30 -0700 (PDT)
Date: Fri, 10 Apr 2026 11:37:23 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Florian Weimer <fweimer@redhat.com>,
	GNU C Library <libc-alpha@sourceware.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: Avoid reading /sys/kernel/mm/transparent_hugepage/?
Message-ID: <d095cc40-5217-4318-ae2e-40e5fe3be47a@p183>
References: <CAMe9rOrk20jCXO_Bun4LK6M3fd_8HzEtAu94FW+-xSkwNiOt7w@mail.gmail.com>
 <lhupl47e0lc.fsf@oldenburg.str.redhat.com>
 <CAMe9rOpf2f8u4ng+nnaqEYB3bUvvVPu3mGv7bt=5xfzDHcMOFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMe9rOpf2f8u4ng+nnaqEYB3bUvvVPu3mGv7bt=5xfzDHcMOFg@mail.gmail.com>
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-6078-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adobriyan@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ld.so:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gnu-tgl-3:email]
X-Rspamd-Queue-Id: 1B4A43D43EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 03:40:30PM +0800, H.J. Lu wrote:
> On Fri, Apr 10, 2026 at 3:28 PM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > * H. J. Lu:
> >
> > > To enable THP segment load, ld.so opens and reads 2 files under
> > > /sys/kernel/mm/transparent_hugepage/.   This requires mounting
> > > /sys and is expensive.   Is it possible to put such info in vDSO?
> >
> > Alexey Dobriyan proposed adding AT_PAGE_SHIFT_LIST to the auxiliary
> 
> Does it cover
> 
> [hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
> 2097152
> [hjl@gnu-tgl-3 linux]$
> 
> > vector a while back, but I don't know the status of that.

Status: nothing happened.

> How can we get
> 
> [hjl@gnu-tgl-3 linux]$ cat /sys/kernel/mm/transparent_hugepage/enabled
> always [madvise] never
> [hjl@gnu-tgl-3 linux]$

This is not covered, see the link:
https://lore.kernel.org/lkml/ecb049aa-bcac-45c7-bbb1-4612d094935a@p183/

PAGE_SHIFT_MASK should be folded into system call probably.

